-- Generated from index-dev.html GYM_POOL.
-- Existing names are preserved and exact case-insensitive duplicates are skipped.

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Bench Press','Barbell Bench Press','일반','상체','가슴',array['근력','근비대']::text[],'대흉근','대흉근',
  array['바벨']::text[],'중급','견갑골 하강·내전 고정. 팔꿈치 75° 벌림.',false,'수평 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Bench Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Bench Press','DB Bench Press','일반','상체','가슴',array['근력','근비대']::text[],'대흉근','대흉근',
  array['덤벨']::text[],'중급','중립 파지 가능. 견관절 안정성 유지.',false,'수평 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Bench Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Incline DB Press','Incline DB Press','일반','상체','가슴',array['근력','근비대']::text[],'대흉근','대흉근',
  array['덤벨']::text[],'중급','30-45° 인클라인. 상흉부 집중 자극.',false,'수평 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Incline DB Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Push-up','Push-up','일반','상체','가슴',array['근지구력','활성화']::text[],'대흉근','대흉근',
  array['맨몸']::text[],'초급','코어 긴장 유지. 견갑골 완전 외전까지.',false,'수평 밀기','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Push-up'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Weighted Push-up','Weighted Push-up','일반','상체','가슴',array['근력','근비대']::text[],'대흉근','대흉근',
  array['맨몸']::text[],'중급','플레이트로 부하 추가. 전신 긴장 유지.',false,'수평 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Weighted Push-up'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Med Ball Explosive Push-up','Med Ball Explosive Push-up','일반','상체','가슴',array['근력','근비대']::text[],'대흉근','대흉근',
  array['메디신볼']::text[],'중급','폭발적 밀기. 상지 반응성 파워 개발.',false,'수평 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Med Ball Explosive Push-up'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Landmine Press','Landmine Press','일반','상체','가슴',array['근지구력','활성화']::text[],'대흉근','대흉근',
  array['랜드마인']::text[],'초급','어깨 친화적 프레스 경로. 코어 안정화 동반.',false,'수평 밀기','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Landmine Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Bent-over Row','Barbell Bent-over Row','일반','상체','등',array['근력','근비대']::text[],'광배근','광배근',
  array['바벨']::text[],'중급','힙 힌지 자세. 척추 중립. 하복부 긴장 유지.',false,'당기기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Bent-over Row'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Single-arm Row','DB Single-arm Row','일반','상체','등',array['근력','근비대']::text[],'광배근','광배근',
  array['덤벨']::text[],'고급','견갑골 완전 수축. 팔꿈치 뒤로 당기기.',false,'당기기','단측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Single-arm Row'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Pull-up','Pull-up','일반','상체','등',array['근력','근비대']::text[],'광배근','광배근',
  array['맨몸']::text[],'중급','완전 ROM. 견갑골 하강부터 시작.',false,'당기기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Pull-up'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Chin-up','Chin-up','일반','상체','등',array['근력','근비대']::text[],'광배근','광배근',
  array['맨몸']::text[],'중급','역손잡이. 이두 보조 활용. 완전 신전까지.',false,'당기기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Chin-up'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Inverted Row','Inverted Row','일반','상체','등',array['근지구력','활성화']::text[],'광배근','광배근',
  array['맨몸']::text[],'초급','몸 전체 일직선. 견갑골 내전 완료.',false,'당기기','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Inverted Row'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Landmine Row','Landmine Row','일반','상체','등',array['근력','근비대']::text[],'광배근','광배근',
  array['랜드마인']::text[],'중급','힙 힌지 지지. 단측 부하 균형 훈련.',false,'당기기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Landmine Row'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Band Pull-apart','Band Pull-apart','일반','상체','등',array['근지구력','활성화']::text[],'광배근','광배근',
  array['밴드']::text[],'초급','어깨 후방 안정화. 지속적 긴장 유지.',false,'당기기','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Band Pull-apart'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Seal Row','DB Seal Row','일반','상체','등',array['근력','근비대']::text[],'광배근','광배근',
  array['덤벨']::text[],'중급','벤치 지지. 순수 상배 수축 집중.',false,'당기기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Seal Row'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Overhead Press','Overhead Press','일반','상체','어깨',array['근력','근비대']::text[],'삼각근','삼각근',
  array['바벨']::text[],'중급','코어 브레이싱. 바 귀 옆 통과 후 잠금.',false,'수직 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Overhead Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Shoulder Press','DB Shoulder Press','일반','상체','어깨',array['근력','근비대']::text[],'삼각근','삼각근',
  array['덤벨']::text[],'중급','중립 파지 선택 가능. 어깨 친화적.',false,'수직 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Shoulder Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Landmine Press','Landmine Press','일반','상체','어깨',array['근력','근비대']::text[],'삼각근','삼각근',
  array['랜드마인']::text[],'중급','견갑-흉부 리듬 유지. 단측 변형 가능.',false,'수직 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Landmine Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Lateral Raise','DB Lateral Raise','일반','상체','어깨',array['근지구력','활성화']::text[],'삼각근','삼각근',
  array['덤벨']::text[],'초급','약간 전경사. 엄지 아래. 승모근 배제.',false,'수직 밀기','단측','측면',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Lateral Raise'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Band Face Pull','Band Face Pull','일반','상체','어깨',array['근지구력','활성화']::text[],'삼각근','삼각근',
  array['밴드']::text[],'초급','외회전+어깨 후방 안정화 동시 훈련.',false,'수직 밀기','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Band Face Pull'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'KB Bottoms-up Press','KB Bottoms-up Press','일반','상체','어깨',array['근지구력','활성화']::text[],'삼각근','삼각근',
  array['케틀벨']::text[],'초급','회전근개 공동활성화. 손목 안정성 요구.',false,'수직 밀기','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('KB Bottoms-up Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Arnold Press','Arnold Press','일반','상체','어깨',array['근력','근비대']::text[],'삼각근','삼각근',
  array['덤벨']::text[],'중급','전체 ROM. 회전 포함. 다방향 어깨 자극.',false,'수직 밀기','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['경합 안정성','상체 힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Arnold Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Hip Thrust','Barbell Hip Thrust','일반','하체','엉덩이',array['근력','근비대']::text[],'대둔근','대둔근',
  array['바벨']::text[],'중급','골반 완전 신전. 둔부 최고점 수축 1초.',false,'고관절 신전','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Hip Thrust'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Single-leg Hip Thrust','Single-leg Hip Thrust','일반','하체','엉덩이',array['근력','근비대']::text[],'대둔근','대둔근',
  array['맨몸']::text[],'고급','골반 안정화. 동측 햄 참여 최소화.',false,'고관절 신전','단측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Single-leg Hip Thrust'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Glute Bridge','Barbell Glute Bridge','일반','하체','엉덩이',array['근력','근비대']::text[],'대둔근','대둔근',
  array['바벨']::text[],'중급','발 위치로 둔근 자극 선택.',false,'고관절 신전','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Glute Bridge'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'KB Swing','KB Swing','특수_파워','하체','엉덩이',array['파워']::text[],'대둔근','대둔근',
  array['케틀벨']::text[],'고급','힙 힌지 패턴. 폭발적 고관절 신전.',false,'고관절 신전','양측','수평',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·감속 기반','경합 안정성']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('KB Swing'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Band Hip Extension','Band Hip Extension','일반','하체','엉덩이',array['근지구력','활성화']::text[],'대둔근','대둔근',
  array['밴드']::text[],'초급','밴드 저항 고관절 신전. 등척성 유지.',false,'고관절 신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Band Hip Extension'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Bulgarian Split Squat','Bulgarian Split Squat','일반','하체','엉덩이',array['근력','근비대']::text[],'대둔근','대둔근',
  array['덤벨']::text[],'중급','전방 정강이 수직. 둔근 우선 활성화.',false,'고관절 신전','단측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Bulgarian Split Squat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Romanian Deadlift','DB Romanian Deadlift','일반','하체','엉덩이',array['근력','근비대']::text[],'대둔근','대둔근',
  array['덤벨']::text[],'중급','힙 힌지. 햄스트링 신장 유지.',false,'고관절 신전','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Romanian Deadlift'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Cable Pull-through','Cable Pull-through','일반','하체','엉덩이',array['근지구력','활성화']::text[],'대둔근','대둔근',
  array['밴드']::text[],'초급','힙 힌지 패턴. 둔근-햄 동시 자극.',false,'고관절 신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Cable Pull-through'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Nordic Hamstring Curl','Nordic Hamstring Curl','일반','하체','햄스트링',array['근력','근비대']::text[],'햄스트링','햄스트링',
  array['맨몸']::text[],'고급','편심 수축 집중. 천천히 내려가기. 부상 예방 핵심.',false,'힌지·무릎 굴곡','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Nordic Hamstring Curl'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Romanian Deadlift','Barbell Romanian Deadlift','일반','하체','햄스트링',array['근력','근비대']::text[],'햄스트링','햄스트링',
  array['바벨']::text[],'중급','중립 척추. 햄스트링 최대 신장.',false,'힌지·무릎 굴곡','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Romanian Deadlift'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Single-leg RDL','Single-leg RDL','일반','하체','햄스트링',array['근력','근비대']::text[],'햄스트링','햄스트링',
  array['덤벨']::text[],'고급','단다리 균형. 골반 수평 유지.',false,'힌지·무릎 굴곡','단측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Single-leg RDL'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Glute-Ham Raise','Glute-Ham Raise','일반','하체','햄스트링',array['근력','근비대']::text[],'햄스트링','햄스트링',
  array['맨몸']::text[],'중급','완전 ROM. 무릎 신전까지.',false,'힌지·무릎 굴곡','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Glute-Ham Raise'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Slider Leg Curl','Slider Leg Curl','일반','하체','햄스트링',array['근지구력','활성화']::text[],'햄스트링','햄스트링',
  array['맨몸']::text[],'초급','브릿지 자세. 발로 당겨서 무릎 굴곡.',false,'힌지·무릎 굴곡','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Slider Leg Curl'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Good Morning','Good Morning','일반','하체','햄스트링',array['근력','근비대']::text[],'햄스트링','햄스트링',
  array['바벨']::text[],'중급','힙 힌지 강화. 척추 신전근 동반.',false,'힌지·무릎 굴곡','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Good Morning'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Leg Curl (Prone)','DB Leg Curl (Prone)','일반','하체','햄스트링',array['근지구력','활성화']::text[],'햄스트링','햄스트링',
  array['덤벨']::text[],'초급','DB 발꿈치 고정. 완전 굴곡.',false,'힌지·무릎 굴곡','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Leg Curl (Prone)'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Back Squat','Barbell Back Squat','일반','하체','쿼드',array['근력','근비대']::text[],'대퇴사두근','대퇴사두근',
  array['바벨']::text[],'중급','발끝 외전 15-30°. 무릎 추적. 깊이 확보.',false,'스쿼트·런지','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Back Squat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Front Squat','Front Squat','일반','하체','쿼드',array['근력','근비대']::text[],'대퇴사두근','대퇴사두근',
  array['바벨']::text[],'중급','전면 랙 파지. 몸통 수직 유지.',false,'스쿼트·런지','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Front Squat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Trap Bar Deadlift','Trap Bar Deadlift','일반','하체','쿼드',array['근력','근비대']::text[],'대퇴사두근','대퇴사두근',
  array['트랩바']::text[],'중급','중립 파지. 고관절-슬관절 동시 신전.',false,'스쿼트·런지','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Trap Bar Deadlift'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Goblet Squat','Goblet Squat','일반','하체','쿼드',array['근지구력','활성화']::text[],'대퇴사두근','대퇴사두근',
  array['케틀벨']::text[],'초급','팔꿈치로 무릎 외전. 깊은 스쿼트.',false,'스쿼트·런지','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Goblet Squat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Reverse Lunge','Reverse Lunge','일반','하체','쿼드',array['근력','근비대']::text[],'대퇴사두근','대퇴사두근',
  array['덤벨']::text[],'중급','전방 경골 수직. 무릎 추적 유지.',false,'스쿼트·런지','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Reverse Lunge'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Step-up','Step-up','일반','하체','쿼드',array['근지구력','활성화']::text[],'대퇴사두근','대퇴사두근',
  array['덤벨']::text[],'초급','전방 발로 완전히 밀기. 보조 없이.',false,'스쿼트·런지','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Step-up'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Landmine Squat','Landmine Squat','일반','하체','쿼드',array['근력','근비대']::text[],'대퇴사두근','대퇴사두근',
  array['랜드마인']::text[],'중급','상체 직립 유지. 코어 안정화.',false,'스쿼트·런지','양측','혼합',
  array['MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','클러스터 세트']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Landmine Squat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Lateral Lunge','Lateral Lunge','일반','하체','쿼드',array['근지구력','활성화']::text[],'대퇴사두근','대퇴사두근',
  array['덤벨']::text[],'초급','측면 부하. 내전근+쿼드 동시 자극.',false,'스쿼트·런지','단측','측면',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Lateral Lunge'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Standing Calf Raise','Standing Calf Raise','일반','하체','카프',array['근지구력','활성화']::text[],'비복근','비복근',
  array['맨몸']::text[],'초급','완전 ROM. 최고점 1초 등척성 유지.',false,'발목 기능','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Standing Calf Raise'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Single-leg Calf Raise','Single-leg Calf Raise','일반','하체','카프',array['근지구력','활성화']::text[],'비복근','비복근',
  array['맨몸']::text[],'고급','단다리. 발가락 방향 변화로 자극 조절.',false,'발목 기능','단측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Single-leg Calf Raise'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Seated Calf Raise','Seated Calf Raise','일반','하체','카프',array['근지구력','활성화']::text[],'비복근','비복근',
  array['덤벨']::text[],'초급','비복근 제외. 가자미근 집중.',false,'발목 기능','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Seated Calf Raise'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Eccentric Calf Raise','Eccentric Calf Raise','일반','하체','카프',array['근지구력','활성화']::text[],'비복근','비복근',
  array['맨몸']::text[],'초급','편심 하강 3초. 족저굴곡 부상 예방.',false,'발목 기능','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['가속·감속 기반','경합 안정성']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Eccentric Calf Raise'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Hang Power Clean','Hang Power Clean','특수_파워','전신','Olympic Lift',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['바벨']::text[],'고급','힙 힌지에서 폭발. 높이 당기기. 풀 수용.',false,'올림픽 리프트','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Hang Power Clean'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Hang Power Snatch','Hang Power Snatch','특수_파워','전신','Olympic Lift',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['바벨']::text[],'고급','와이드 파지. 오버헤드 직선 경로.',false,'올림픽 리프트','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Hang Power Snatch'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Clean Pull','Clean Pull','특수_파워','전신','Olympic Lift',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['바벨']::text[],'고급','바 경로 신체 가까이. 발꿈치 들기.',false,'올림픽 리프트','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Clean Pull'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'KB Clean','KB Clean','특수_파워','전신','Olympic Lift',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['케틀벨']::text[],'고급','포어암 수직. 팔꿈치 타킹 연습.',false,'올림픽 리프트','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('KB Clean'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Hang Clean','DB Hang Clean','특수_파워','전신','Olympic Lift',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['덤벨']::text[],'고급','DB 변형 클린. 올림픽 입문 및 대체.',false,'올림픽 리프트','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Hang Clean'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Barbell Squat + Jump','Barbell Squat + Jump','특수_파워','전신','Power Complex',array['파워']::text[],'대둔근','대둔근',
  array['바벨']::text[],'고급','저부하(30-40% 1RM). 최대 파워 의도.',false,'전신 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Barbell Squat + Jump'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Trap Bar Jump Squat','Trap Bar Jump Squat','특수_파워','전신','Power Complex',array['파워']::text[],'대둔근','대둔근',
  array['트랩바']::text[],'고급','트랩바 30-40%. 수직 점프 집중.',false,'전신 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Trap Bar Jump Squat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Landmine Clean to Press','Landmine Clean to Press','특수_파워','전신','Power Complex',array['파워']::text[],'대둔근','대둔근',
  array['랜드마인']::text[],'고급','연속 동작. 전신 파워 체인.',false,'전신 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Landmine Clean to Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'DB Thruster','DB Thruster','특수_파워','전신','Power Complex',array['파워']::text[],'대둔근','대둔근',
  array['덤벨']::text[],'고급','스쿼트+오버헤드. 메타볼릭 파워.',false,'전신 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('DB Thruster'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Deadlift + Broad Jump','Deadlift + Broad Jump','특수_파워','전신','Power Complex',array['파워']::text[],'대둔근','대둔근',
  array['바벨']::text[],'고급','데드리프트 후 즉시 브로드 점프.',false,'전신 파워','양측','수평',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Deadlift + Broad Jump'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'KB Goblet Squat + Press','KB Goblet Squat + Press','특수_파워','전신','Power Complex',array['파워']::text[],'대둔근','대둔근',
  array['케틀벨']::text[],'고급','스쿼트 후 프레스. 전신 연결.',false,'전신 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('KB Goblet Squat + Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Box Jump','Box Jump','특수_점프','전신','Plyometric / SSC',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['맨몸']::text[],'고급','부드러운 착지. 무릎 굴곡 흡수.',false,'점프·착지','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Box Jump'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Broad Jump','Broad Jump','특수_점프','전신','Plyometric / SSC',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['맨몸']::text[],'고급','최대 수평 거리. 발가락-무릎 정렬.',false,'점프·착지','양측','수평',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Broad Jump'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Depth Jump','Depth Jump','특수_점프','전신','Plyometric / SSC',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['맨몸']::text[],'고급','낮은 박스. 최소 접지 시간. 반응성 집중.',false,'점프·착지','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Depth Jump'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Lateral Bound','Lateral Bound','특수_점프','전신','Plyometric / SSC',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['맨몸']::text[],'고급','측면 폭발. 착지 안정 후 다음 동작.',false,'점프·착지','단측','측면',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Lateral Bound'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Med Ball Slam','Med Ball Slam','특수_점프','전신','Plyometric / SSC',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['메디신볼']::text[],'고급','전신 신전 후 폭발적 굴곡.',false,'점프·착지','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Med Ball Slam'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Hurdle Jump','Hurdle Jump','특수_점프','전신','Plyometric / SSC',array['파워']::text[],'대퇴사두근','대퇴사두근',
  array['맨몸']::text[],'고급','허들 연속 점프. 반응성 훈련.',false,'점프·착지','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['가속·폭발력','신경근 준비']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Hurdle Jump'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Plank','Plank','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['맨몸']::text[],'초급','골반 후방경사. 복횡근 수축. 臀부 조임.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Plank'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Ab Wheel Rollout','Ab Wheel Rollout','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['맨몸']::text[],'고급','요추 굴곡 없이 뻗기. 최대 ROM.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Ab Wheel Rollout'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Dead Bug','Dead Bug','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['맨몸']::text[],'초급','요추 바닥 고정. 대측 팔-다리 이동.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Dead Bug'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Stability Ball Rollout','Stability Ball Rollout','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['짐볼']::text[],'초급','짐볼 변형. 팔꿈치 롤아웃.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Stability Ball Rollout'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Long Lever Plank','Long Lever Plank','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['맨몸']::text[],'초급','팔꿈치→손목 위로. 부하 증가.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Long Lever Plank'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Hollow Body Hold','Hollow Body Hold','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['맨몸']::text[],'초급','천장 향해 눌리기. 연속 긴장.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Hollow Body Hold'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Band Anti-Extension Press','Band Anti-Extension Press','일반','코어','Anti-Extension',array['근지구력','활성화']::text[],'복횡근','복횡근',
  array['밴드']::text[],'초급','밴드 저항. 팔 뻗기 시 요추 안정.',false,'항신전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Band Anti-Extension Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Pallof Press','Pallof Press','일반','코어','Anti-Rotation',array['근지구력','활성화']::text[],'복사근','복사근',
  array['밴드']::text[],'초급','밴드/케이블 수평 저항. 몸통 회전 방지.',false,'항회전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Pallof Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Single-arm Farmer Carry','Single-arm Farmer Carry','일반','코어','Anti-Rotation',array['근지구력','활성화']::text[],'복사근','복사근',
  array['덤벨']::text[],'고급','단측 부하. 측방 굴곡 저항.',false,'항회전','단측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Single-arm Farmer Carry'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Copenhagen Plank','Copenhagen Plank','일반','코어','Anti-Rotation',array['근지구력','활성화']::text[],'복사근','복사근',
  array['맨몸']::text[],'고급','내전근+코어 측면 안정화.',false,'항회전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Copenhagen Plank'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Bird Dog','Bird Dog','일반','코어','Anti-Rotation',array['근지구력','활성화']::text[],'복사근','복사근',
  array['맨몸']::text[],'초급','4점 지지. 척추 중립 유지.',false,'항회전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Bird Dog'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Half-kneeling Pallof Press','Half-kneeling Pallof Press','일반','코어','Anti-Rotation',array['근지구력','활성화']::text[],'복사근','복사근',
  array['밴드']::text[],'초급','반무릎. 고관절 안정화 추가.',false,'항회전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Half-kneeling Pallof Press'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Tall Kneeling Chop','Tall Kneeling Chop','일반','코어','Anti-Rotation',array['근지구력','활성화']::text[],'복사근','복사근',
  array['밴드']::text[],'초급','무릎 자세 대각선 패턴.',false,'항회전','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Tall Kneeling Chop'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Side Plank','Side Plank','일반','코어','Anti-Lateral Flexion',array['근지구력','활성화']::text[],'복사근','복사근',
  array['맨몸']::text[],'초급','발 쌓기 또는 무릎. 엉덩이 완전히 올리기.',false,'항측굴','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Side Plank'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Side Plank + Hip Abduction','Side Plank + Hip Abduction','일반','코어','Anti-Lateral Flexion',array['근지구력','활성화']::text[],'복사근','복사근',
  array['맨몸']::text[],'초급','사이드 플랭크+고관절 외전 추가.',false,'항측굴','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Side Plank + Hip Abduction'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Suitcase Carry','Suitcase Carry','일반','코어','Anti-Lateral Flexion',array['근지구력','활성화']::text[],'복사근','복사근',
  array['덤벨']::text[],'초급','한 손 덤벨 캐리. 골반 수평 유지.',false,'항측굴','양측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Suitcase Carry'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Lateral Band Walk','Lateral Band Walk','일반','코어','Anti-Lateral Flexion',array['근지구력','활성화']::text[],'복사근','복사근',
  array['밴드']::text[],'초급','저항 밴드 측면 보행. 중둔근 활성화.',false,'항측굴','단측','측면',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Lateral Band Walk'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Single-leg RDL Anti-Lat','Single-leg RDL Anti-Lat','일반','코어','Anti-Lateral Flexion',array['근지구력','활성화']::text[],'복사근','복사근',
  array['맨몸']::text[],'고급','단다리 힙 힌지. 측방 안정 집중.',false,'항측굴','단측','혼합',
  array['MD-5','MD-4','MD-3','MD-2','FREE']::text[],array['스트레이트 세트','슈퍼세트','서킷']::text[],array['몸통 안정성','힘 전달']::text[],2,5,6,12,5.0,8.0,90,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Single-leg RDL Anti-Lat'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Med Ball Rotational Throw','Med Ball Rotational Throw','특수_파워','코어','Rotational Power',array['파워']::text[],'복사근','복사근',
  array['메디신볼']::text[],'고급','벽 향해 회전 던지기. 최대 속도.',false,'회전 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['몸통 안정성','힘 전달']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Med Ball Rotational Throw'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Med Ball Scoop Toss','Med Ball Scoop Toss','특수_파워','코어','Rotational Power',array['파워']::text[],'복사근','복사근',
  array['메디신볼']::text[],'고급','고관절 신전+회전. 위로 투척.',false,'회전 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['몸통 안정성','힘 전달']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Med Ball Scoop Toss'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Band Woodchop','Band Woodchop','특수_파워','코어','Rotational Power',array['파워']::text[],'복사근','복사근',
  array['밴드']::text[],'고급','대각선 당기기. 어깨→반대 골반.',false,'회전 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['몸통 안정성','힘 전달']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Band Woodchop'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Side Med Ball Slam','Side Med Ball Slam','특수_파워','코어','Rotational Power',array['파워']::text[],'복사근','복사근',
  array['메디신볼']::text[],'고급','측면 슬램. 복사근 파워.',false,'회전 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['몸통 안정성','힘 전달']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Side Med Ball Slam'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Russian Twist','Russian Twist','특수_파워','코어','Rotational Power',array['파워']::text[],'복사근','복사근',
  array['메디신볼']::text[],'고급','발 들어 불안정. 회전 제어.',false,'회전 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['몸통 안정성','힘 전달']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Russian Twist'));

insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select 'Cable Band Lift','Cable Band Lift','특수_파워','코어','Rotational Power',array['파워']::text[],'복사근','복사근',
  array['밴드']::text[],'고급','하→상 대각선 리프트. 전신 회전.',false,'회전 파워','양측','수직·혼합',
  array['MD-3','MD-2','MD-1','FREE']::text[],array['스트레이트 세트','클러스터 세트','컨트라스트']::text[],array['몸통 안정성','힘 전달']::text[],3,4,3,6,6.0,8.0,150,true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower('Cable Band Lift'));
