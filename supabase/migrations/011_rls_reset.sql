-- ============================================================
-- 011_rls_reset.sql — RLS 완전 재설정 (007이 안 먹은 원인 해결)
--
-- 원인: 마이그레이션 파일에 없는 옛 정책들(대시보드에서 직접 생성)이 남아 있었음.
--       예) clubs.player_app_clubs = SELECT to anon USING(true)
--       PostgreSQL은 permissive 정책을 OR로 합치므로 true 하나면 전부 통과.
--       → 007의 DROP POLICY는 이름을 짐작한 것만 지워서 무력화됨.
--
-- 해결: 대상 테이블의 모든 정책을 이름 무관하게 전부 DROP → 우리 정책만 재생성
-- 실행 후 반드시 앱 동작 확인 (코치웹/코치모바일/선수앱)
--
-- 긴급 롤백이 필요하면 특정 테이블만:
--   ALTER TABLE public.<테이블명> DISABLE ROW LEVEL SECURITY;
-- ============================================================

-- ① 대상 테이블의 기존 정책 전부 제거 (이름 무관) + RLS 활성화
DO $$
DECLARE
  t text;
  p record;
  tables text[] := ARRAY['block_days', 'blocks', 'body_comp_records', 'break_plan_completions', 'break_plan_sessions', 'break_plans', 'club_role_permissions', 'clubs', 'custom_programs', 'exercises', 'gps_records', 'gym_settings', 'injury_records', 'invite_tokens', 'match_minute_records', 'match_records', 'messages', 'notifications', 'player_profiles', 'profiles', 'push_subscriptions', 'session_minute_records', 'session_records', 'test_records', 'user_tab_overrides', 'video_links', 'weekly_schedule', 'wellness_records', 'support_access_requests'];
BEGIN
  FOREACH t IN ARRAY tables LOOP
    IF EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
               WHERE n.nspname='public' AND c.relname=t) THEN
      FOR p IN SELECT policyname FROM pg_policies
               WHERE schemaname='public' AND tablename=t LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', p.policyname, t);
      END LOOP;
      EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
    END IF;
  END LOOP;
END $$;

-- ② 우리 정책만 재생성 (69개, 007과 동일 내용)
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

CREATE POLICY staff_sel ON clubs FOR SELECT TO authenticated
  USING (app_is_superadmin() OR id = app_club());

CREATE POLICY staff_upd ON clubs FOR UPDATE TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND id = app_staff_club()));

CREATE POLICY super_ins ON clubs FOR INSERT TO authenticated
  WITH CHECK (app_is_superadmin());

CREATE POLICY prof_sel ON profiles FOR SELECT TO authenticated
  USING (app_is_superadmin() OR id = auth.uid()
         OR (app_is_staff() AND club_id = app_staff_club()));

CREATE POLICY prof_ins ON profiles FOR INSERT TO authenticated
  WITH CHECK (id = auth.uid() OR app_is_superadmin());

CREATE POLICY prof_upd ON profiles FOR UPDATE TO authenticated
  USING (app_is_superadmin() OR id = auth.uid()
         OR (app_is_club_admin() AND club_id = app_staff_club()));

CREATE POLICY prof_del ON profiles FOR DELETE TO authenticated
  USING (app_is_superadmin());

CREATE POLICY own_all ON user_tab_overrides FOR ALL TO authenticated
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY sar_all ON support_access_requests FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));

CREATE POLICY player_sel ON player_profiles FOR SELECT TO authenticated
  USING (auth_user_id = auth.uid());

CREATE POLICY player_upd ON player_profiles FOR UPDATE TO authenticated
  USING (auth_user_id = auth.uid());

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

CREATE POLICY player_sel ON gps_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());

CREATE POLICY player_sel ON match_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());

CREATE POLICY player_sel ON test_records FOR SELECT TO authenticated
  USING (player_id = app_player_id());

CREATE POLICY player_sel ON notifications FOR SELECT TO authenticated
  USING (club_id = app_player_club()
         AND (target_type IN ('all','team')
              OR (target_type = 'player' AND target_value::text = app_player_id()::text)));

CREATE POLICY player_upd ON notifications FOR UPDATE TO authenticated
  USING (club_id = app_player_club()
         AND (target_type IN ('all','team')
              OR (target_type = 'player' AND target_value::text = app_player_id()::text)));

CREATE POLICY player_sel ON messages FOR SELECT TO authenticated
  USING (player_id = app_player_id());

CREATE POLICY player_ins ON messages FOR INSERT TO authenticated
  WITH CHECK (player_id = app_player_id());

CREATE POLICY player_upd ON messages FOR UPDATE TO authenticated
  USING (player_id = app_player_id());

CREATE POLICY player_all ON push_subscriptions FOR ALL TO authenticated
  USING (player_id = app_player_id()) WITH CHECK (player_id = app_player_id());

CREATE POLICY player_sel ON weekly_schedule FOR SELECT TO authenticated
  USING (club_id = app_player_club());

CREATE POLICY player_sel ON break_plans FOR SELECT TO authenticated
  USING (club_id = app_player_club());

CREATE POLICY player_sel ON break_plan_sessions FOR SELECT TO authenticated
  USING (club_id = app_player_club());

CREATE POLICY player_all ON break_plan_completions FOR ALL TO authenticated
  USING (player_id = app_player_id()) WITH CHECK (player_id = app_player_id());

CREATE POLICY player_sel ON clubs FOR SELECT TO authenticated
  USING (id = app_player_club());


-- ③ 검증: anon(로그인 안 한 외부인)에게 열린 정책이 남아 있으면 표시됨
--    → 0행이어야 정상
SELECT tablename, policyname, cmd, roles::text, qual
FROM pg_policies
WHERE schemaname='public' AND 'anon' = ANY(roles)
ORDER BY tablename;
