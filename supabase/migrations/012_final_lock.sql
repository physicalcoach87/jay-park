-- ============================================================
-- 012_final_lock.sql — 마무리 (011 이후 실행)
--   ① fitness_records 레거시 테이블 잠금 (앱 미사용, 데이터 없음 — 삭제는 하지 않음)
--   ② app_errors 에러 수집 테이블 생성 (008 내용 포함)
-- ============================================================

-- ── ① fitness_records: anon에게 열린 정책 전부 제거 후 스태프 전용으로 ──
DO $$
DECLARE p record;
BEGIN
  IF EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
             WHERE n.nspname='public' AND c.relname='fitness_records') THEN
    FOR p IN SELECT policyname FROM pg_policies
             WHERE schemaname='public' AND tablename='fitness_records' LOOP
      EXECUTE format('DROP POLICY IF EXISTS %I ON public.fitness_records', p.policyname);
    END LOOP;
    EXECUTE 'ALTER TABLE public.fitness_records ENABLE ROW LEVEL SECURITY';
    EXECUTE 'CREATE POLICY staff_only ON public.fitness_records FOR ALL TO authenticated
             USING (app_is_staff()) WITH CHECK (app_is_staff())';
  END IF;
END $$;

-- ── ② 앱 에러 자동 수집 테이블 ──
CREATE TABLE IF NOT EXISTS app_errors (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at  timestamptz DEFAULT now(),
  app         text,        -- coach-web / coach-mobile / player
  club_id     uuid,
  user_info   text,
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

-- 에러는 로그인 전에도 발생하므로 쓰기만 개방 (읽기는 superadmin 전용)
CREATE POLICY err_insert ON app_errors FOR INSERT TO anon, authenticated WITH CHECK (true);
CREATE POLICY err_select ON app_errors FOR SELECT TO authenticated USING (app_is_superadmin());
CREATE POLICY err_delete ON app_errors FOR DELETE TO authenticated USING (app_is_superadmin());

-- ── ③ 최종 검증 ──
-- anon이 "읽을 수" 있는 정책이 남아 있으면 표시 (0행이어야 정상)
-- app_errors의 INSERT 전용 정책은 의도된 것이므로 제외
SELECT tablename, policyname, cmd, roles::text, qual
FROM pg_policies
WHERE schemaname='public' AND 'anon' = ANY(roles) AND cmd <> 'INSERT'
ORDER BY tablename;
