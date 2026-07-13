-- ============================================================
-- 018_period_tracks.sql — 주기화 트랙(전체/A팀/B팀) 지원
--
-- block_days를 날짜당 1행 → (날짜, 트랙)당 1행으로 확장.
-- 기존 계획은 전부 track='ALL'(전체)로 남아 지금 방식 그대로 동작.
-- ============================================================

-- ① 트랙 컬럼 추가 (기존 행은 자동으로 'ALL')
ALTER TABLE block_days ADD COLUMN IF NOT EXISTS track text NOT NULL DEFAULT 'ALL';

-- ② 기존 plan_date 단독 UNIQUE 제거 후 (plan_date, track) 복합 UNIQUE 추가
DO $$
DECLARE c text;
BEGIN
  -- 제약(constraint) 형태
  FOR c IN
    SELECT con.conname FROM pg_constraint con
    WHERE con.conrelid='public.block_days'::regclass AND con.contype='u'
      AND (SELECT array_agg(att.attname::text ORDER BY att.attname::text)
           FROM pg_attribute att
           WHERE att.attrelid=con.conrelid AND att.attnum = ANY(con.conkey)) = ARRAY['plan_date']
  LOOP EXECUTE 'ALTER TABLE block_days DROP CONSTRAINT '||quote_ident(c); END LOOP;

  -- 인덱스(unique index) 형태
  FOR c IN
    SELECT i.relname FROM pg_index x
    JOIN pg_class i ON i.oid=x.indexrelid
    WHERE x.indrelid='public.block_days'::regclass AND x.indisunique AND NOT x.indisprimary
      AND (SELECT array_agg(att.attname::text ORDER BY att.attname::text)
           FROM pg_attribute att
           WHERE att.attrelid=x.indrelid AND att.attnum = ANY(x.indkey::int[])) = ARRAY['plan_date']
  LOOP EXECUTE 'DROP INDEX IF EXISTS '||quote_ident(c); END LOOP;

  -- (plan_date, track) 복합 UNIQUE 없으면 추가 (재실행 안전)
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid='public.block_days'::regclass AND conname='block_days_plan_date_track_key'
  ) THEN
    ALTER TABLE block_days ADD CONSTRAINT block_days_plan_date_track_key UNIQUE (plan_date, track);
  END IF;
END $$;

-- ④ 확인
SELECT track, count(*) FROM block_days GROUP BY track ORDER BY track;
