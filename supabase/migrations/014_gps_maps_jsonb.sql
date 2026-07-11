-- ============================================================
-- 014_gps_maps_jsonb.sql — GPS 컬럼매핑·이름별칭을 팀(clubs) 단위 DB 저장
--
-- 배경: 매핑이 브라우저 localStorage에만 있어 기기·스태프 간 공유가 안 됨.
--       clubs.gps_col_map / gps_alias 컬럼을 실제로 사용하도록 전환.
-- 이 SQL: 두 컬럼이 jsonb 타입인지 보장 (객체 저장 가능하게)
-- ============================================================

ALTER TABLE clubs ADD COLUMN IF NOT EXISTS gps_col_map jsonb;
ALTER TABLE clubs ADD COLUMN IF NOT EXISTS gps_alias   jsonb;

-- 이미 text 등 다른 타입이면 jsonb로 변환 (빈/NULL은 '{}'로)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns
             WHERE table_name='clubs' AND column_name='gps_col_map' AND data_type<>'jsonb') THEN
    EXECUTE $q$ALTER TABLE clubs ALTER COLUMN gps_col_map TYPE jsonb
              USING COALESCE(NULLIF(gps_col_map::text,'')::jsonb, '{}'::jsonb)$q$;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns
             WHERE table_name='clubs' AND column_name='gps_alias' AND data_type<>'jsonb') THEN
    EXECUTE $q$ALTER TABLE clubs ALTER COLUMN gps_alias TYPE jsonb
              USING COALESCE(NULLIF(gps_alias::text,'')::jsonb, '{}'::jsonb)$q$;
  END IF;
END $$;
