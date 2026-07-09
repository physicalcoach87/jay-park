# 선수관리 프로그램 — 프로젝트 컨텍스트 & 작업 지침

## 프로젝트 개요

**목적:** 선수단 피지컬 퍼포먼스 관리 시스템  
**운영자:** 피지컬 코치 (박 코치)  
**현재 상태:** 운영 중 (실데이터 연동)

---

## 배포 정보

| 항목 | 값 |
|------|-----|
| 코치 앱 URL | https://physicalcoach87.github.io/jay-park |
| 선수 앱 URL | https://physicalcoach87.github.io/ipark-player |
| GitHub (코치) | `physicalcoach87/jay-park` — `index.html` 단일 파일 |
| GitHub (선수) | `physicalcoach87/ipark-player` |
| Supabase URL | `https://gmrhkbddhzpfqzkhuvgf.supabase.co` |
| Supabase anon key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...HMn3UIXqV2YJA5f067VpjNmgNU-yzusbDTOh3SC54cI` |

---

## Supabase 테이블 구조

```
player_profiles     선수 등록 (name, position, mas, mss, asr, phone, dob, height, weight, language)
                    ★ Match Max 컬럼 추가됨:
                      match_max_td, match_max_mpm, match_max_hir, match_max_band5_td,
                      match_max_accel, match_max_rhie, match_max_speed, match_max_pl,
                      match_max_updated

gps_records         GPS 데이터 (session_date, player_id, td, running_high, sprint, accel,
                      rhie, max_speed, player_load, duration, fmp_run_medium, fmp_run_high,
                      fmp_dyn_medium, fmp_dyn_high, cycle, periodization, session_topic,
                      opponent, home_away, score, result, session_type2)

wellness_records    웰니스 (record_date, player_id, fatigue, sleep_quality, stress,
                      muscle_soreness, morning_weight)

session_records     RPE (record_date, player_id, rpe, duration)

fitness_records     체력 테스트
injury_records      부상 이력 (body_part, injury_type, severity, status, injury_date,
                      return_date, notes)
                    status 값: 치료중 / 재활중 / 복귀 / 완치

match_records       경기 데이터 ★ 신규 테이블
                    (match_date, player_id, opponent, home_away, round, time_type,
                     duration, td, mpm, hir_sprint, band3_td~band5_td, band4_n, band5_n,
                     accel, decel, max_speed, player_load, rhie, fmp_*, score, result)

notifications       알림 메시지
video_links         영상 링크
custom_programs     개인 프로그램
```

---

## session_type2 핵심 로직 (중요!)

```
session_type2 = 'M'  → 팀 전체훈련 (주전/엔트리) → 팀 평균에 포함
session_type2 = 'S'  → 서브/미엔트리 → 팀 평균 제외, S 배지 표시
session_type2 = null → 과거 데이터, S와 동일 처리
```

**규칙:**
- M이 1개라도 있는 날 → M 기준 팀 평균 (주간 합계 포함)
- M이 없는 날 (S 날) → S 기준 평균 (주간 합계 제외)
- 개인 데이터 표시 시 → session_type2 필터 없이 전체 표시

---

## 코치 앱 탭 구조

```
📋 Morning Report     로그인 첫 화면 (관리자 전용)
📊 선수 통합관리
    ├── 팀 요약        2주 달력 + 날짜 조회
    ├── 👤 선수 개인데이터
    ├── 💚 웰니스
    ├── 👥 선수 명단
    └── 📤 GPS 업로드
근력 운동
Pre-activation
유산소 운동
📅 주기화             주기화 플랜 입력 / 라벨 관리 (cycle, periodization 컬럼 연동)
📋 프로그램 관리
🔔 알림/메시지
    ├── ⚠️ 부상위험    자동 분석
    ├── 📢 공지 알림
    └── 💬 1:1 메시지
🏟️ 경기 데이터        ★ 신규
    ├── 📋 경기 목록
    ├── 👤 선수별 분석
    └── 🏆 Match Max
```

---

## 핵심 기능 구현 현황

### Morning Report (로그인 첫 화면)
- 이번 주 팀 부하 흐름 테이블 (M 기준 날짜별 팀 평균 합산)
  - 주간 누적: TD / HSR / Sprint / 가속 / RHIE / sRPE
- 부상자 현황 (치료중/재활중/복귀 + 부상 N일째)
- 부상 위험 선수 (CRI 기반, 클릭 시 14일 데이터 패널)
- 오늘 권장 운동 부하 (MD 단계별 목표 범위)
- 팀 웰니스 + 미응답 선수 발송

### 부상 위험 예측 엔진
```
Module 1: ACWR (Gabbett 2016)
  Acute = 최근 7일 sRPE 합산 (duration × rpe)
  Chronic = 최근 28일 평균 × 7
  > 1.5 🔴 / 1.3~1.5 🟠 / 0.8~1.3 🟢 / < 0.8 🟡

Module 2: 최고속도 90% 이상 노출 (Malone 2017)
  Zone5 = MSS × 0.9 이상
  14일 이상 노출 안됨 🔴 / 7일 이상 🟠

Module 3: 웰니스 급락
  7일 기준선 대비 25%↑ 급락 🔴 / 15%↑ 🟠

CRI = 모듈 가중합 → ≥4 🔴 / 2~3 🟠 / 1 🟡
```

### MSS 자동 갱신
- GPS 업로드 시 선수별 max_speed가 player_profiles.mss보다 크면 자동 갱신 + 코치 알림

### 팀 요약 2주 달력
- 날짜 카드: 요일/월일 + M/S 배지 + 세션명(최빈값) + 상대 + TD/HSR/Sprint/가속/RHIE
- M 배지: 파란색 (주전/엔트리), S 배지: 회색 (서브/미엔트리)
- 클릭 시 선수별 상세 패널 (팀 평균 M 기준 + 서브 평균 S 기준)

### 선수 개인데이터
- 기간 평균 GPS 카드 (운동시간/TD/HSR/Sprint/가속/RHIE/최고속도/RPE/sRPE/P.Load)
- FMP 상세 (Running M/H, Dynamic M/H)
- 세션별 이력 테이블 (날짜/주기/훈련주제/시간/TD/HSR/Sprint/가속/RHIE/최고속도/RPE/sRPE/주기화)
- 부상 이력 (추가/수정/삭제 모달 — 재활중 포함)
- 엑셀 다운로드

### 경기 데이터 탭 (신규)
- 엑셀 업로드 (BePro 형식: 날짜/경기상대/TIME/이름/지표들)
- TIME: FT/1Q/2Q
- Match Max 자동 계산 (FT 기준, player_profiles에 저장)
- 경기 목록 → 클릭 시 선수별 상세 + Match Max 대비 %
- 선수별 분석 (경기 이력 + 평균 vs Max)

---

## Match Max 비교 로직

```
FT(풀타임) 데이터만 사용

절대 비교: 훈련 TD / Match Max TD × 100
강도 비교: 훈련 MPM / Match Max MPM × 100 (시간 정규화)

색상 기준:
  🟢 ≥ 80%   충분한 경기 대비 자극
  🟡 60~79%  주의
  🔴 < 60%   경기 대비 노출 부족
```

---

## 주기화 구조

```
[MD-5 기반]
MD-5: 고볼륨/저강도 (회복/미엔트리)
MD-4: 고볼륨/중강도 (근력+필드)
MD-3: 고볼륨/고강도 (최대 부하일)
MD-2: 저볼륨/고강도 (최대 스피드)
MD-1: 저볼륨/저강도 (테이퍼링)

[MD-4 기반]
MD-4: 고볼륨/저강도 → MD-3: 최대부하 → MD-2: 고속 → MD-1: 테이퍼
```

---

## 코딩 작업 규칙

### 파일 구조
- 코치 앱: `index.html` 단일 파일 (현재 약 7,500줄)
- 모든 CSS/JS 인라인
- Supabase JS CDN 사용

### 수정 원칙
1. **str_replace로 정확한 타겟만 수정** — 관련 없는 코드 건드리지 않기
2. **매번 `node --check`로 JS 문법 검증**
3. **onclick 속성에 백틱/따옴표 중첩 금지** — 전역 변수나 헬퍼 함수로 분리
4. **수정 후 반드시 outputs 복사 + present_files**

### 자주 쓰는 패턴
```javascript
// Supabase 조회
const {data} = await supa.from('테이블').select('*').eq('field', value);

// sRPE 계산
const sRPE = duration * rpe;

// session_type2 필터 (항상 대소문자 정규화)
.filter(r => (r.session_type2||'').trim().toUpperCase() === 'M')

// 날짜 계산
const since = new Date(); since.setDate(since.getDate()-N);
const sinceStr = since.toISOString().split('T')[0];
```

---

## 다음 작업 예정

### 선수 앱 수정 (우선순위 높음)
- 현재 선수 앱: https://physicalcoach87.github.io/ipark-player
- 수정 필요 사항: (코치님과 논의 예정)

### 경기 데이터 활용
- 훈련 보고서에 Match Max 대비 % 통합
- 일일 훈련 보고서 (기존 엑셀 보고서 형식으로)

### 추후 작업
- Supabase Edge Function (매일 자정 부상 위험 분석 레포트)
- 선수 앱 푸시 알림 연동
