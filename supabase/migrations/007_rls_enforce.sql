-- ============================================================
-- 007_rls_enforce.sql — 실제 RLS 강제 적용 (2단계)
-- ⚠️ 반드시 아래가 끝난 뒤 실행:
--   1) 006_rls_prep.sql 실행
--   2) player-login Edge Function 배포
--   3) 새 선수앱 배포 + 선수 전원 재로그인
--      (확인: SELECT count(*) FROM player_profiles
--             WHERE auth_user_id IS NULL AND status != 'transferred';  → 0이어야 함)
-- 실행 후: anon 키로는 어떤 데이터도 읽고 쓸 수 없음.
-- 문제 발생 시 롤백: 파일 맨 아래 주석의 원복 스크립트 참조.
-- ============================================================

-- ── ① 모든 테이블 RLS 활성화 ───────────────────────────────
ALTER TABLE block_days             ENABLE ROW LEVEL SECURITY;
ALTER TABLE blocks                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE body_comp_records      ENABLE ROW LEVEL SECURITY;
ALTER TABLE break_plan_completions ENABLE ROW LEVEL SECURITY;
ALTER TABLE break_plan_sessions    ENABLE ROW LEVEL SECURITY;
ALTER TABLE break_plans            ENABLE ROW LEVEL SECURITY;
ALTER TABLE club_role_permissions  ENABLE ROW LEVEL SECURITY;
ALTER TABLE clubs                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE custom_programs        ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercises              ENABLE ROW LEVEL SECURITY;
ALTER TABLE gps_records            ENABLE ROW LEVEL SECURITY;
ALTER TABLE gym_settings           ENABLE ROW LEVEL SECURITY;
ALTER TABLE injury_records         ENABLE ROW LEVEL SECURITY;
ALTER TABLE invite_tokens          ENABLE ROW LEVEL SECURITY;
ALTER TABLE match_minute_records   ENABLE ROW LEVEL SECURITY;
ALTER TABLE match_records          ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages               ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications          ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_profiles        ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles               ENABLE ROW LEVEL SECURITY;
ALTER TABLE push_subscriptions     ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_minute_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_records        ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_records           ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_tab_overrides     ENABLE ROW LEVEL SECURITY;
ALTER TABLE video_links            ENABLE ROW LEVEL SECURITY;
ALTER TABLE weekly_schedule        ENABLE ROW LEVEL SECURITY;
ALTER TABLE wellness_records       ENABLE ROW LEVEL SECURITY;
ALTER TABLE support_access_requests ENABLE ROW LEVEL SECURITY;

-- ── ② 기존 자리표시자(모두 허용) 정책 제거 ─────────────────
DROP POLICY IF EXISTS "gps_records_club"         ON gps_records;
DROP POLICY IF EXISTS "wellness_records_club"    ON wellness_records;
DROP POLICY IF EXISTS "session_records_club"     ON session_records;
DROP POLICY IF EXISTS "match_records_club"       ON match_records;
DROP POLICY IF EXISTS "injury_records_club"      ON injury_records;
DROP POLICY IF EXISTS "notifications_club"       ON notifications;
DROP POLICY IF EXISTS "break_plan_sessions_club" ON break_plan_sessions;
DROP POLICY IF EXISTS "support_access_all"       ON support_access_requests;
DROP POLICY IF EXISTS "weekly_schedule_club"     ON weekly_schedule;
DROP POLICY IF EXISTS "block_days_club"          ON block_days;

-- ── ③ 스태프(코치/관리자) 정책 — 소속 클럽 데이터 전체 ─────
-- app_is_staff(): profiles 행 존재 / app_staff_club(): 소속 클럽
-- superadmin은 클럽 무관 전체 접근

-- 클럽 스코프 데이터 테이블 (club_id 보유)
CREATE POLICY staff_all ON gps_records         FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON wellness_records    FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON session_records     FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON match_records       FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON injury_records      FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON notifications       FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON break_plans         FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON break_plan_sessions FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON weekly_schedule     FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON block_days          FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON blocks              FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON player_profiles     FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON invite_tokens       FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY staff_all ON club_role_permissions FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));

-- player_id만 있는 테이블: 선수 소속 클럽으로 스코프
CREATE POLICY staff_all ON body_comp_records FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));
CREATE POLICY staff_all ON test_records FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));
CREATE POLICY staff_all ON messages FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));
CREATE POLICY staff_all ON push_subscriptions FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));
CREATE POLICY staff_all ON break_plan_completions FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));
CREATE POLICY staff_all ON match_minute_records FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));
CREATE POLICY staff_all ON session_minute_records FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND EXISTS (
    SELECT 1 FROM player_profiles p WHERE p.id = player_id AND p.club_id = app_staff_club())));

-- 공용 라이브러리 (운동/영상/프로그램/짐 설정): 읽기 전체, 쓰기 스태프
CREATE POLICY read_auth  ON exercises       FOR SELECT TO authenticated USING (true);
CREATE POLICY staff_mut  ON exercises       FOR INSERT TO authenticated WITH CHECK (app_is_staff());
CREATE POLICY staff_upd  ON exercises       FOR UPDATE TO authenticated USING (app_is_staff());
CREATE POLICY staff_del  ON exercises       FOR DELETE TO authenticated USING (app_is_staff());
CREATE POLICY read_auth  ON video_links     FOR SELECT TO authenticated USING (true);
CREATE POLICY staff_mut  ON video_links     FOR INSERT TO authenticated WITH CHECK (app_is_staff());
CREATE POLICY staff_upd  ON video_links     FOR UPDATE TO authenticated USING (app_is_staff());
CREATE POLICY staff_del  ON video_links     FOR DELETE TO authenticated USING (app_is_staff());
CREATE POLICY read_auth  ON custom_programs FOR SELECT TO authenticated USING (true);
CREATE POLICY staff_mut  ON custom_programs FOR INSERT TO authenticated WITH CHECK (app_is_staff());
CREATE POLICY staff_upd  ON custom_programs FOR UPDATE TO authenticated USING (app_is_staff());
CREATE POLICY staff_del  ON custom_programs FOR DELETE TO authenticated USING (app_is_staff());
CREATE POLICY staff_only ON gym_settings    FOR ALL TO authenticated
  USING (app_is_staff()) WITH CHECK (app_is_staff());

-- clubs: 스태프는 소속 클럽 조회/수정, superadmin 전체
CREATE POLICY staff_sel ON clubs FOR SELECT TO authenticated
  USING (app_is_superadmin() OR id = app_club());
CREATE POLICY staff_upd ON clubs FOR UPDATE TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND id = app_staff_club()));
CREATE POLICY super_ins ON clubs FOR INSERT TO authenticated
  WITH CHECK (app_is_superadmin());

-- profiles: 본인 행 + 같은 클럽 스태프 조회, 본인/관리자 수정, 가입 시 본인 행 생성
CREATE POLICY prof_sel ON profiles FOR SELECT TO authenticated
  USING (app_is_superadmin() OR id = auth.uid()
         OR (app_is_staff() AND club_id = app_staff_club()));
CREATE POLICY prof_ins ON profiles FOR INSERT TO authenticated
  WITH CHECK (id = auth.uid() OR app_is_superadmin());
-- 주의: profiles 정책 안에서 profiles를 직접 서브쿼리하면 무한 재귀 →
--       반드시 SECURITY DEFINER 헬퍼(app_*)만 사용
CREATE POLICY prof_upd ON profiles FOR UPDATE TO authenticated
  USING (app_is_superadmin() OR id = auth.uid()
         OR (app_is_club_admin() AND club_id = app_staff_club()));
CREATE POLICY prof_del ON profiles FOR DELETE TO authenticated
  USING (app_is_superadmin());

-- user_tab_overrides: 본인 것만
CREATE POLICY own_all ON user_tab_overrides FOR ALL TO authenticated
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

-- support_access_requests: 클럽 관리자 생성/조회, superadmin 전체
CREATE POLICY sar_all ON support_access_requests FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));

-- ── ④ 선수 정책 — 본인 데이터만 ─────────────────────────────
-- app_player_id(): auth_user_id → player_profiles.id

-- 본인 프로필: 조회 + 수정(PIN·언어만 — 006 가드 트리거가 컬럼 제한)
CREATE POLICY player_sel ON player_profiles FOR SELECT TO authenticated
  USING (auth_user_id = auth.uid());
CREATE POLICY player_upd ON player_profiles FOR UPDATE TO authenticated
  USING (auth_user_id = auth.uid());

-- 본인 기록: 웰니스/RPE(세션)/체성분 — 조회·입력·수정 (RPE는 삭제도)
CREATE POLICY player_sel ON wellness_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_ins ON wellness_records FOR INSERT TO authenticated
  WITH CHECK (player_id = app_player_id());
CREATE POLICY player_upd ON wellness_records FOR UPDATE TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_sel ON session_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_ins ON session_records FOR INSERT TO authenticated
  WITH CHECK (player_id = app_player_id());
CREATE POLICY player_upd ON session_records FOR UPDATE TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_del ON session_records FOR DELETE TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_sel ON body_comp_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_ins ON body_comp_records FOR INSERT TO authenticated
  WITH CHECK (player_id = app_player_id());
CREATE POLICY player_upd ON body_comp_records FOR UPDATE TO authenticated
  USING (player_id = app_player_id());

-- 본인 GPS/경기/테스트 기록: 조회만
CREATE POLICY player_sel ON gps_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_sel ON match_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_sel ON test_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());

-- 알림: 소속 클럽 + 본인 대상(또는 전체 공지) 조회, 읽음 처리
CREATE POLICY player_sel ON notifications FOR SELECT TO authenticated
  USING (club_id = app_player_club()
         AND (target_type IN ('all','team')
              OR (target_type = 'player' AND target_value::text = app_player_id()::text)));
CREATE POLICY player_upd ON notifications FOR UPDATE TO authenticated
  USING (club_id = app_player_club()
         AND (target_type IN ('all','team')
              OR (target_type = 'player' AND target_value::text = app_player_id()::text)));

-- 메시지(1:1 채팅): 본인 스레드 조회/작성/읽음 처리
CREATE POLICY player_sel ON messages FOR SELECT TO authenticated
  USING (player_id = app_player_id());
CREATE POLICY player_ins ON messages FOR INSERT TO authenticated
  WITH CHECK (player_id = app_player_id());
CREATE POLICY player_upd ON messages FOR UPDATE TO authenticated
  USING (player_id = app_player_id());

-- 푸시 구독: 본인 것 전체
CREATE POLICY player_all ON push_subscriptions FOR ALL TO authenticated
  USING (player_id = app_player_id()) WITH CHECK (player_id = app_player_id());

-- 주간일정·휴식기 플랜: 소속 클럽 조회
CREATE POLICY player_sel ON weekly_schedule FOR SELECT TO authenticated
  USING (club_id = app_player_club());
CREATE POLICY player_sel ON break_plans FOR SELECT TO authenticated
  USING (club_id = app_player_club());
CREATE POLICY player_sel ON break_plan_sessions FOR SELECT TO authenticated
  USING (club_id = app_player_club());
CREATE POLICY player_all ON break_plan_completions FOR ALL TO authenticated
  USING (player_id = app_player_id()) WITH CHECK (player_id = app_player_id());

-- 소속 클럽 정보 조회 (클럽명 표시용)
CREATE POLICY player_sel ON clubs FOR SELECT TO authenticated
  USING (id = app_player_club());

-- ============================================================
-- 롤백(비상용): 문제가 생기면 아래를 실행해 007 이전 상태로 복귀
-- (각 테이블에 대해)
--   DROP POLICY IF EXISTS staff_all ON <테이블>; ... (007에서 만든 정책 전부)
--   CREATE POLICY "temp_open" ON <테이블> FOR ALL USING (true) WITH CHECK (true);
-- 또는 급할 때: ALTER TABLE <테이블> DISABLE ROW LEVEL SECURITY;
-- ============================================================
