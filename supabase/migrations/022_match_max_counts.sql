-- ============================================================
-- 022_match_max_counts.sql — Match Max에 HSR 횟수·Sprint 횟수 추가
--
-- 기존 Match Max: 거리(HSR=band4_td, Sprint=band5_td) 기준.
-- 추가: 횟수(HSR=band4_n, Sprint=band5_n) 기준 최대값 컬럼.
-- ============================================================

ALTER TABLE player_profiles ADD COLUMN IF NOT EXISTS match_max_hsr_n numeric; -- HSR 횟수 Max (band4_n)
ALTER TABLE player_profiles ADD COLUMN IF NOT EXISTS match_max_spr_n numeric; -- Sprint 횟수 Max (band5_n)

-- 확인
SELECT column_name FROM information_schema.columns
WHERE table_name='player_profiles' AND column_name IN ('match_max_hsr_n','match_max_spr_n');
