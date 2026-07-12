-- ============================================================
-- 017_fix_club_scoping.sql — 스태프가 팀 데이터를 못 보는 문제 해결
--
-- 원인 2가지:
--  (A) GPS/웰니스 등 일부 데이터가 club_id 없이 저장됨(업로드가 club_id 미포함)
--      → 슈퍼어드민은 보이지만 일반 스태프는 RLS에 막혀 안 보임
--  (B) 스태프 프로필에 club_id 누락 → app_staff_club()가 NULL → 전부 안 보임
--
-- 해결:
--  ① 기존 데이터의 NULL club_id를 선수의 클럽으로 백필
--  ② BEFORE INSERT 트리거로 앞으로 자동 채움(재발 방지, 코드수정 불필요)
--  ③ 승인된 우리 팀 스태프 프로필에 club_id 설정
-- ============================================================

-- 우리 팀 클럽 id (진단으로 확인됨: 부산아이파크)
-- 아래 값이 맞는지 ② SELECT 결과로 재확인하세요.

-- ── ① 기존 NULL club_id 백필 (선수의 소속 클럽으로) ──
UPDATE gps_records      x SET club_id = p.club_id FROM player_profiles p WHERE x.player_id = p.id AND x.club_id IS NULL;
UPDATE wellness_records x SET club_id = p.club_id FROM player_profiles p WHERE x.player_id = p.id AND x.club_id IS NULL;
UPDATE session_records  x SET club_id = p.club_id FROM player_profiles p WHERE x.player_id = p.id AND x.club_id IS NULL;
UPDATE match_records    x SET club_id = p.club_id FROM player_profiles p WHERE x.player_id = p.id AND x.club_id IS NULL;
UPDATE injury_records   x SET club_id = p.club_id FROM player_profiles p WHERE x.player_id = p.id AND x.club_id IS NULL;

-- ── ② 자동 채움 트리거 (앞으로 club_id 없이 들어와도 선수 클럽으로 채움) ──
CREATE OR REPLACE FUNCTION fill_club_from_player()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF NEW.club_id IS NULL AND NEW.player_id IS NOT NULL THEN
    SELECT club_id INTO NEW.club_id FROM player_profiles WHERE id = NEW.player_id;
  END IF;
  RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS trg_fill_club ON gps_records;
CREATE TRIGGER trg_fill_club BEFORE INSERT ON gps_records      FOR EACH ROW EXECUTE FUNCTION fill_club_from_player();
DROP TRIGGER IF EXISTS trg_fill_club ON wellness_records;
CREATE TRIGGER trg_fill_club BEFORE INSERT ON wellness_records FOR EACH ROW EXECUTE FUNCTION fill_club_from_player();
DROP TRIGGER IF EXISTS trg_fill_club ON session_records;
CREATE TRIGGER trg_fill_club BEFORE INSERT ON session_records  FOR EACH ROW EXECUTE FUNCTION fill_club_from_player();
DROP TRIGGER IF EXISTS trg_fill_club ON match_records;
CREATE TRIGGER trg_fill_club BEFORE INSERT ON match_records    FOR EACH ROW EXECUTE FUNCTION fill_club_from_player();
DROP TRIGGER IF EXISTS trg_fill_club ON injury_records;
CREATE TRIGGER trg_fill_club BEFORE INSERT ON injury_records   FOR EACH ROW EXECUTE FUNCTION fill_club_from_player();

-- ── ③ 승인된 스태프 프로필에 club_id 설정 (우리 팀 = 단일 클럽) ──
UPDATE profiles
  SET club_id = '40a85372-9505-4cb8-9706-90e8567a62d5'
  WHERE COALESCE(role,'') <> 'superadmin'
    AND approved = true
    AND club_id IS DISTINCT FROM '40a85372-9505-4cb8-9706-90e8567a62d5';

-- ── ④ 검증 (모두 0이어야 정상) ──
SELECT 'gps NULL 남음'        AS 항목, count(*) AS n FROM gps_records      WHERE club_id IS NULL
UNION ALL SELECT 'wellness NULL 남음',  count(*) FROM wellness_records WHERE club_id IS NULL
UNION ALL SELECT 'session NULL 남음',   count(*) FROM session_records  WHERE club_id IS NULL
UNION ALL SELECT 'match NULL 남음',     count(*) FROM match_records    WHERE club_id IS NULL
UNION ALL SELECT '승인스태프 club없음', count(*) FROM profiles WHERE COALESCE(role,'')<>'superadmin' AND approved=true AND club_id IS NULL;
