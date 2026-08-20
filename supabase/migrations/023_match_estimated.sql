-- ============================================================
-- 023_match_estimated.sql — 경기 추정 데이터 플래그
--
-- GPS 미착용 선수의 데이터를 코치가 출전시간만 입력해 추정 생성할 때,
-- 그 행이 실측이 아님을 표시한다.
--
-- 왜 필요한가 — 순환 참조 차단:
--   추정치는 그 선수의 "최근 FT 3경기 분당 비율"로 만든다.
--   플래그 없이 저장하면 그 추정치가 다시 최근 3경기 평균과 Match Max에
--   포함되어, 추정이 다음 추정의 기준이 되는 되먹임이 발생한다.
--
-- 용도별 처리:
--   Match Max · 최근 3경기 기준선  → 제외 (is_estimated=false만)
--   개인 부하 · ACWR · 부상위험    → 포함 (선수는 실제로 출전했음)
--   경기 보고서                    → 포함하되 추정 표시
-- ============================================================

ALTER TABLE match_records
  ADD COLUMN IF NOT EXISTS is_estimated boolean NOT NULL DEFAULT false;

-- 확인
SELECT column_name, data_type, column_default, is_nullable
FROM information_schema.columns
WHERE table_name='match_records' AND column_name='is_estimated';
