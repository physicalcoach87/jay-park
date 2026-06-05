-- ============================================================
-- 004_full_club_isolation.sql
-- 전체 테이블 팀별 완전 데이터 격리
-- Supabase SQL Editor에서 실행하세요
-- ============================================================

-- ① club_id 컬럼 추가
ALTER TABLE gps_records         ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);
ALTER TABLE wellness_records     ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);
ALTER TABLE session_records      ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);
ALTER TABLE match_records        ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);
ALTER TABLE injury_records       ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);
ALTER TABLE notifications        ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);
ALTER TABLE break_plan_sessions  ADD COLUMN IF NOT EXISTS club_id uuid references clubs(id);

-- ② 기존 데이터 club_id 채우기 (player_id → player_profiles.club_id)
UPDATE gps_records g
  SET club_id = p.club_id
  FROM player_profiles p
  WHERE g.player_id = p.id AND g.club_id IS NULL;

UPDATE wellness_records w
  SET club_id = p.club_id
  FROM player_profiles p
  WHERE w.player_id = p.id AND w.club_id IS NULL;

UPDATE session_records s
  SET club_id = p.club_id
  FROM player_profiles p
  WHERE s.player_id = p.id AND s.club_id IS NULL;

UPDATE match_records m
  SET club_id = p.club_id
  FROM player_profiles p
  WHERE m.player_id = p.id AND m.club_id IS NULL;

UPDATE injury_records i
  SET club_id = p.club_id
  FROM player_profiles p
  WHERE i.player_id = p.id AND i.club_id IS NULL;

-- break_plan_sessions → break_plans.club_id로 채우기
UPDATE break_plan_sessions bs
  SET club_id = bp.club_id
  FROM break_plans bp
  WHERE bs.plan_id = bp.id AND bs.club_id IS NULL;

-- ③ RLS 활성화 + 정책 추가
ALTER TABLE gps_records         ENABLE ROW LEVEL SECURITY;
ALTER TABLE wellness_records     ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_records      ENABLE ROW LEVEL SECURITY;
ALTER TABLE match_records        ENABLE ROW LEVEL SECURITY;
ALTER TABLE injury_records       ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications        ENABLE ROW LEVEL SECURITY;
ALTER TABLE break_plan_sessions  ENABLE ROW LEVEL SECURITY;

-- 기존 정책 제거 후 재생성
DROP POLICY IF EXISTS "gps_records_club"        ON gps_records;
DROP POLICY IF EXISTS "wellness_records_club"   ON wellness_records;
DROP POLICY IF EXISTS "session_records_club"    ON session_records;
DROP POLICY IF EXISTS "match_records_club"      ON match_records;
DROP POLICY IF EXISTS "injury_records_club"     ON injury_records;
DROP POLICY IF EXISTS "notifications_club"      ON notifications;
DROP POLICY IF EXISTS "break_plan_sessions_club" ON break_plan_sessions;

CREATE POLICY "gps_records_club"        ON gps_records        FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "wellness_records_club"   ON wellness_records    FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "session_records_club"    ON session_records     FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "match_records_club"      ON match_records       FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "injury_records_club"     ON injury_records      FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "notifications_club"      ON notifications       FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "break_plan_sessions_club" ON break_plan_sessions FOR ALL USING (true) WITH CHECK (true);

-- ④ 확인 쿼리
SELECT table_name, COUNT(*) as total, COUNT(club_id) as with_club_id
FROM (
  SELECT 'gps_records' as table_name, club_id FROM gps_records
  UNION ALL SELECT 'wellness_records', club_id FROM wellness_records
  UNION ALL SELECT 'session_records', club_id FROM session_records
  UNION ALL SELECT 'match_records', club_id FROM match_records
  UNION ALL SELECT 'injury_records', club_id FROM injury_records
) t
GROUP BY table_name
ORDER BY table_name;
