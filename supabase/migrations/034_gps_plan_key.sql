-- GPS 훈련 기록에 "어느 주기화 계획으로 훈련했는지"를 저장한다.
--
-- 지금은 업로드에서 계획을 고르면 그 계획의 속성(대회 구분·상대·MD 단계)만
-- 행에 복사되고, 어느 계획을 골랐는지는 남지 않는다. 그래서 같은 경기를
-- 준비하면서 목적만 다른 두 계획(예: MD-5에 주전은 회복, 리저브는 유산소 자극)은
-- 행에 남는 값이 모두 같아 나중에 되짚을 수 없다.
--
-- 값: 'base' = 기본 계획(block_days) / 그 외에는 periodization_plan_variants.id
-- NULL은 계획을 고르지 않았거나 이 칸이 생기기 전의 기존 데이터를 뜻하며,
-- 화면은 기존처럼 대회 구분·상대로 이어 붙인다.

ALTER TABLE gps_records
  ADD COLUMN IF NOT EXISTS plan_key text;

COMMENT ON COLUMN gps_records.plan_key IS
  '이 세션이 따른 주기화 계획: base = 기본 계획, 그 외 = periodization_plan_variants.id (NULL = 미지정/기존 데이터)';

CREATE INDEX IF NOT EXISTS gps_records_plan_key_idx
  ON gps_records (session_date, plan_key);
