-- 같은 팀·같은 날짜에 둘 이상의 경기 준비 계획을 저장한다.
-- 기본 계획은 기존 block_days에 남겨 하위 호환성을 유지하고,
-- 두 번째 이후 계획만 이 테이블에 저장한다. 선수 배정은 저장하지 않는다.

CREATE TABLE IF NOT EXISTS periodization_plan_variants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  club_id uuid REFERENCES clubs(id) ON DELETE CASCADE,
  plan_date date NOT NULL,
  track text NOT NULL DEFAULT 'ALL' CHECK (track IN ('ALL','A','B')),
  plan_name text NOT NULL,
  target_match_date date,
  opponent text,
  competition text CHECK (competition IS NULL OR competition IN ('리그','컵대회','연습경기','기타')),
  day_label text,
  am_session text,
  pm_session text,
  td_target numeric,
  hsr_target numeric,
  spr_target numeric,
  acc_target numeric,
  rhie_target numeric,
  ref_basis jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (club_id, plan_date, track, plan_name)
);

CREATE INDEX IF NOT EXISTS periodization_plan_variants_date_track_idx
  ON periodization_plan_variants (club_id, plan_date, track);

ALTER TABLE periodization_plan_variants ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "periodization_plan_variants_club" ON periodization_plan_variants;
CREATE POLICY "periodization_plan_variants_club" ON periodization_plan_variants
  FOR ALL TO authenticated
  USING (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()))
  WITH CHECK (app_is_superadmin() OR (app_is_staff() AND club_id = app_staff_club()));
