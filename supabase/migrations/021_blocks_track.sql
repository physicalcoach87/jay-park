-- ============================================================
-- 021_blocks_track.sql — 주기화 블록(컨테이너) 트랙 분리
--
-- blocks에 track 추가. block_days와 동일 규약:
--   'ALL' = A팀(기본/기존 데이터), 'B' = B팀
-- 기존 블록은 전부 'ALL'(A팀)로 남는다.
-- A팀·B팀이 서로 다른 경기일정(마이크로사이클)을 가지므로
-- 블록 자체를 트랙별로 따로 만들어 관리한다.
-- ============================================================

ALTER TABLE blocks ADD COLUMN IF NOT EXISTS track text NOT NULL DEFAULT 'ALL';

CREATE INDEX IF NOT EXISTS blocks_track_idx ON blocks (track, start_date);

-- 확인
SELECT track, count(*) FROM blocks GROUP BY track ORDER BY track;
