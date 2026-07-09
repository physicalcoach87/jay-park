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
funcs = ['calcACWR', 'calcMVExposure', 'calcWellnessRisk', 'calcRiskLevel']
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

cat "$DIR/tests/calc-tests.js" >> "$TMP"
"$JSC" "$TMP"
STATUS=$?
rm -f "$TMP"
exit $STATUS
