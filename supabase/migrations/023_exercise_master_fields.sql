-- Exercise master data used by the prescription recommendation engine.
-- Backward compatible: existing exercise rows remain valid and usable.

alter table if exists exercises
  add column if not exists movement_pattern text,
  add column if not exists laterality text,
  add column if not exists force_vector text,
  add column if not exists suitable_md text[] not null default '{}',
  add column if not exists suitable_methods text[] not null default '{}',
  add column if not exists contraindications text[] not null default '{}',
  add column if not exists football_outcomes text[] not null default '{}',
  add column if not exists default_sets_min integer,
  add column if not exists default_sets_max integer,
  add column if not exists default_reps_min integer,
  add column if not exists default_reps_max integer,
  add column if not exists default_rpe_min numeric(3,1),
  add column if not exists default_rpe_max numeric(3,1),
  add column if not exists default_rest_sec integer,
  add column if not exists video_url text,
  add column if not exists is_active boolean not null default true,
  add column if not exists updated_at timestamptz not null default now();

create index if not exists exercises_active_idx on exercises (is_active);
create index if not exists exercises_purposes_gin_idx on exercises using gin (purposes);
create index if not exists exercises_suitable_md_gin_idx on exercises using gin (suitable_md);
create index if not exists exercises_suitable_methods_gin_idx on exercises using gin (suitable_methods);

comment on column exercises.suitable_md is 'Recommended MD stages, e.g. MD-4, MD-3, MD-2, MD-1, MD+1, FREE';
comment on column exercises.suitable_methods is 'Compatible prescription methods, e.g. 스트레이트 세트, 슈퍼세트, 서킷, 클러스터 세트, 컨트라스트';
comment on column exercises.contraindications is 'Coach-facing caution tags. They support screening but never replace medical judgment.';
