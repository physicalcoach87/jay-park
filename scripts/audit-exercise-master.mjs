import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const specPath = path.join(root, 'EXERCISE_MASTER_ZERO_BASE.md');
const legacyPaths = [
  path.join(root, 'supabase/migrations/001_gym_tables.sql'),
  path.join(root, 'supabase/migrations/025_exercise_pool_unification.sql'),
  path.join(root, 'supabase/migrations/028_exercise_bilingual_dedup.sql'),
];

const normalize = value => String(value || '')
  .toLowerCase()
  .normalize('NFKD')
  .replace(/dumbbell/g, 'db')
  .replace(/kettlebell/g, 'kb')
  .replace(/medicine ball/g, 'med ball')
  .replace(/single arm/g, 'single-arm')
  .replace(/one arm/g, 'single-arm')
  .replace(/push up/g, 'push-up')
  .replace(/pull up/g, 'pull-up')
  .replace(/[^a-z0-9가-힣]+/g, ' ')
  .trim();

const spec = fs.readFileSync(specPath, 'utf8');
let region = '';
let bodyPart = '';
let displayGroup = '';
let movementPattern = '';
const masterRows = [];

for (const line of spec.split(/\r?\n/)) {
  if (/^# (상체|하체|전신|코어)/.test(line)) region = line.slice(2).trim();
  if (/^## \d+\./.test(line)) {
    bodyPart = line.replace(/^## \d+\.\s*/, '').trim();
    displayGroup = bodyPart;
    movementPattern = bodyPart;
  }
  if (/^### \d+\.\d+/.test(line)) {
    displayGroup = line.replace(/^### \d+\.\d+\s*/, '').trim();
    movementPattern = displayGroup;
  }
  if (/^내부 패턴:/.test(line)) movementPattern = line.replace(/^내부 패턴:\s*/, '').replace(/\.$/, '').trim();
  const match = line.match(/^-\s+(.+?)\s*\/\s*([^—]+?)(?:\s*—\s*(.+))?$/);
  if (!match) continue;
  const defaultNotes = region.startsWith('전신') ? '파워' : '보조';
  masterRows.push({
    nameKo: match[1].trim(),
    nameEn: match[2].trim(),
    notes: (match[3] || defaultNotes).trim(),
    region,
    bodyPart,
    displayGroup,
    movementPattern,
    key: normalize(match[2]),
  });
}

const roleOrder = ['워밍업', '활성화', '메인', '보조', '파워', '회귀·복귀', '회귀', '복귀', '평가'];
const inferRoles = notes => {
  const roles = roleOrder
    .filter(role => notes.includes(role))
    .sort((a, b) => notes.indexOf(a) - notes.indexOf(b));
  const normalized = roles.map(role => role === '회귀' || role === '복귀' ? '회귀·복귀' : role);
  return [...new Set(normalized)];
};
const inferEquipment = (name, row) => {
  const rules = [
    [/barbell/i, '바벨'], [/dumbbell|\bdb\b/i, '덤벨'], [/kettlebell|\bkb\b/i, '케틀벨'],
    [/medicine ball|med ball/i, '메디신볼'], [/cable/i, '케이블'], [/band/i, '밴드'],
    [/machine|pec deck/i, '머신'], [/landmine/i, '랜드마인'], [/trap bar/i, '트랩바'],
    [/suspension|trx/i, '서스펜션'], [/box/i, '박스'], [/sled/i, '슬레드'],
    [/swiss ball|stability ball/i, '짐볼'], [/slider/i, '슬라이더'], [/bench/i, '벤치'],
  ];
  const equipment = rules.filter(([pattern]) => pattern.test(name)).map(([, value]) => value);
  const add = (...values) => values.forEach(value => equipment.push(value));
  if (/chest press$/i.test(name)) add('머신');
  if (/lat pulldown|leg press|leg extension|lying leg curl|seated leg curl|single-leg leg curl|hack squat|machine calf raise/i.test(name)) add('머신');
  if (/pull-up|chin-up/i.test(name)) add('풀업바');
  if (/preacher curl/i.test(name)) add('EZ바', '프리처 벤치');
  if (/t-bar row|seal row|chest-supported/i.test(name)) add('바벨', '벤치');
  if (/back extension|reverse hyperextension|glute-ham raise/i.test(name)) add('전용 머신');
  if (/nordic hamstring/i.test(name)) add('노르딕 벤치');
  if (/battle rope/i.test(name)) add('배틀로프');
  if (/farmer's carry|suitcase carry|waiter's carry|front-rack carry|overhead carry/i.test(name)) add('덤벨', '케틀벨');
  if (/bear-hug carry/i.test(name)) add('샌드백');
  if (/turkish get-up|half get-up/i.test(name)) add('케틀벨', '덤벨');
  if (/wrist curl|wrist extension|reverse curl|hammer curl|lying triceps extension/i.test(name)) add('덤벨');
  if (/ez-bar/i.test(name)) add('EZ바');
  if (row.bodyPart === '올림픽 리프트' && !equipment.some(value => ['덤벨', '케틀벨', '랜드마인'].includes(value))) add('바벨');
  if (/front squat|conventional deadlift|sumo deadlift|romanian deadlift|push press|power jerk|split jerk|push jerk|high pull|clean pull|snatch pull|muscle clean|muscle snatch/i.test(name) && !equipment.some(value => ['덤벨', '케틀벨'].includes(value))) add('바벨');
  if (/goblet squat/i.test(name)) add('덤벨', '케틀벨');
  if (/safety-bar squat/i.test(name)) add('세이프티바');
  if (/loaded jump squat/i.test(name)) add('바벨', '덤벨');
  if (/pallof press|cable chop|cable lift|landmine rotation|half-kneeling lift/i.test(name) && !equipment.includes('랜드마인')) add('케이블', '밴드');
  if (!equipment.length) equipment.push('맨몸');
  return [...new Set(equipment)];
};
const inferLevel = notes => notes.includes('고급') ? '고급' : notes.includes('발전') ? '발전' : /회귀|복귀/.test(notes) ? '회귀' : '기본';
const inferFatigue = roles => roles.includes('메인') || roles.includes('파워') ? '높음' : roles.includes('보조') ? '중간' : '낮음';

const legacyRows = [];
for (const legacyPath of legacyPaths) {
  const sql = fs.readFileSync(legacyPath, 'utf8');
  const source = path.basename(legacyPath);

  for (const match of sql.matchAll(/where not exists\s*\(select 1 from exercises where lower\(name_ko\)=lower\('((?:''|[^'])*)'\)\)/gi)) {
    const name = match[1].replaceAll("''", "'");
    legacyRows.push({ nameKo: name, nameEn: name, source, key: normalize(name) });
  }

  for (const match of sql.matchAll(/^\s*\('((?:''|[^'])*)',\s*'((?:''|[^'])*)',/gm)) {
    const nameKo = match[1].replaceAll("''", "'");
    const nameEn = match[2].replaceAll("''", "'");
    legacyRows.push({ nameKo, nameEn, source, key: normalize(nameEn || nameKo) });
  }

  for (const match of sql.matchAll(/select\s+'((?:''|[^'])*)',\s*'((?:''|[^'])*)',/gi)) {
    const nameKo = match[1].replaceAll("''", "'");
    const nameEn = match[2].replaceAll("''", "'");
    legacyRows.push({ nameKo, nameEn, source, key: normalize(nameEn || nameKo) });
  }
}

const uniqueBy = (rows, keyFn) => {
  const map = new Map();
  for (const row of rows) {
    const key = keyFn(row);
    if (key && !map.has(key)) map.set(key, row);
  }
  return [...map.values()];
};

const canonicalLocation = new Map(Object.entries({
  'Push Press': '저크·드라이브',
  'Medicine Ball Overhead Throw': '메디신볼 던지기',
  'Medicine Ball Overhead Slam': '메디신볼 던지기',
  'Dumbbell Snatch': '스내치 계열',
  'Cable Pull-Through': '힙힌지·복합 하체',
  'Bird Dog': '척추 안정화',
  "Farmer's Carry": '캐리',
  'Suitcase Carry': '캐리',
  'Overhead Carry': '캐리',
}));
const masterGroups = [...masterRows.reduce((map, row) => {
  if (!map.has(row.key)) map.set(row.key, []);
  map.get(row.key).push(row);
  return map;
}, new Map()).values()];
const masterUnique = masterGroups.map(group => {
  const preferred = canonicalLocation.get(group[0].nameEn);
  const canonical = (preferred && group.find(row => row.displayGroup === preferred)) || group[0];
  return {
    ...canonical,
    linkedGroups: group
      .filter(row => row !== canonical)
      .map(row => `${row.region} > ${row.bodyPart} > ${row.displayGroup}`),
  };
});
const legacyUnique = uniqueBy(legacyRows, row => row.key);
const masterByKey = new Map(masterUnique.map(row => [row.key, row]));
const legacyByKey = new Map(legacyUnique.map(row => [row.key, row]));

const matched = masterUnique.filter(row => legacyByKey.has(row.key));
const newOnly = masterUnique.filter(row => !legacyByKey.has(row.key));
const legacyOnly = legacyUnique.filter(row => !masterByKey.has(row.key));

const duplicateGroups = rows => [...rows.reduce((map, row) => {
  if (!map.has(row.key)) map.set(row.key, []);
  map.get(row.key).push(row);
  return map;
}, new Map()).values()].filter(group => group.length > 1);

const masterDuplicates = duplicateGroups(masterRows);
const legacyDuplicates = duplicateGroups(legacyRows);
const esc = value => String(value || '').replaceAll('|', '\\|').replaceAll('\n', ' ');
const table = (headers, rows) => [
  `| ${headers.join(' | ')} |`,
  `| ${headers.map(() => '---').join(' | ')} |`,
  ...rows.map(row => `| ${row.map(esc).join(' | ')} |`),
].join('\n');

const report = `# 운동 마스터 DB 비교 감사

생성 기준: \`EXERCISE_MASTER_ZERO_BASE.md\` 및 저장소 마이그레이션 파일

## 요약

| 항목 | 수량 |
|---|---:|
| 새 마스터 원본 행 | ${masterRows.length} |
| 새 마스터 고유 운동 | ${masterUnique.length} |
| 기존 마이그레이션 고유 운동 | ${legacyUnique.length} |
| 영문명 기준 동일 운동 | ${matched.length} |
| 새 마스터에만 있는 운동 | ${newOnly.length} |
| 기존 목록에만 있는 운동 | ${legacyOnly.length} |
| 새 마스터 내 중복·교차 등록 후보 | ${masterDuplicates.length} |
| 기존 목록 내 중복 후보 | ${legacyDuplicates.length} |

> 이 감사는 저장소 마이그레이션을 기준으로 합니다. 운영 DB에서 코치가 직접 추가한 운동은 이전 직전 별도 조회하여 보존합니다.

## 이전 원칙

1. 기존 운동은 자동 삭제하지 않는다.
2. 영문명 정규화가 일치하는 운동은 새 한글 대표명과 분류를 연결한다.
3. 새 마스터 운동은 신규 등록 후보로 둔다.
4. 기존에만 있는 운동은 코치 추가 운동과 구형 시스템 운동을 구분한 뒤 유지·연결·비활성화를 결정한다.
5. 중복은 삭제하지 않고 대표 운동으로 연결한 뒤 숨김 처리한다.

## 새로 추가할 운동 후보 (${newOnly.length})

${table(['한글명', '영문명', '영역', '부위', '표시 그룹'], newOnly.map(row => [row.nameKo, row.nameEn, row.region, row.bodyPart, row.displayGroup]))}

## 기존 목록에만 있는 운동 (${legacyOnly.length})

${table(['기존 한글/표시명', '기존 영문명', '출처'], legacyOnly.map(row => [row.nameKo, row.nameEn, row.source]))}

## 새 마스터 중복·교차 등록 후보 (${masterDuplicates.length})

${masterDuplicates.length ? table(['정규화 이름', '등록 위치'], masterDuplicates.map(group => [group[0].nameEn, group.map(row => `${row.bodyPart} > ${row.displayGroup}`).join(' / ')])) : '없음'}

## 기존 목록 중복 후보 (${legacyDuplicates.length})

${legacyDuplicates.length ? table(['정규화 이름', '기존 표기'], legacyDuplicates.map(group => [group[0].nameEn, group.map(row => `${row.nameKo} (${row.source})`).join(' / ')])) : '없음'}
`;

const outputPath = path.join(root, 'EXERCISE_MASTER_AUDIT.md');
fs.writeFileSync(outputPath, report);
const dataDir = path.join(root, 'data');
fs.mkdirSync(dataDir, { recursive: true });
const catalog = masterUnique.map((row, index) => {
  const availableRoles = inferRoles(row.notes);
  return {
    master_key: `EX-${String(index + 1).padStart(4, '0')}`,
    name_ko: row.nameKo,
    name_en: row.nameEn,
    region: row.region,
    body_part: row.bodyPart,
    display_group: row.displayGroup,
    movement_pattern: row.movementPattern,
    equipment: inferEquipment(row.nameEn, row),
    primary_role: availableRoles[0] || '보조',
    available_roles: availableRoles.length ? availableRoles : ['보조'],
    progression_level: inferLevel(row.notes),
    fatigue_cost: inferFatigue(availableRoles),
    linked_groups: row.linkedGroups || [],
    source_notes: row.notes,
    review_status: '초안',
  };
});
const catalogPath = path.join(dataDir, 'exercise-master-v2.json');
fs.writeFileSync(catalogPath, `${JSON.stringify(catalog, null, 2)}\n`);
console.log(JSON.stringify({
  masterRows: masterRows.length,
  masterUnique: masterUnique.length,
  legacyUnique: legacyUnique.length,
  matched: matched.length,
  newOnly: newOnly.length,
  legacyOnly: legacyOnly.length,
  masterDuplicateGroups: masterDuplicates.length,
  legacyDuplicateGroups: legacyDuplicates.length,
  outputPath,
  catalogPath,
}, null, 2));
