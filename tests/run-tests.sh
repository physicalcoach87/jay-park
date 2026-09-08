#!/bin/bash
# 핵심 계산 함수 회귀 테스트 실행기
# index-dev.html에서 계산 함수들을 추출해 tests/calc-tests.js와 함께 jsc로 실행
set -e
DIR="$(cd "$(dirname "$0")/.." && pwd)"
JSC=/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc
TMP=$(mktemp /tmp/jaypark-tests.XXXXXX.js)

python3 - "$DIR/index-dev.html" "$TMP" << 'PYEOF'
import re, sys
html = open(sys.argv[1]).read()
required_types = "const PLAYER_TRAINING_TYPES=['M','S','SS','X','G','R'];"
if required_types not in html:
    sys.exit('선수 훈련 유형 M/S/SS/X/G/R 정의가 올바르지 않음')
for label in ['주전','서브','스페셜 훈련','미엔트리','그룹/개별훈련','재활훈련']:
    if label not in html:
        sys.exit(f'선수 훈련 유형 표시 누락: {label}')
funcs = ['calcACWR', 'calcMVExposure', 'calcWellnessRisk', 'calcRiskLevel', 'calcSuitability', 'calcGpsForecastMetrics', 'getPeriodForecastStatus', 'periodForecastFlag', 'buildPeriodKnownDates', 'combineIndividualMatchLoads', 'matchTeamNormalizedValue', 'matchRecordKey', 'recentMatchKeys', 'matchBaselineForKeys', 'recentMatchBaseline', 'summarizeRepresentativeSessions', 'periodDateRange', 'normalizePlanMdKey', 'compressPeriodSchedule', 'periodShiftDate', 'buildBlockScheduleLabel', 'periodDateDiff', 'isPeriodRestDay']
out = []
for name in funcs:
    m = re.search(r'function ' + name + r'\([^)]*\)\{', html)
    if not m:
        sys.exit(f'함수를 찾을 수 없음: {name}')
    # 중괄호 매칭으로 함수 본문 추출
    i = html.index('{', m.start()); depth = 0; j = i
    while j < len(html):
        if html[j] == '{': depth += 1
        elif html[j] == '}':
            depth -= 1
            if depth == 0: break
        j += 1
    out.append(html[m.start():j+1])
open(sys.argv[2], 'w').write('\n'.join(out) + '\n')
PYEOF

grep -q "IN ('M', 'S', 'SS', 'X', 'G', 'R')" "$DIR/supabase/migrations/033_expand_player_training_types.sql"

cat "$DIR/tests/calc-tests.js" >> "$TMP"
if [ -x "$JSC" ]; then
  "$JSC" "$TMP"
else
  node -e "global.print=console.log;require(process.argv[1])" "$TMP"
fi
STATUS=$?
rm -f "$TMP"
exit $STATUS
