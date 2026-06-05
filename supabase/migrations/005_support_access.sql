-- 슈퍼어드민 팀 지원 접근 요청 테이블
CREATE TABLE IF NOT EXISTS support_access_requests (
  id          uuid primary key default gen_random_uuid(),
  club_id     uuid references clubs(id) on delete cascade,
  club_name   text,
  requested_by uuid,  -- 팀 admin user id
  requested_at timestamptz default now(),
  status      text default 'pending',  -- pending / active / closed
  accessed_by uuid,  -- 슈퍼어드민 user id
  accessed_at timestamptz,
  closed_at   timestamptz,
  note        text  -- 지원 요청 내용
);
ALTER TABLE support_access_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "support_access_all" ON support_access_requests FOR ALL USING (true) WITH CHECK (true);
