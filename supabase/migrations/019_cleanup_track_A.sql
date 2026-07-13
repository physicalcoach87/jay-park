-- ============================================================
-- 019_cleanup_track_A.sql — 트랙 모델 확정(A팀=ALL / B팀=B)
--
-- 트랙을 A팀·B팀 2개로 정리.
--   · A팀 = 기존 ALL 데이터(43개) 그대로 사용 (내부값 'ALL' 유지)
--   · B팀 = 'B'
-- 3버튼 시절 테스트로 만든 track='A' 행만 제거한다.
-- (실데이터 아님 — A팀 버튼을 눌러 넣어본 임시 행)
-- ============================================================

-- ① 삭제 전 현황
SELECT track, count(*) FROM block_days GROUP BY track ORDER BY track;

-- ② 테스트용 'A' 트랙 행 제거
DELETE FROM block_days WHERE track = 'A';

-- ③ 정리 후 확인 (ALL=A팀, B=B팀 만 남아야 함)
SELECT track, count(*) FROM block_days GROUP BY track ORDER BY track;
