# CLAUDE.md — 선수관리 프로그램 작업 지침
<!-- deploy trigger 2026-05-26 -->

---

## 1. 프로젝트 기본 원칙 (from Anthropic guidelines)

### 코딩 전 생각하기
- 가정하지 말고 명시적으로 확인
- 불명확하면 멈추고 질문
- 더 단순한 방법이 있으면 먼저 제안

### 단순함 우선
- 요청된 것만 구현 — 추측성 기능 추가 금지
- 단일 용도 코드에 불필요한 추상화 금지
- 200줄로 될 걸 50줄로 쓸 수 있으면 다시 쓰기

### 외과적 수정
- 요청된 곳만 건드리기
- 관련 없는 코드 개선/리팩토링 금지
- 기존 스타일 유지

### 검증 루프
- 수정 후 반드시 JS 문법 검증 (node 없으면 macOS 내장 jsc 사용:
  `/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc`)
- **계산 함수(calcACWR/calcMVExposure/calcWellnessRisk/calcRiskLevel) 수정 시
  반드시 `bash tests/run-tests.sh` 실행 → 전체 통과 확인 후 커밋**
- 핵심 변수/함수 존재 확인
- outputs 복사 + present_files로 전달

---

## 2. 프로젝트 정보

### 배포
```
코치 웹앱:    https://physicalcoach87.github.io/jay-park
코치 모바일:  https://physicalcoach87.github.io/jay-park/coach-mobile/
선수 앱:      https://physicalcoach87.github.io/ipark-player
GitHub:       physicalcoach87/jay-park
Supabase:     https://gmrhkbddhzpfqzkhuvgf.supabase.co
anon key:     eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...HMn3UIXqV2YJA5f067VpjNmgNU-yzusbDTOh3SC54cI
```

### 파일 구조
```
jay-park/
├── index.html            ← 코치 웹앱 · 배포본 (단일 파일, ~31,000줄)
├── index-dev.html        ← 위와 동일 내용의 작업본
├── supabase/migrations/  ← DB 스키마 변경 이력
├── tests/run-tests.sh    ← 계산 함수 테스트 (69개)
└── coach-mobile/
    └── index.html        ← 코치 모바일앱 (단일 파일, ~2,500줄)
```
- 모든 CSS/JS 인라인 — 단일 HTML 파일
- Supabase JS CDN 사용
- GitHub Pages로 자동 배포

### index.html ↔ index-dev.html
**두 파일은 항상 바이트 단위로 같아야 한다.** 한쪽만 고치고 커밋하면 배포본과 작업본이
갈라진다. 수정 후 반드시 `shasum index.html index-dev.html`로 일치를 확인할 것.
커밋은 `feat:`/`fix:` (작업본) → `Publish ...` (배포본)로 나눌 수도, 두 파일을 한 커밋에
담을 수도 있다 — 최근 이력은 둘 다 쓴다.

### 코치 모바일앱 탭 구조 (coach-mobile/index.html)
```
🏠 홈       오늘 일정 카드 슬라이드 + 팀 현황 요약 + pull-to-refresh
💚 웰니스   선수별 웰니스 응답 현황 테이블
💢 RPE      선수별 RPE 입력 현황
🏃 훈련     훈련 GPS 요약
💬 알림     공지 발송 / 1:1 채팅 목록
```
- 바텀 탭 네비게이션, PWA(홈화면 추가) 지원
- pull-to-refresh, 카드 캐러셀 방식 일정 표시
- 주간 일정 입력 모달 (week-input overlay) 포함

---

## 3. 핵심 비즈니스 로직

### session_type2 (가장 중요!)
```
'M' → 팀 전체훈련 주전/엔트리 → 팀 평균에 포함, M 배지(파란색)
'S' → 서브/미엔트리         → 팀 평균 제외, S 배지(회색)
null → S와 동일 처리

규칙:
- M이 1개라도 있는 날 → M 기준 팀 평균 (주간 합계 포함)
- M이 없는 날          → S 기준 평균 (주간 합계 제외)
- 개인 데이터 뷰        → 필터 없이 전체 표시
- 항상 trim().toUpperCase() 정규화 후 비교
```

### sRPE 계산
```javascript
sRPE = duration × rpe  // session_records에서 조회
```

### ACWR 계산
```javascript
acute   = 최근 7일 sRPE 합산
chronic = 최근 28일 sRPE 합 ÷ 28 × 7   // 휴식일도 0으로 간주, 항상 28로 나눔 (훈련일수 아님)
acwr    = acute / chronic
// > 1.5 고위험, 1.3~1.5 주의, 0.8~1.3 안전, < 0.8 과소부하
```

### 최고속도 90% 노출 (햄스트링)
```javascript
zone5 = player.mss × 0.9  // 이 이상이면 노출
// 14일 이상 노출 안됨 → 고위험
// 7일 이상 → 주의
```

### Match Max 비교
```javascript
// FT(풀타임) 기준
절대% = 훈련값 / match_max_td × 100
강도% = 훈련MPM / match_max_mpm × 100  // 시간 정규화

// 색상 기준 (분모가 무엇인지에 따라 2단계):
// ① Match Max(경기 기록) 대비        → 80~109% 🟢 / 60~79% 🟡 / <60% 🔴
// ② 주기화 일일 목표(MD단계 %) 대비  → 90~109% 🟢 / 70~89% 🟡 / <70% 🔴
//    (목표가 이미 MD단계로 낮춰져 있으므로 달성률은 더 엄격하게)
// 공통 초과부하: ≥110% 🟠 / >130% 🔴 — 훈련이 경기를 넘을 수 있으므로 초과도 부상위험 신호
// 예외: 경기목록·선수별분석(경기 기록 vs 커리어 Match Max)은 초과 = 신기록이므로 상한 없음
```

---

## 4. Supabase 테이블

```
player_profiles   name, position, mas, mss, language
                  + match_max_td/mpm/hir/accel/rhie/speed/pl/updated

gps_records       session_date, player_id, td, running_high, sprint,
                  accel, rhie, max_speed, player_load, duration,
                  fmp_run_medium/high, fmp_dyn_medium/high,
                  cycle, periodization, session_topic,
                  opponent, home_away, session_type2

wellness_records  record_date, player_id, fatigue, sleep_quality,
                  stress, muscle_soreness, morning_weight

session_records   record_date, player_id, rpe, duration

injury_records    body_part, injury_type, severity, status,
                  injury_date, return_date, notes
                  // status: 치료중/재활중/복귀/완치

match_records     match_date, player_id, opponent, home_away,
                  time_type(FT/1Q/2Q/ET/Top), duration, td, mpm,
                  hir_sprint, band3~5_td, accel, decel,
                  max_speed, rhie, fmp_*, score, result,
                  is_estimated, competition, baseline_excluded
                  ↳ FT  = 정규 경기 전체 (추가시간 포함, 연장 제외)
                    ET  = 연장 전체 (승부차기 제외) — 독립 가산
                    1Q/2Q = FT의 부분집합 (합산 금지)
                    Top = 경기 후 추가훈련 — 독립 가산
                    Match Max·최근 3경기 평균은 FT만 / 개인 부하는 FT+ET+Top
                    is_estimated = GPS 미착용 선수의 코치 추정 입력 (행 단위)
                      출전시간 × 그 선수 최근 실측 FT 분당비율. max_speed는 비움.
                    competition = 리그 / 컵대회 / 연습경기 / 기타
                      기준선에 포함할 대회는 코치가 선택 (기본: 리그만, localStorage)
                    baseline_excluded = 이 경기를 3경기 기준선에서 통째로 제외 (경기 단위)
                      추정이 한 명이라도 섞이면 저장 시 자동 true. 코치가 수동 토글도 가능.
                    → 셋 다 기준선(Match Max·3경기 평균)에서만 제외, 부하·보고서에는 포함
                    상세 규격: MATCH_ET_SPEC.md
                      migrations/023_match_estimated.sql · 024_match_competition.sql

notifications     title, body, target_type, target_value
```

---

## 5. 코딩 패턴

```javascript
// Supabase 조회
const {data} = await supa.from('table').select('*').eq('field', val);

// 날짜 범위
const since = new Date(); since.setDate(since.getDate()-N);
const sinceStr = since.toISOString().split('T')[0];

// session_type2 필터 (항상 정규화)
.filter(r => (r.session_type2||'').trim().toUpperCase() === 'M')

// onclick에 복잡한 데이터 전달 금지 → 전역 변수 사용
window._someData = data;
// onclick="handleClick()" 에서 window._someData 참조

// 알림 발송
await supa.from('notifications').insert({
  title, body, target_type:'player', target_value: playerId,
  created_by: currentUser?.email||'coach'
});
```

---

## 6. 탭 구조 (2026-09-09 기준)

메인 탭은 5개. 주기화·운동처방·GPS데이터는 **독립 탭이 아니라 스포츠 사이언스의 하위 탭**이다.

```
📋 데일리 브리핑      (admin-only, 관리자 로그인 첫 화면)
📊 스포츠 사이언스     ← 하위 탭 7개, 아래 참조
🔔 알림/메시지        부상위험 / 공지 / 1:1메시지
⚙️ 설정               선수 명단 / 권한 설정 / 데이터 내보내기
🏢 팀 관리            기본 display:none (슈퍼관리자만 노출)
```

### 스포츠 사이언스 (`tab-players`) 하위 탭 — 화면 표시 순서

| 순서 | 버튼 | id | admin-only |
|---|---|---|---|
| 1 | 📅 주기화 | `pvbtn-period` | ✔ |
| 2 | 🧬 훈련 적합성 판정 | `pvbtn-suitability` | |
| 3 | 📊 팀 부하 관리 | `pvbtn-team` | |
| 4 | 💚 컨디션 모니터링 | `pvbtn-wellness` | |
| 5 | 👤 선수 개인데이터 | `pvbtn-dashboard` | ✔ |
| 6 | 🏋️ 운동 처방 | `pvbtn-exercise` | ✔ |
| 7 | 📡 GPS 데이터 | `pvbtn-training` | ✔ |

- **기본 진입 뷰**: 관리자 `period` / 비관리자 `team` (`switchTab` 내부).
  `tab-period` div에는 권한 게이트가 없고 **버튼에만** `admin-only`가 붙어 있어서,
  무조건 `period`를 열면 비관리자에게 주기화 화면이 노출된다. 반드시 `isAdmin`으로 가른다.
- 버튼 순서는 자유롭게 바꿔도 된다 — `setPlayerView`·권한 맵·권한 편집기가 모두 **id로만**
  참조하고 DOM 순서에 의존하지 않는다.
- `period`·`exercise`는 `pv-*` div가 아니라 **별도 `tab-period`/`tab-exercise` div를 토글**한다
  (`setPlayerView`의 `_isExternal` 분기).
- 권한 제어 이원화: `pvbtn-period`·`pvbtn-exercise`는 `admin-only` 클래스로만,
  나머지 5개는 `userPermissions[id]`로 제어된다.

```
📡 GPS 데이터 하위      일일 데이터 / 경기 데이터 / GPS 업로드   (setGpsDataView)
🏋️ 운동 처방 하위       근력 운동 / Pre-activation / 유산소 /
                        체력 테스트* / 휴식기 플랜* / 프로그램 관리*   (*=admin-only)
```

---

## 7. 세션 시작 시 자동 실행

새 대화 시작 시 **반드시** 아래를 먼저 실행:
```bash
cd ~/jay-park && git pull
```
사용자가 말하지 않아도 항상 최신 코드를 받고 작업 시작.

---

## 8. 작업 순서 체크리스트

```
□ git pull — 최신 코드부터
□ grep/read로 정확한 위치 파악 (index.html은 3만 줄, 추측 금지)
□ 순서·인덱스 의존 코드가 있는지 확인 후 수정
□ JS 문법 검증 — <script> 블록 추출 후 node --check
□ 계산 함수 건드렸으면 bash tests/run-tests.sh (69개 전체 통과)
□ cp index.html index-dev.html → shasum으로 일치 확인
□ 커밋 · 푸시 (사용자 승인 후)
```

### 설명 방식
사용자는 **코딩 비전문가**다. 대화에서는 코드 조각·변수명·줄번호·전문용어를 빼고,
**화면에서 무엇이 어떻게 달라지는지**를 먼저 말한다. 기술적 상세는 커밋 메시지와
코드 주석에 남긴다. 단, 판단이 필요한 선택지는 계속 물어볼 것.

---

## 9. 다음 예정 작업

### 선수 앱 수정 (우선순위 1)
- GitHub: `physicalcoach87/ipark-player`
- 수정 내용: 코치님과 논의 중

### 경기 데이터 활용
- 일일 훈련 보고서에 Match Max 대비 % 표시
- 기존 엑셀 보고서 형식 재현

### 인프라
- Supabase Edge Function (자정 자동 부상 분석)
- 푸시 알림 연동

-
