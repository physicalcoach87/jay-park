-- Coach GYM prescription lifecycle: draft -> assigned -> completed -> reviewed.
create table if not exists gym_prescriptions (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null,
  title text not null,
  target_type text not null check (target_type in ('individual','group')),
  target_player_ids uuid[] not null default '{}',
  scheduled_date date,
  status text not null default 'draft' check (status in ('draft','assigned','completed','archived')),
  prescription_context jsonb not null default '{}'::jsonb,
  items jsonb not null default '[]'::jsonb,
  quality_snapshot jsonb not null default '{}'::jsonb,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  assigned_at timestamptz
);

create table if not exists gym_prescription_results (
  id uuid primary key default gen_random_uuid(),
  prescription_id uuid not null references gym_prescriptions(id) on delete cascade,
  player_id uuid not null,
  status text not null default 'pending' check (status in ('pending','in_progress','completed','skipped')),
  actual_items jsonb not null default '[]'::jsonb,
  session_rpe numeric(3,1),
  duration_min integer,
  player_note text,
  coach_note text,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (prescription_id, player_id)
);

create index if not exists gym_prescriptions_club_date_idx on gym_prescriptions(club_id, scheduled_date desc);
create index if not exists gym_prescriptions_status_idx on gym_prescriptions(status);
create index if not exists gym_prescription_results_prescription_idx on gym_prescription_results(prescription_id);
create index if not exists gym_prescription_results_player_idx on gym_prescription_results(player_id, completed_at desc);

comment on table gym_prescriptions is 'Coach-confirmed strength prescriptions with editable planned variables and assignment targets.';
comment on table gym_prescription_results is 'Per-player actual completion records used for plan-versus-actual and recommendation analytics.';
