-- ============================================================
-- 003_club_isolation.sql
-- 팀 간 데이터 격리 + 컬럼 매핑/별칭 DB 저장
-- Supabase SQL Editor에서 실행하세요
-- ============================================================

-- ① weekly_schedule 에 club_id 추가
alter table weekly_schedule
  add column if not exists club_id uuid references clubs(id) on delete cascade;

-- 기존 데이터에 club_id 없으면 null 유지 (수동으로 확인 후 정리 필요)
-- 아래 주석을 해제하고 실제 부산아이파크 club_id 로 교체해서 실행하세요
-- update weekly_schedule set club_id = '여기에-부산아이파크-club-id' where club_id is null;

-- ② block_days 에 club_id 추가
alter table block_days
  add column if not exists club_id uuid references clubs(id) on delete cascade;

-- update block_days set club_id = '여기에-부산아이파크-club-id' where club_id is null;

-- ③ clubs 테이블에 설정 컬럼 추가 (컬럼 매핑 + 선수 별칭 DB 저장)
alter table clubs
  add column if not exists gps_col_map  jsonb default '{}'::jsonb,
  add column if not exists gps_alias    jsonb default '{}'::jsonb;

-- ④ RLS(Row Level Security) 정책 — 이미 있으면 무시됨
-- weekly_schedule: club_id 기준 격리
alter table weekly_schedule enable row level security;

drop policy if exists "weekly_schedule_club_isolation" on weekly_schedule;
create policy "weekly_schedule_club_isolation" on weekly_schedule
  using (
    club_id in (
      select club_id from player_profiles
      where id = auth.uid()
      union
      select id from clubs
      where id = club_id
    )
  );

-- block_days: club_id 기준 격리
alter table block_days enable row level security;

drop policy if exists "block_days_club_isolation" on block_days;
create policy "block_days_club_isolation" on block_days
  using (club_id in (select club_id from player_profiles where id = auth.uid()));

-- ============================================================
-- 실행 후 확인 쿼리
-- ============================================================
-- select column_name from information_schema.columns
--   where table_name in ('weekly_schedule','block_days','clubs')
--   and column_name in ('club_id','gps_col_map','gps_alias')
--   order by table_name, column_name;
