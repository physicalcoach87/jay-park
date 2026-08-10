// ============================================================
// 핵심 계산 로직 회귀 테스트
// 실행: bash tests/run-tests.sh  (index-dev.html에서 함수를 추출해 검증)
// 대상: calcACWR / calcMVExposure / calcWellnessRisk / calcRiskLevel
// ============================================================
let _pass = 0, _fail = 0;
function check(name, cond, detail) {
  if (cond) { _pass++; }
  else { _fail++; print('  ❌ FAIL: ' + name + (detail ? ' — ' + detail : '')); }
}
function approx(a, b, eps) { return Math.abs(a - b) < (eps || 1e-9); }
// 날짜 헬퍼: today('2026-07-08', -3) → '2026-07-05'
function dstr(base, offset) {
  const d = new Date(base + 'T00:00:00Z');
  d.setUTCDate(d.getUTCDate() + offset);
  return d.toISOString().split('T')[0];
}
const TODAY = '2026-07-08';

// ── calcACWR ────────────────────────────────────────────────
// 기준: chronic = 28일 합 ÷ 28 × 7 (휴식일 0 포함, CLAUDE.md)
(function () {
  // 격일 훈련 14일 × sRPE 500
  const sess = [];
  for (let i = 0; i < 28; i += 2) sess.push({ date: dstr(TODAY, -i), rpe: 10, dur: 50 });
  let r = calcACWR(sess, TODAY);
  check('ACWR 기본', r.acute === 2000 && r.chronic === 1750, JSON.stringify(r));
  check('ACWR 값', approx(r.acwr, 2000 / 1750), r.acwr);

  // 휴식일 반영: 훈련일 절반 → chronic도 절반
  const sparse = sess.filter((_, i) => i % 2 === 0);
  r = calcACWR(sparse, TODAY);
  check('ACWR 휴식일 반영', r.chronic === 875, r.chronic);

  // 경계: 7일째(diff=7)는 acute 제외, 28일째(diff=28)는 chronic 제외
  r = calcACWR([{ date: dstr(TODAY, -7), rpe: 10, dur: 10 }], TODAY);
  check('ACWR acute 경계(7일 전 제외)', r.acute === 0, r.acute);
  r = calcACWR([{ date: dstr(TODAY, -28), rpe: 10, dur: 10 }], TODAY);
  check('ACWR chronic 경계(28일 전 제외)', r.chronic === 0, r.chronic);

  // 미래 날짜 데이터는 무시
  r = calcACWR([{ date: dstr(TODAY, 1), rpe: 10, dur: 10 }], TODAY);
  check('ACWR 미래 데이터 무시', r.acute === 0 && r.chronic === 0, JSON.stringify(r));

  // 데이터 없음 → acwr null
  r = calcACWR([], TODAY);
  check('ACWR 빈 데이터 → null', r.acwr === null, r.acwr);

  // rpe나 duration이 0/누락이면 sRPE 0으로 스킵
  r = calcACWR([{ date: TODAY, rpe: 0, dur: 60 }, { date: TODAY, rpe: 7, dur: null }], TODAY);
  check('ACWR 불완전 데이터 스킵', r.acute === 0, r.acute);
})();

// ── calcMVExposure ──────────────────────────────────────────
// 기준: zone5 = mss × 0.9, 21일 창, 최근 7일 최고속도
(function () {
  const MSS = 30; // → zone5 임계 27.0
  let r = calcMVExposure([{ date: TODAY, maxSpeed: 27 }], MSS, TODAY);
  check('MV 임계값(=90%)은 노출로 인정', r.daysSinceExposed === 0, r.daysSinceExposed);

  r = calcMVExposure([{ date: TODAY, maxSpeed: 26.9 }], MSS, TODAY);
  check('MV 90% 미만은 미노출', r.daysSinceExposed === 99, r.daysSinceExposed);

  r = calcMVExposure([], MSS, TODAY);
  check('MV 최근 데이터 없음 표시', r.hasData === false, JSON.stringify(r));

  // 10일 전 마지막 노출
  r = calcMVExposure([
    { date: dstr(TODAY, -10), maxSpeed: 28 },
    { date: dstr(TODAY, -3), maxSpeed: 25 },
  ], MSS, TODAY);
  check('MV 마지막 노출일 계산', r.daysSinceExposed === 10, r.daysSinceExposed);

  // 노출비율: 21일 내 세션 4개 중 2개 노출
  r = calcMVExposure([
    { date: dstr(TODAY, -1), maxSpeed: 28 }, { date: dstr(TODAY, -2), maxSpeed: 20 },
    { date: dstr(TODAY, -3), maxSpeed: 27.5 }, { date: dstr(TODAY, -4), maxSpeed: 22 },
  ], MSS, TODAY);
  check('MV 노출비율', approx(r.exposureRatio, 0.5), r.exposureRatio);

  // 주간 최고속도 %MSS: 최근 7일만 반영 (8일 전 29는 제외)
  r = calcMVExposure([
    { date: dstr(TODAY, -8), maxSpeed: 29 },
    { date: dstr(TODAY, -2), maxSpeed: 24 },
  ], MSS, TODAY);
  check('MV 주간최고 7일 창', approx(r.pctMSS, 80), r.pctMSS);

  // MSS 없으면 null
  check('MV MSS 없음 → null', calcMVExposure([{ date: TODAY, maxSpeed: 30 }], 0, TODAY) === null);
})();

// ── calcWellnessRisk ────────────────────────────────────────
(function () {
  const base7 = Array(7).fill({ fatigue: 4, sleep_quality: 4, stress: 4, muscle_soreness: 4 }); // 총점 16
  let r = calcWellnessRisk(base7, { fatigue: 3, sleep_quality: 3, stress: 3, muscle_soreness: 3 }); // 총점 12
  check('웰니스 하락률', approx(r.dropPct, 0.25), r.dropPct);
  check('웰니스 절대점수', r.absScore === 12, r.absScore);
  check('웰니스 데이터 없음 → null', calcWellnessRisk([], { fatigue: 3 }) === null);
})();

// ── calcRiskLevel ───────────────────────────────────────────
// 기준: ACWR >1.5 +3 / >1.3 +2 / <0.8 +1, MV ≥14일 +3 / ≥7일 +2,
//        웰니스 ≤8점 +2 / 급락 25% +2 / 15% +1 → 4+ red, 2+ amber, 1+ yellow
(function () {
  let r = calcRiskLevel(1.6, null, null);
  check('위험등급 ACWR 1.6 → +3 amber', r.score === 3 && r.level === 'amber', JSON.stringify({ s: r.score, l: r.level }));

  r = calcRiskLevel(1.35, null, null);
  check('위험등급 ACWR 1.35 → +2 amber', r.score === 2 && r.level === 'amber', r.score);

  r = calcRiskLevel(0.5, null, null);
  check('위험등급 ACWR 0.5 → +1 yellow', r.score === 1 && r.level === 'yellow', r.score);

  r = calcRiskLevel(1.0, null, null);
  check('위험등급 정상 → green', r.score === 0 && r.level === 'green', r.score);

  // ACWR 과부하 + MV 14일 미노출 → 3+3 = 6 → red
  r = calcRiskLevel(1.6, { daysSinceExposed: 14, pctMSS: 70 }, null);
  check('위험등급 복합 red', r.score === 6 && r.level === 'red', r.score);
  check('위험등급 플래그 2개', r.flags.length === 2, r.flags.length);

  // MV 7일 경계
  r = calcRiskLevel(null, { daysSinceExposed: 7, pctMSS: 95 }, null);
  check('위험등급 MV 7일 → +2', r.score === 2, r.score);

  // 웰니스 총점 8 이하 → +2
  r = calcRiskLevel(null, null, { absScore: 8, dropPct: 0 });
  check('위험등급 웰니스 과훈련 → +2', r.score === 2, r.score);

  // acwr 0은 과소부하로 치지 않음 (acwr > 0 조건)
  r = calcRiskLevel(0, null, null);
  check('위험등급 ACWR 0 → 무시', r.score === 0, r.score);

  r = calcRiskLevel(null, { daysSinceExposed: 99, pctMSS: 0, hasData: false }, null);
  check('MV 데이터 없음은 위험으로 계산하지 않음', r.score === 0 && r.flags.length === 0, JSON.stringify(r));
})();

// ── calcSuitability ─────────────────────────────────────────
(function () {
  const redFlag = [{ type:'ACWR', level:'red', msg:'ACWR 1.80 — 급성 과부하 (>1.5)' }];
  check('개별 red 신호는 회복일에도 최소 조정 검토', calcSuitability('amber', 'low', redFlag, true) === 'review');
  check('오늘 계획 없음 → 데이터 부족', calcSuitability('green', null, [], true) === 'unknown');
  check('판정 데이터 없음 → 데이터 부족', calcSuitability('green', 'mid', [], false) === 'unknown');
  check('정상 데이터와 계획 → 정상', calcSuitability('green', 'low', [], true) === 'ok');
})();

// ── calcGpsForecastMetrics ──────────────────────────────────
(function () {
  let r = calcGpsForecastMetrics(Array(28).fill(100));
  check('GPS 일정 부하 EWMA ACWR 1.0', approx(r.ewma, 1), r.ewma);
  check('GPS 일정 부하 롤링 ACWR 1.0', approx(r.rolling, 1), r.rolling);
  check('GPS 일정 부하 모노토니 무한', r.monotony === Infinity, r.monotony);

  r = calcGpsForecastMetrics([...Array(27).fill(100), 400]);
  check('GPS 급증 시 EWMA가 롤링보다 민감', r.ewma > r.rolling, JSON.stringify(r));

  r = calcGpsForecastMetrics(Array(28).fill(0));
  check('GPS 휴식만 있으면 비율 없음', r.ewma === null && r.rolling === null, JSON.stringify(r));
  check('GPS 휴식만 있으면 모노토니/스트레인 0', r.monotony === 0 && r.strain === 0, JSON.stringify(r));
})();

// ── 주기화 데이터 존재일 통합 ──────────────────────────────
(function () {
  const gps=[
    {session_date:'2026-07-01',session_type2:'M',track:'ALL'},
    {session_date:'2026-07-02',session_type2:'S',track:'ALL'},
    {session_date:'2026-07-03',session_type2:'SS',track:'ALL'},
    {session_date:'2026-07-04',session_type2:'M',track:'B'},
  ];
  const matches=[{match_date:'2026-07-05'}];
  const a=buildPeriodKnownDates(gps,matches,'ALL');
  check('엔트리 완성도는 M 외 훈련 분류를 제외', !a['2026-07-02']&&!a['2026-07-03']);
  check('A팀 완성도에 경기 테이블 날짜 통합', !!a['2026-07-05']);
  check('A팀 완성도에서 B트랙 제외', !a['2026-07-04']);
  const b=buildPeriodKnownDates(gps,matches,'B');
  check('B팀 완성도는 B트랙만 인정하고 경기 공용 테이블 제외', !!b['2026-07-04']&&!b['2026-07-05']);
})();

// ── 개인 경기일 FT + TOP 부하 통합 ─────────────────────────
(function () {
  const rows=[
    {match_date:'2026-08-04',time_type:'FT',duration:20,td:2200,band4_td:80,band5_td:20,accel:6,rhie:4,max_speed:30.1,player_load:180,opponent:'테스트FC'},
    {match_date:'2026-08-04',time_type:'Top',duration:11,td:1100,band4_td:35,band5_td:12,accel:4,rhie:3,max_speed:29.2,player_load:90,opponent:'테스트FC'},
  ];
  const r=combineIndividualMatchLoads(rows)[0];
  check('개인 경기일 FT+TOP 표시', r.load_label==='FT + TOP', r.load_label);
  check('개인 경기일 활동시간 합산', r.duration===31, r.duration);
  check('개인 경기일 GPS 부하 합산', r.td===3300&&r.running_high===115&&r.player_load===270, JSON.stringify(r));
  check('개인 경기일 최고속도는 최댓값', approx(r.max_speed,30.1), r.max_speed);
})();

// ── 결과 ────────────────────────────────────────────────────
(function () {
  const row = (peak, rolling, monotony) => ({ enough:true, peak, rolling, monotony });
  check('주기화 상태는 롤링 단독 상승을 경고로 판정하지 않음', getPeriodForecastStatus([row(1.1, 1.8, 1.1)]).label === '안정');
  check('주기화 상태 EWMA 1.3부터 주의', getPeriodForecastStatus([row(1.3, 1.0, 1.0)]).label === '확인 필요');
  check('주기화 상태 모노토니 2.0부터 높음', getPeriodForecastStatus([row(1.0, 1.0, 2.0)]).label === '부하 확인');
  check('EWMA 주의 경계 1.30', periodForecastFlag(1.3, 'ratio').level === 1);
  check('모노토니 주의 경계 1.50', periodForecastFlag(1.5, 'monotony').level === 1);
  check('과거 부하 근거 부족 시 판정 보류', getPeriodForecastStatus([row(1.5, 1.5, 1.6)],[{reliable:false}]).label === '판정 보류');
})();

// ── 결과 ────────────────────────────────────────────────────
print('');
if (_fail === 0) print('✅ 전체 통과: ' + _pass + '개 테스트');
else { print('❌ 실패 ' + _fail + '개 / 통과 ' + _pass + '개'); quit(1); }
