-- Conservative coach-facing caution tags derived from movement demands.
-- These tags only support candidate screening and are not medical diagnoses.

update exercises
set contraindications = case
  when cardinality(contraindications) > 0 then contraindications
  when movement_pattern in ('점프·착지','스쿼트','스쿼트·런지')
    then array['급성 무릎 통증','급성 발목 통증']
  when movement_pattern in ('힌지','힌지·무릎 굴곡','올림픽 리프트','전신 파워')
    then array['급성 햄스트링 통증','급성 요통']
  when movement_pattern in ('수평 밀기','수직 밀기') or lower(name_en) like '%press%'
    then array['급성 어깨 통증','급성 팔꿈치·손목 통증']
  when movement_pattern in ('수평 당기기','수직 당기기','당기기')
    then array['급성 어깨 통증','급성 팔꿈치 통증']
  when movement_pattern in ('항신전','항회전','항측굴','회전 파워')
    then array['급성 요통']
  when movement_pattern in ('발목 기능')
    then array['급성 발목·아킬레스 통증']
  else contraindications
end,
updated_at = now()
where is_active is true;
