# CLAUDE.md — 부산아이파크 코치 앱 작업 지침
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
- 수정 후 반드시 `node --check`로 JS 문법 검증
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
├── index.html            ← 코치 웹앱 (단일 파일, ~17,000줄)
└── coach-mobile/
    └── index.html        ← 코치 모바일앱 (단일 파일, ~1,750줄)
```
- 모든 CSS/JS 인라인 — 단일 HTML 파일
- Supabase JS CDN 사용
- GitHub Pages로 자동 배포

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
chronic = 최근 28일 sRPE 평균 × 7
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
// ≥80% 🟢 / 60~79% 🟡 / <60% 🔴
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
                  time_type(FT/1Q/2Q), duration, td, mpm,
                  hir_sprint, band3~5_td, accel, decel,
                  max_speed, rhie, fmp_*, score, result

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

## 6. 탭 구조 (현재)

```
📋 Morning Report     (관리자 전용, 로그인 첫 화면)
📊 선수 통합관리      팀요약 / 선수개인데이터 / 웰니스 / 선수명단 / GPS업로드
근력 운동
Pre-activation
유산소 운동
📋 프로그램 관리
🔔 알림/메시지        부상위험 / 공지 / 1:1메시지
🏟️ 경기 데이터       경기목록 / 선수별분석 / Match Max
```

---

## 7. 작업 순서 체크리스트

```
□ 현재 코드 view/grep으로 정확한 위치 파악
□ str_replace로 정확한 타겟만 수정
□ node --check JS 문법 검증
□ 핵심 키워드 존재 확인
□ cp outputs + present_files
□ GitHub 업로드 안내
```

---

## 8. 다음 예정 작업

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
