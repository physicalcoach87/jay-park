-- ============================================================
-- 006_rls_prep.sql — RLS 실제 적용 준비 (1단계)
-- 지금 바로 실행해도 앱이 깨지지 않는 변경만 포함.
-- 실행 순서: 006 실행 → player-login 함수 배포 → 선수앱 배포
--            → 선수 전원 재로그인 확인 → 007 실행
-- ============================================================

-- ① 선수 ↔ Supabase Auth 계정 연결 컬럼
ALTER TABLE player_profiles
  ADD COLUMN IF NOT EXISTS auth_user_id uuid UNIQUE REFERENCES auth.users(id);

-- ② PIN 무차별 대입 방지용 컬럼
ALTER TABLE player_profiles
  ADD COLUMN IF NOT EXISTS failed_logins int DEFAULT 0,
  ADD COLUMN IF NOT EXISTS locked_until timestamptz;

-- ③ blocks(주기화 블록)에 club_id 추가 — 클럽이 1개일 때만 자동 backfill
ALTER TABLE blocks ADD COLUMN IF NOT EXISTS club_id uuid REFERENCES clubs(id);
UPDATE blocks SET club_id = (SELECT id FROM clubs LIMIT 1)
  WHERE club_id IS NULL AND (SELECT count(*) FROM clubs) = 1;

-- ④ 헬퍼 함수 (RLS 정책에서 사용, SECURITY DEFINER로 재귀 방지)
CREATE OR REPLACE FUNCTION app_staff_club() RETURNS uuid
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT club_id FROM profiles WHERE id = auth.uid()
$$;

CREATE OR REPLACE FUNCTION app_is_staff() RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid())
$$;

CREATE OR REPLACE FUNCTION app_is_superadmin() RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
$$;

CREATE OR REPLACE FUNCTION app_is_club_admin() RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin','superadmin'))
$$;

CREATE OR REPLACE FUNCTION app_player_id() RETURNS uuid
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT id FROM player_profiles WHERE auth_user_id = auth.uid()
$$;

CREATE OR REPLACE FUNCTION app_player_club() RETURNS uuid
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT club_id FROM player_profiles WHERE auth_user_id = auth.uid()
$$;

-- 스태프든 선수든 소속 클럽 (정책에서 공용)
CREATE OR REPLACE FUNCTION app_club() RETURNS uuid
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT COALESCE(app_staff_club(), app_player_club())
$$;

-- ⑤ 코치 회원가입용 초대 토큰 검증 RPC
--    (007 이후 anon이 invite_tokens를 직접 읽을 수 없으므로 RPC로 대체)
CREATE OR REPLACE FUNCTION validate_invite(p_token text)
RETURNS TABLE(club_id uuid, club_name text, role text, valid boolean)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT i.club_id, i.club_name, i.role,
         (NOT i.used AND (i.expires_at IS NULL OR i.expires_at > now())) AS valid
  FROM invite_tokens i
  WHERE i.token::text = p_token
$$;
REVOKE ALL ON FUNCTION validate_invite(text) FROM public;
GRANT EXECUTE ON FUNCTION validate_invite(text) TO anon, authenticated;

-- 가입 완료 처리: 토큰 검증 + 프로필에 클럽/역할 반영 + 토큰 소모 (원자적)
-- 토큰 자체가 권한 증명이므로 anon도 호출 가능 (가입 직후 세션이 없을 수 있음)
CREATE OR REPLACE FUNCTION claim_invite(p_token text, p_user_id uuid)
RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE inv record;
BEGIN
  SELECT * INTO inv FROM invite_tokens
   WHERE token::text = p_token AND NOT used
     AND (expires_at IS NULL OR expires_at > now())
   FOR UPDATE;
  IF NOT FOUND THEN RETURN false; END IF;

  UPDATE profiles SET club_id = inv.club_id, role = inv.role, approved = true
   WHERE id = p_user_id;
  UPDATE invite_tokens SET used = true WHERE token::text = p_token;
  RETURN true;
END $$;
REVOKE ALL ON FUNCTION claim_invite(text, uuid) FROM public;
GRANT EXECUTE ON FUNCTION claim_invite(text, uuid) TO anon, authenticated;

-- ⑥ 선수는 본인 프로필의 pin·언어만 수정 가능하게 하는 가드 트리거
--    (스태프/service_role은 제한 없음. 007 전에는 사실상 영향 없음)
CREATE OR REPLACE FUNCTION guard_player_profile_update()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF current_setting('request.jwt.claim.role', true) = 'service_role' THEN
    RETURN NEW;
  END IF;
  IF auth.uid() IS NULL OR app_is_staff() THEN
    RETURN NEW;
  END IF;
  -- 선수 본인: pin / language / preferred_lang 외 컬럼 변경 차단
  IF NEW.id IS DISTINCT FROM OLD.id
     OR NEW.club_id IS DISTINCT FROM OLD.club_id
     OR NEW.auth_user_id IS DISTINCT FROM OLD.auth_user_id
     OR NEW.name IS DISTINCT FROM OLD.name
     OR NEW.mss IS DISTINCT FROM OLD.mss
     OR NEW.mas IS DISTINCT FROM OLD.mas
     OR NEW.status IS DISTINCT FROM OLD.status THEN
    RAISE EXCEPTION '선수는 PIN·언어 설정만 변경할 수 있습니다';
  END IF;
  RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS trg_guard_player_profile ON player_profiles;
CREATE TRIGGER trg_guard_player_profile
  BEFORE UPDATE ON player_profiles
  FOR EACH ROW EXECUTE FUNCTION guard_player_profile_update();
