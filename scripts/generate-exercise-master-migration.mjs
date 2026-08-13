import fs from 'node:fs';
import path from 'node:path';

const root=path.resolve(path.dirname(new URL(import.meta.url).pathname),'..');
const html=fs.readFileSync(path.join(root,'index-dev.html'),'utf8');
const start=html.indexOf('const GYM_POOL=');
const end=html.indexOf('\n};\n\n// ═══════════════════════════════════════════\n// 영상 링크',start);
if(start<0||end<0)throw new Error('GYM_POOL literal not found');
const literal=html.slice(start+'const GYM_POOL='.length,end+2);
const pool=Function(`"use strict"; return (${literal});`)();

const equipMap={bb:'바벨',db:'덤벨',bw:'맨몸',mb:'메디신볼',lm:'랜드마인',band:'밴드',kb:'케틀벨',trap:'트랩바',gb:'짐볼'};
const partMap={UB:'상체',LB:'하체',AB:'전신',Core:'코어'};
const muscleMap={
  Chest:'대흉근',Back:'광배근',Shoulder:'삼각근',Glute:'대둔근',Hamstring:'햄스트링',Quad:'대퇴사두근',Calf:'비복근',
  AntiExt:'복횡근',AntiRot:'복사근',AntiLat:'복사근',RotPwr:'복사근',Olympic:'대퇴사두근',PowerComplex:'대둔근',Plyometric:'대퇴사두근'
};
const patternMap={
  Chest:'수평 밀기',Back:'당기기',Shoulder:'수직 밀기',Glute:'고관절 신전',Hamstring:'힌지·무릎 굴곡',Quad:'스쿼트·런지',Calf:'발목 기능',
  AntiExt:'항신전',AntiRot:'항회전',AntiLat:'항측굴',RotPwr:'회전 파워',Olympic:'올림픽 리프트',PowerComplex:'전신 파워',Plyometric:'점프·착지'
};
const sqlText=v=>v==null?'null':`'${String(v).replaceAll("'","''")}'`;
const sqlArray=arr=>`array[${arr.map(sqlText).join(',')}]::text[]`;

const rows=[];
for(const [partKey,part] of Object.entries(pool)){
  for(const [subKey,sub] of Object.entries(part.subs||{})){
    for(const ex of sub.ex||[]){
      const power=partKey==='AB'||subKey==='RotPwr'||/jump|throw|slam|swing|clean|snatch|thruster/i.test(ex.n);
      const purposes=power?['파워']:(ex.p==='main'?['근력','근비대']:['근지구력','활성화']);
      const methods=power?['스트레이트 세트','클러스터 세트','컨트라스트']:(ex.p==='main'?['스트레이트 세트','슈퍼세트','클러스터 세트']:['스트레이트 세트','슈퍼세트','서킷']);
      const md=power?['MD-3','MD-2','MD-1','FREE']:(ex.p==='main'?['MD-4','MD-3','MD-2','FREE']:['MD-5','MD-4','MD-3','MD-2','FREE']);
      const category=partKey==='AB'?(subKey==='Plyometric'?'특수_점프':'특수_파워'):(power?'특수_파워':'일반');
      const body=partMap[partKey];
      const primary=muscleMap[subKey]||'전신';
      const equipment=[equipMap[ex.equip]||'맨몸'];
      const difficulty=power||/single|nordic|copenhagen|depth|ab wheel/i.test(ex.n)?'고급':(ex.p==='main'?'중급':'초급');
      const outcomes=partKey==='LB'?['가속·감속 기반','경합 안정성']:partKey==='Core'?['몸통 안정성','힘 전달']:partKey==='UB'?['경합 안정성','상체 힘 전달']:['가속·폭발력','신경근 준비'];
      rows.push({name:ex.n,category,body,sub:sub.label,purposes,primary,equipment,difficulty,cue:ex.cue,pattern:patternMap[subKey]||'전신 복합',md,methods,outcomes,power});
    }
  }
}

const statements=rows.map(r=>`insert into exercises (
  name_ko,name_en,category,body_part,sub_area,purposes,primary_muscle_ko,primary_muscle_en,
  equipment_priority,difficulty,coaching_cue,is_custom,movement_pattern,laterality,force_vector,
  suitable_md,suitable_methods,football_outcomes,default_sets_min,default_sets_max,
  default_reps_min,default_reps_max,default_rpe_min,default_rpe_max,default_rest_sec,is_active,updated_at
)
select ${sqlText(r.name)},${sqlText(r.name)},${sqlText(r.category)},${sqlText(r.body)},${sqlText(r.sub)},${sqlArray(r.purposes)},${sqlText(r.primary)},${sqlText(r.primary)},
  ${sqlArray(r.equipment)},${sqlText(r.difficulty)},${sqlText(r.cue)},false,${sqlText(r.pattern)},${sqlText(/single|unilateral|bulgarian|lateral/i.test(r.name)?'단측':'양측')},${sqlText(/broad|swing/i.test(r.name)?'수평':/lateral/i.test(r.name)?'측면':r.power?'수직·혼합':'혼합')},
  ${sqlArray(r.md)},${sqlArray(r.methods)},${sqlArray(r.outcomes)},${r.power?3:2},${r.power?4:5},${r.power?3:6},${r.power?6:12},${r.power?'6.0':'5.0'},${r.power?'8.0':'8.0'},${r.power?150:90},true,now()
where not exists (select 1 from exercises where lower(name_ko)=lower(${sqlText(r.name)}));`).join('\n\n');

const output=`-- Generated from index-dev.html GYM_POOL.\n-- Existing names are preserved and exact case-insensitive duplicates are skipped.\n\n${statements}\n`;
const target=path.join(root,'supabase/migrations/025_exercise_pool_unification.sql');
fs.writeFileSync(target,output);
console.log(JSON.stringify({sourceExercises:rows.length,target},null,2));
