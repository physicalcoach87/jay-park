-- ============================================================
-- 010_diagnose.sql — RLS가 왜 안 걸렸는지 진단 (읽기 전용, 안전)
-- 결과를 그대로 캡처해서 공유해주세요.
-- ============================================================

-- ① 주요 테이블 RLS 활성화 여부 (rls_enabled 가 전부 true 여야 함)
SELECT c.relname AS table_name, c.relrowsecurity AS rls_enabled
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public'
  AND c.relname IN ('player_profiles','gps_records','wellness_records',
                    'session_records','match_records','injury_records',
                    'notifications','messages','profiles','clubs')
ORDER BY c.relname;

-- ② 각 테이블에 실제로 걸려 있는 정책 목록 + 조건
--    USING(true) / qual 이 'true' 인 정책이 남아 있으면 그게 범인
SELECT tablename, policyname, cmd, roles::text, qual AS using_expr
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('player_profiles','gps_records','wellness_records',
                    'session_records','match_records','injury_records',
                    'notifications','messages','profiles','clubs')
ORDER BY tablename, policyname;
