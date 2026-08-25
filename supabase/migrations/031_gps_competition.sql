-- GPS 훈련 기록에도 준비 대회 정보를 저장한다.
-- 주기화 기본/추가 계획에서 선택한 리그·컵대회·연습경기·기타 값을 보존한다.
ALTER TABLE gps_records
  ADD COLUMN IF NOT EXISTS competition text;

COMMENT ON COLUMN gps_records.competition IS
  '훈련 세션이 준비하는 대회 구분: 리그, 컵대회, 연습경기, 기타';
