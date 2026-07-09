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
})();

// ── 결과 ────────────────────────────────────────────────────
print('');
if (_fail === 0) print('✅ 전체 통과: ' + _pass + '개 테스트');
else { print('❌ 실패 ' + _fail + '개 / 통과 ' + _pass + '개'); quit(1); }
