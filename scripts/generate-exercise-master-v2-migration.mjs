import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const catalog = JSON.parse(fs.readFileSync(path.join(root, 'data/exercise-master-v2.json'), 'utf8'));

const muscleByPart = {
  '가슴': ['대흉근', 'Pectoralis Major'],
  '등': ['광배근·승모근', 'Latissimus Dorsi · Trapezius'],
  '어깨': ['삼각근·회전근개', 'Deltoid · Rotator Cuff'],
  '팔': ['상완근군·전완근군', 'Upper Arm · Forearm'],
  '대퇴·무릎 중심': ['대퇴사두근', 'Quadriceps'],
  '햄스트링': ['햄스트링', 'Hamstrings'],
  '둔근·고관절': ['둔근군', 'Gluteal Muscles'],
  '종아리·발목': ['하퇴·발목 근육군', 'Lower Leg · Ankle'],
  '힙힌지·복합 하체': ['후면사슬', 'Posterior Chain'],
  '올림픽 리프트': ['전신 신전근군', 'Whole-Body Extensors'],
  '점프': ['하지 신전근군', 'Lower-Limb Extensors'],
  '폭발 동작': ['전신 파워 근육군', 'Whole-Body Power Chain'],
  '코어': ['몸통 안정화 근육군', 'Trunk Stabilizers'],
  '척추 안정화': ['척추 안정화 근육군', 'Spinal Stabilizers'],
  '기능적 동작': ['전신 안정화 근육군', 'Whole-Body Stabilizers'],
};

const categoryFor = row => row.available_roles.includes('파워')
  ? (row.body_part === '점프' ? '특수_점프' : '특수_파워')
  : row.available_roles.some(role => ['워밍업', '활성화', '회귀·복귀'].includes(role)) && !row.available_roles.includes('메인')
    ? '특수_활성화'
    : '일반';
const bodyPartFor = row => row.region === '상체' ? '상체' : row.region === '하체' ? '하체' : row.region.startsWith('전신') ? '전신' : '코어';
const purposesFor = row => {
  const values = [];
  if (row.available_roles.includes('파워')) values.push('파워');
  if (row.available_roles.includes('메인')) values.push('근력', '근비대');
  if (row.available_roles.includes('보조')) values.push('근력', '근비대', '근지구력');
  if (row.available_roles.some(role => ['워밍업', '활성화', '회귀·복귀'].includes(role))) values.push('활성화', '근지구력');
  return [...new Set(values.length ? values : ['근지구력'])];
};
const difficultyFor = row => row.progression_level === '고급' ? '고급' : row.progression_level === '회귀' ? '초급' : '중급';
const prescriptionDefaults = row => {
  if (row.available_roles.includes('파워')) return { setsMin: 3, setsMax: 5, repsMin: 2, repsMax: 5, rpeMin: 5, rpeMax: 8, rest: 150 };
  if (row.available_roles.includes('메인')) return { setsMin: 3, setsMax: 5, repsMin: 3, repsMax: 10, rpeMin: 6, rpeMax: 9, rest: 120 };
  if (row.available_roles.includes('활성화') || row.available_roles.includes('워밍업')) return { setsMin: 1, setsMax: 3, repsMin: 6, repsMax: 15, rpeMin: 2, rpeMax: 5, rest: 45 };
  return { setsMin: 2, setsMax: 4, repsMin: 6, repsMax: 15, rpeMin: 5, rpeMax: 8, rest: 75 };
};

const payload = catalog.map(row => {
  const [muscleKo, muscleEn] = muscleByPart[row.body_part] || ['전신', 'Whole Body'];
  const defaults = prescriptionDefaults(row);
  return {
    ...row,
    category: categoryFor(row),
    legacy_body_part: bodyPartFor(row),
    purposes: purposesFor(row),
    primary_muscle_ko: muscleKo,
    primary_muscle_en: muscleEn,
    difficulty: difficultyFor(row),
    suitable_md: row.available_roles.includes('파워') ? ['MD-3', 'MD-2', 'MD-1', 'FREE'] : ['MD-5', 'MD-4', 'MD-3', 'MD-2', 'MD-1', 'MD+1', 'FREE'],
    suitable_methods: row.available_roles.includes('파워') ? ['스트레이트 세트', '클러스터 세트', '컨트라스트'] : ['스트레이트 세트', '슈퍼세트', '서킷', '클러스터 세트'],
    ...defaults,
  };
});

const runtimePath = path.join(root, 'data/exercise-master-v2-runtime.json');
fs.writeFileSync(runtimePath, `${JSON.stringify(payload.map(row => ({
  id: row.master_key,
  ...row,
  body_part: row.legacy_body_part,
  sub_area: row.display_group,
  equipment_priority: row.equipment,
  default_sets_min: row.setsMin,
  default_sets_max: row.setsMax,
  default_reps_min: row.repsMin,
  default_reps_max: row.repsMax,
  default_rpe_min: row.rpeMin,
  default_rpe_max: row.rpeMax,
  default_rest_sec: row.rest,
  is_active: true,
  is_custom: false,
  catalog_version: 2,
})), null, 2)}\n`);

const json = JSON.stringify(payload).replaceAll('$exercise_master$', '$exercise-master$');
const sql = `-- Exercise Master V2: zero-base canonical catalog (${payload.length} exercises).
-- Existing prescription history is preserved. Duplicate system rows are merged into
-- the canonical catalog; identical custom rows are hidden instead of deleted.

alter table if exists exercises
  add column if not exists master_key text,
  add column if not exists catalog_version integer not null default 1,
  add column if not exists region text,
  add column if not exists display_group text,
  add column if not exists primary_role text,
  add column if not exists available_roles text[] not null default '{}',
  add column if not exists progression_level text,
  add column if not exists fatigue_cost text,
  add column if not exists linked_groups text[] not null default '{}',
  add column if not exists name_aliases text[] not null default '{}',
  add column if not exists source_notes text;

create or replace function normalize_exercise_name(value text)
returns text
language sql
immutable
as $$
  select trim(regexp_replace(
    replace(replace(replace(replace(replace(lower(coalesce(value, '')),
      'dumbbell', 'db'), 'kettlebell', 'kb'), 'medicine ball', 'med ball'),
      'one arm', 'single arm'), 'single-arm', 'single arm'),
    '[^a-z0-9가-힣]+', ' ', 'g'));
$$;

create temporary table exercise_master_v2_seed on commit drop as
select *
from jsonb_to_recordset($exercise_master$${json}$exercise_master$::jsonb) as seed(
  master_key text,
  name_ko text,
  name_en text,
  region text,
  body_part text,
  display_group text,
  movement_pattern text,
  equipment text[],
  primary_role text,
  available_roles text[],
  progression_level text,
  fatigue_cost text,
  linked_groups text[],
  source_notes text,
  review_status text,
  category text,
  legacy_body_part text,
  purposes text[],
  primary_muscle_ko text,
  primary_muscle_en text,
  difficulty text,
  suitable_md text[],
  suitable_methods text[],
  "setsMin" integer,
  "setsMax" integer,
  "repsMin" integer,
  "repsMax" integer,
  "rpeMin" numeric,
  "rpeMax" numeric,
  rest integer
);

-- Reuse one existing system row when its Korean or English name represents the same exercise.
with candidates as (
  select e.id, s.master_key,
    row_number() over (
      partition by s.master_key
      order by e.is_custom asc, e.created_at asc nulls last, e.id
    ) as priority
  from exercise_master_v2_seed s
  join exercises e on
    normalize_exercise_name(e.name_en) = normalize_exercise_name(s.name_en)
    or normalize_exercise_name(e.name_ko) = normalize_exercise_name(s.name_ko)
    or normalize_exercise_name(e.name_ko) = normalize_exercise_name(s.name_en)
), chosen as (
  select id, master_key from candidates where priority = 1
)
update exercises e
set
  name_ko = s.name_ko,
  name_en = s.name_en,
  category = s.category,
  body_part = s.legacy_body_part,
  sub_area = s.display_group,
  purposes = s.purposes,
  primary_muscle_ko = s.primary_muscle_ko,
  primary_muscle_en = s.primary_muscle_en,
  equipment_priority = s.equipment,
  difficulty = s.difficulty,
  movement_pattern = s.movement_pattern,
  suitable_md = s.suitable_md,
  suitable_methods = s.suitable_methods,
  default_sets_min = s."setsMin",
  default_sets_max = s."setsMax",
  default_reps_min = s."repsMin",
  default_reps_max = s."repsMax",
  default_rpe_min = s."rpeMin",
  default_rpe_max = s."rpeMax",
  default_rest_sec = s.rest,
  master_key = s.master_key,
  catalog_version = 2,
  region = s.region,
  display_group = s.display_group,
  primary_role = s.primary_role,
  available_roles = s.available_roles,
  progression_level = s.progression_level,
  fatigue_cost = s.fatigue_cost,
  linked_groups = s.linked_groups,
  source_notes = s.source_notes,
  is_active = true,
  updated_at = now()
from chosen c
join exercise_master_v2_seed s on s.master_key = c.master_key
where e.id = c.id;

-- Insert master exercises that do not already have a canonical row.
insert into exercises (
  name_ko, name_en, category, body_part, sub_area, purposes,
  primary_muscle_ko, primary_muscle_en, equipment_priority, difficulty,
  coaching_cue, is_custom, movement_pattern, suitable_md, suitable_methods,
  default_sets_min, default_sets_max, default_reps_min, default_reps_max,
  default_rpe_min, default_rpe_max, default_rest_sec, is_active, updated_at,
  master_key, catalog_version, region, display_group, primary_role,
  available_roles, progression_level, fatigue_cost, linked_groups, source_notes
)
select
  s.name_ko, s.name_en, s.category, s.legacy_body_part, s.display_group, s.purposes,
  s.primary_muscle_ko, s.primary_muscle_en, s.equipment, s.difficulty,
  null, false, s.movement_pattern, s.suitable_md, s.suitable_methods,
  s."setsMin", s."setsMax", s."repsMin", s."repsMax",
  s."rpeMin", s."rpeMax", s.rest, true, now(),
  s.master_key, 2, s.region, s.display_group, s.primary_role,
  s.available_roles, s.progression_level, s.fatigue_cost, s.linked_groups, s.source_notes
from exercise_master_v2_seed s
where not exists (select 1 from exercises e where e.master_key = s.master_key);

-- Remove duplicate system rows that normalize to a V2 canonical exercise.
-- Historical prescriptions store their generated items as JSON, so deleting the
-- duplicate selector row does not remove completed prescription history.
delete from exercises duplicate
using exercises canonical
where canonical.catalog_version = 2
  and canonical.master_key is not null
  and duplicate.id <> canonical.id
  and coalesce(duplicate.is_custom, false) = false
  and duplicate.catalog_version <> 2
  and (
    normalize_exercise_name(duplicate.name_en) = normalize_exercise_name(canonical.name_en)
    or normalize_exercise_name(duplicate.name_ko) = normalize_exercise_name(canonical.name_ko)
    or normalize_exercise_name(duplicate.name_ko) = normalize_exercise_name(canonical.name_en)
  );

-- Preserve unmatched legacy and custom rows instead of deleting them.
-- They remain recoverable but are excluded from the active V2 selector.
update exercises
set is_active = false, updated_at = now()
where catalog_version <> 2 and is_active = true;

create unique index if not exists exercises_master_key_unique_idx
  on exercises (master_key) where master_key is not null;
create index if not exists exercises_catalog_active_idx
  on exercises (catalog_version, is_active);
create index if not exists exercises_display_group_idx
  on exercises (display_group) where is_active = true;
create index if not exists exercises_available_roles_gin_idx
  on exercises using gin (available_roles);

comment on column exercises.master_key is 'Stable Exercise Master V2 identifier.';
comment on column exercises.available_roles is 'Exercise roles: 워밍업, 활성화, 메인, 보조, 파워, 회귀·복귀, 평가.';
comment on column exercises.fatigue_cost is 'Relative session fatigue cost: 낮음, 중간, 높음.';
comment on column exercises.linked_groups is 'Additional classifications for one canonical exercise.';
`;

const target = path.join(root, 'supabase/migrations/029_exercise_master_v2.sql');
fs.writeFileSync(target, sql);
console.log(JSON.stringify({ exercises: payload.length, target, runtimePath }, null, 2));
