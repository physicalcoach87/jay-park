-- ============================================================
-- 008_error_logs.sql — 앱 에러 자동 수집 테이블
-- 006 실행 후라면 언제든 실행 가능 (007보다 먼저여도 무방)
-- 쓰기: 누구나 가능(에러는 로그인 전에도 남) / 읽기·삭제: superadmin만
-- ============================================================

CREATE TABLE IF NOT EXISTS app_errors (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at  timestamptz DEFAULT now(),
  app         text,        -- coach-web / coach-mobile / player
  club_id     uuid,
  user_info   text,        -- 코치 이메일 또는 선수 id
  message     text,
  stack       text,
  url         text,
  user_agent  text
);

CREATE INDEX IF NOT EXISTS idx_app_errors_created ON app_errors (created_at DESC);

ALTER TABLE app_errors ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS err_insert ON app_errors;
DROP POLICY IF EXISTS err_select ON app_errors;
DROP POLICY IF EXISTS err_delete ON app_errors;

CREATE POLICY err_insert ON app_errors FOR INSERT TO anon, authenticated
  WITH CHECK (true);
CREATE POLICY err_select ON app_errors FOR SELECT TO authenticated
  USING (app_is_superadmin());
CREATE POLICY err_delete ON app_errors FOR DELETE TO authenticated
  USING (app_is_superadmin());

-- 30일 지난 로그 자동 정리 (pg_cron 확장이 켜져 있는 경우에만 동작)
-- SELECT cron.schedule('purge-app-errors', '0 3 * * *',
--   $$DELETE FROM app_errors WHERE created_at < now() - interval '30 days'$$);
