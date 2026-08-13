-- Backfill recommendation metadata for the existing exercise library.
-- Medical contraindications are intentionally not inferred automatically.

update exercises
set
  movement_pattern = coalesce(movement_pattern, case
    when sub_area in ('가슴') then '수평 밀기'
    when sub_area in ('등') and (name_ko like '%풀업%' or name_ko like '%풀다운%') then '수직 당기기'
    when sub_area in ('등') then '수평 당기기'
    when sub_area in ('어깨') and (name_ko like '%프레스%') then '수직 밀기'
    when sub_area in ('대퇴사두') or name_ko like '%스쿼트%' then '스쿼트'
    when sub_area in ('햄스트링') and (name_ko like '%데드리프트%' or name_ko like '%인버티드%') then '힌지'
    when sub_area in ('햄스트링') then '무릎 굴곡'
    when sub_area in ('둔근') then '고관절 신전·외전'
    when sub_area in ('종아리','발목') then '발목 기능'
    when sub_area in ('항신전','항회전','회전 파워','굴곡') then sub_area
    when category = '특수_점프' then '점프·착지'
    when category = '특수_파워' then '전신 파워'
    else '전신 복합'
  end),
  laterality = coalesce(laterality, case
    when lower(name_ko) like '%싱글%' or lower(name_en) like '%single%'
      or lower(name_ko) like '%불가리안%' or lower(name_ko) like '%래터럴%' then '단측'
    else '양측'
  end),
  force_vector = coalesce(force_vector, case
    when lower(name_ko) like '%브로드%' or lower(name_ko) like '%스윙%' then '수평'
    when lower(name_ko) like '%래터럴%' then '측면'
    when category in ('특수_점프','특수_파워') then '수직·혼합'
    else '혼합'
  end),
  suitable_md = case
    when cardinality(suitable_md) > 0 then suitable_md
    when category = '특수_활성화' or purposes @> array['활성화']::text[] then array['MD-5','MD-4','MD-3','MD-2','MD-1','MD+1','FREE']
    when category in ('특수_파워','특수_점프') or purposes @> array['파워']::text[] then array['MD-3','MD-2','MD-1','FREE']
    when purposes @> array['근력']::text[] then array['MD-4','MD-3','MD-2','FREE']
    when purposes @> array['근비대']::text[] then array['MD-5','MD-4','MD-3','FREE']
    else array['MD-5','MD-4','MD-3','FREE']
  end,
  suitable_methods = case
    when cardinality(suitable_methods) > 0 then suitable_methods
    when category = '특수_활성화' or purposes @> array['활성화']::text[] then array['스트레이트 세트','슈퍼세트','서킷']
    when category in ('특수_파워','특수_점프') or purposes @> array['파워']::text[] then array['스트레이트 세트','클러스터 세트','컨트라스트']
    when purposes @> array['근력']::text[] then array['스트레이트 세트','클러스터 세트','슈퍼세트','컨트라스트']
    when purposes @> array['근비대']::text[] then array['스트레이트 세트','슈퍼세트']
    else array['스트레이트 세트','슈퍼세트','서킷']
  end,
  football_outcomes = case
    when cardinality(football_outcomes) > 0 then football_outcomes
    when category in ('특수_파워','특수_점프') then array['가속·폭발력','신경근 준비']
    when body_part = '하체' then array['가속·감속 기반','경합 안정성']
    when body_part = '코어' then array['몸통 안정성','힘 전달']
    when body_part = '상체' then array['경합 안정성','상체 힘 전달']
    else array['전신 협응','부하 내성']
  end,
  default_sets_min = coalesce(default_sets_min, case when purposes @> array['파워']::text[] then 3 when purposes @> array['근력']::text[] then 3 else 2 end),
  default_sets_max = coalesce(default_sets_max, case when purposes @> array['근력']::text[] then 5 else 4 end),
  default_reps_min = coalesce(default_reps_min, case when purposes @> array['파워']::text[] then 3 when purposes @> array['근력']::text[] then 3 else 8 end),
  default_reps_max = coalesce(default_reps_max, case when purposes @> array['파워']::text[] then 6 when purposes @> array['근력']::text[] then 6 when purposes @> array['근비대']::text[] then 12 else 15 end),
  default_rpe_min = coalesce(default_rpe_min, case when purposes @> array['파워']::text[] then 6.0 when purposes @> array['근력']::text[] then 7.0 else 5.0 end),
  default_rpe_max = coalesce(default_rpe_max, case when purposes @> array['근력']::text[] then 9.0 when purposes @> array['파워']::text[] then 8.0 else 7.0 end),
  default_rest_sec = coalesce(default_rest_sec, case when purposes @> array['파워']::text[] then 150 when purposes @> array['근력']::text[] then 120 else 60 end),
  updated_at = now()
where is_active is true;
