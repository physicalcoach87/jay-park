-- ============================================================
-- 024_match_competition.sql — 경기 대회 구분 + 기준선 제외 플래그
--
-- ① competition — 리그 / 컵대회 / 연습경기 / 기타
--    컵대회는 로테이션 스쿼드·상대 수준·연장 등으로 physical demand가 달라,
--    최근 3경기 기준선에 섞이면 다음 훈련 목표가 왜곡된다.
--    기존 행은 전부 '리그'로 들어간다. 과거 컵 경기는 화면에서 재분류.
--
-- ② baseline_excluded — 이 경기를 최근 3경기 기준선에서 통째로 제외
--    추정 데이터(is_estimated)가 한 명이라도 섞인 경기는 저장 시 자동 true.
--    코치가 경기 기록 목록에서 직접 켜고 끌 수도 있다.
--    is_estimated(행 단위)와 역할이 다르다 — 이쪽은 경기 단위 판단.
-- ============================================================

ALTER TABLE match_records
  ADD COLUMN IF NOT EXISTS competition text NOT NULL DEFAULT '리그';

ALTER TABLE match_records
  ADD COLUMN IF NOT EXISTS baseline_excluded boolean NOT NULL DEFAULT false;

-- 확인
SELECT competition, baseline_excluded,
       count(*) AS rows, count(DISTINCT match_date) AS matches
FROM match_records GROUP BY 1,2 ORDER BY 1,2;
