-- ============================================================
-- 020_gps_track.sql — GPS 기록 트랙(A팀/B팀) 태깅
--
-- gps_records에 track 컬럼 추가. block_days와 동일 규약:
--   'ALL' = A팀(기본/기존 데이터), 'B' = B팀
-- 기존 행은 전부 'ALL'(A팀)로 남아 지금 방식 그대로 동작.
-- 주기화 2단계: 트랙별 목표 대비 달성률 비교에 사용.
-- ============================================================

ALTER TABLE gps_records ADD COLUMN IF NOT EXISTS track text NOT NULL DEFAULT 'ALL';

-- 조회 성능(날짜+트랙) 보조 인덱스
CREATE INDEX IF NOT EXISTS gps_records_date_track_idx ON gps_records (session_date, track);

-- 확인
SELECT track, count(*) FROM gps_records GROUP BY track ORDER BY track;
