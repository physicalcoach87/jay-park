-- Merge bilingual seed duplicates such as "푸시업 / Push-up" and "Push-up / Push-up".
-- Keep the Korean-labelled canonical row so existing coach-facing names remain stable.

update exercises as canonical
set
  movement_pattern = coalesce(canonical.movement_pattern, duplicate.movement_pattern),
  laterality = coalesce(canonical.laterality, duplicate.laterality),
  force_vector = coalesce(canonical.force_vector, duplicate.force_vector),
  suitable_md = case when cardinality(coalesce(canonical.suitable_md, '{}')) > 0 then canonical.suitable_md else duplicate.suitable_md end,
  suitable_methods = case when cardinality(coalesce(canonical.suitable_methods, '{}')) > 0 then canonical.suitable_methods else duplicate.suitable_methods end,
  football_outcomes = case when cardinality(coalesce(canonical.football_outcomes, '{}')) > 0 then canonical.football_outcomes else duplicate.football_outcomes end,
  updated_at = now()
from exercises as duplicate
where canonical.id <> duplicate.id
  and lower(canonical.name_en) = lower(duplicate.name_en)
  and lower(canonical.name_ko) <> lower(canonical.name_en)
  and lower(duplicate.name_ko) = lower(duplicate.name_en);

update exercises as duplicate
set is_active = false,
    updated_at = now()
where lower(duplicate.name_ko) = lower(duplicate.name_en)
  and exists (
    select 1
    from exercises as canonical
    where canonical.id <> duplicate.id
      and lower(canonical.name_en) = lower(duplicate.name_en)
      and lower(canonical.name_ko) <> lower(canonical.name_en)
  );

-- Frequently used horizontal-push alternative missing from the original seed.
insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,
  primary_muscle_ko,primary_muscle_en,antagonist_ko,antagonist_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,
  laterality,force_vector,suitable_md,suitable_methods,football_outcomes,
  default_sets_min,default_sets_max,default_reps_min,default_reps_max,
  default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select
  '시티드 체스트 프레스','Seated Chest Press','일반','상체','가슴',array['근력','근비대','근지구력']::text[],
  '대흉근','Pectoralis Major','광배근','Latissimus Dorsi',array['머신']::text[],'초급',
  '등과 견갑을 패드에 고정하고 팔꿈치가 손목 뒤에 오도록 밀기.',false,'수평 밀기',
  '양측','수평',array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],
  array['스트레이트 세트','슈퍼세트','서킷']::text[],array['상체 힘 전달','경합 안정성']::text[],
  2,4,8,15,5.0,8.0,90,true,now()
where not exists (
  select 1 from exercises where lower(name_en)=lower('Seated Chest Press')
);
