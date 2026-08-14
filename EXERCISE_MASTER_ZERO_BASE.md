# 운동 마스터 제로베이스 명세

## 1. 공통 원칙

- 운동은 한글 대표명과 영문명을 한 행에 저장한다.
- 근지구력·근비대·최대근력은 운동 종류가 아니라 부하, 반복, 세트, 휴식, 수행 속도로 결정한다.
- 각 운동은 `주 분류` 하나와 여러 개의 `연결 분류·역할`을 가진다.
- 직접 대체 운동은 같은 운동군에서만 제시한다. 다른 운동군은 보완 또는 슈퍼세트 조합으로만 제시한다.
- 맨몸·밴드 운동은 워밍업·활성화·보조 역할을 우선하되, 외부 부하와 난이도에 따라 메인·파워 역할을 허용한다.
- 운동 역할: `워밍업`, `활성화`, `메인`, `보조`, `파워`, `회귀·복귀`, `평가`.
- 진행 단계: `회귀`, `기본`, `발전`, `고급`.
- 피로 비용: `낮음`, `중간`, `높음`.
- 프리액티베이션은 동일 마스터에서 `워밍업·활성화·파워` 역할과 낮은 피로 비용 운동만 조회한다.

## 2. 필수 데이터 필드

| 필드 | 설명 |
|---|---|
| name_ko / name_en | 한글 대표명 / 영문명 |
| region / body_part | 상체·하체·전신파워·코어 / 세부 부위 |
| display_group | 코치 화면에 표시할 운동군 |
| movement_pattern | 내부 동작 패턴 |
| primary / secondary muscles | 주동근 / 협력근 |
| equipment | 사용 기구 |
| laterality | 양측·단측·교대 |
| primary_role / available_roles | 주 역할 / 사용 가능 역할 |
| progression_level | 회귀·기본·발전·고급 |
| fatigue_cost | 낮음·중간·높음 |
| regressions / alternatives / progressions | 회귀·직접 대체·발전 운동 관계 |
| contraindications | 통증·부상·동작 제한 확인 태그 |
| coaching_cue | 핵심 코칭 포인트 |

# 상체

## 3. 가슴

### 3.1 가슴 전체

내부 패턴: 수평 밀기

- 벽 푸시업 / Wall Push-up — 회귀·복귀, 워밍업
- 인클라인 푸시업 / Incline Push-up — 워밍업, 회귀·활성화
- 니 푸시업 / Knee Push-up — 회귀, 보조
- 푸시업 / Push-up — 보조, 워밍업·활성화
- 바벨 벤치프레스 / Barbell Bench Press — 메인
- 덤벨 벤치프레스 / Dumbbell Bench Press — 메인, 보조
- 시티드 체스트 프레스 / Seated Chest Press — 메인, 회귀·보조
- 뉴트럴그립 덤벨 벤치프레스 / Neutral-Grip Dumbbell Bench Press — 보조, 어깨 부담 조절
- 덤벨 플로어 프레스 / Dumbbell Floor Press — 보조, 가동범위 제한
- 싱글암 덤벨 벤치프레스 / Single-Arm Dumbbell Bench Press — 보조, 단측·코어 안정화
- 웨이티드 푸시업 / Weighted Push-up — 메인·보조, 발전
- 디피싯 푸시업 / Deficit Push-up — 보조, 발전
- 서스펜션 푸시업 / Suspension Push-up — 보조, 몸통·견갑 안정화

### 3.2 위가슴

내부 패턴: 경사 수평 밀기

- 인클라인 바벨 벤치프레스 / Incline Barbell Bench Press — 메인
- 인클라인 덤벨 벤치프레스 / Incline Dumbbell Bench Press — 메인·보조
- 인클라인 체스트 프레스 / Incline Chest Press — 메인, 안정적 부하
- 싱글암 인클라인 덤벨 프레스 / Single-Arm Incline Dumbbell Press — 보조, 단측 안정화
- 로우 인클라인 덤벨 프레스 / Low-Incline Dumbbell Press — 보조
- 로우 투 하이 케이블 프레스 / Low-to-High Cable Press — 보조
- 랜드마인 프레스 / Landmine Press — 보조, 위가슴·어깨 복합

### 3.3 밑가슴

내부 패턴: 하향 수평 밀기

- 디클라인 바벨 벤치프레스 / Decline Barbell Bench Press — 메인
- 디클라인 덤벨 벤치프레스 / Decline Dumbbell Bench Press — 메인·보조
- 디클라인 체스트 프레스 / Decline Chest Press — 메인
- 어시스트 체스트 딥 / Assisted Chest Dip — 회귀·보조
- 체스트 딥 / Chest Dip — 보조·고급
- 하이 투 로우 케이블 프레스 / High-to-Low Cable Press — 보조

### 3.4 가슴 모으기

내부 패턴: 수평 내전. 프레스의 직접 대체가 아니라 보완 운동.

- 밴드 체스트 플라이 / Band Chest Fly — 활성화·워밍업
- 덤벨 플라이 / Dumbbell Fly — 보조
- 케이블 체스트 플라이 / Cable Chest Fly — 보조
- 펙덱 플라이 / Pec Deck Fly — 보조
- 싱글암 케이블 플라이 / Single-Arm Cable Fly — 보조·단측 안정화
- 로우 투 하이 케이블 플라이 / Low-to-High Cable Fly — 보조·위가슴 연결
- 하이 투 로우 케이블 플라이 / High-to-Low Cable Fly — 보조·밑가슴 연결

### 3.5 가슴 파워

내부 패턴: 폭발적 수평 밀기

- 스탠딩 메디신볼 체스트 패스 / Standing Medicine Ball Chest Pass — 파워·프리액티베이션
- 니링 메디신볼 체스트 패스 / Kneeling Medicine Ball Chest Pass — 파워
- 하프니링 메디신볼 체스트 패스 / Half-Kneeling Medicine Ball Chest Pass — 파워·단측 안정화
- 스플릿 스탠스 체스트 패스 / Split-Stance Chest Pass — 파워·축구 전이
- 월 체스트 패스 / Repeated Wall Chest Pass — 반복 파워
- 플라이오 푸시업 / Plyometric Push-up — 파워
- 메디신볼 푸시업 / Medicine Ball Push-up — 파워·안정화
- 박스 투 박스 플라이오 푸시업 / Box-to-Box Plyometric Push-up — 고급 반응성 파워

## 4. 등

### 4.1 광배근·수직 당기기

- 스캐풀라 풀업 / Scapular Pull-up — 활성화·워밍업
- 밴드 스트레이트암 풀다운 / Band Straight-Arm Pulldown — 활성화
- 어시스트 풀업 / Assisted Pull-up — 회귀·복귀
- 풀업 / Pull-up — 메인·보조
- 친업 / Chin-up — 메인·보조
- 뉴트럴그립 풀업 / Neutral-Grip Pull-up — 메인, 어깨 부담 조절
- 웨이티드 풀업 / Weighted Pull-up — 메인·발전
- 랫 풀다운 / Lat Pulldown — 메인·보조
- 뉴트럴그립 랫 풀다운 / Neutral-Grip Lat Pulldown — 메인·보조
- 언더그립 랫 풀다운 / Underhand Lat Pulldown — 보조
- 싱글암 랫 풀다운 / Single-Arm Lat Pulldown — 보조·단측
- 스트레이트암 풀다운 / Straight-Arm Pulldown — 보조·고립

### 4.2 등 상부·수평 당기기

- 밴드 로우 / Band Row — 활성화·회귀
- 인버티드 로우 / Inverted Row — 보조·회귀
- 서스펜션 로우 / Suspension Row — 보조·몸통 안정화
- 바벨 벤트오버 로우 / Barbell Bent-Over Row — 메인
- 펜들레이 로우 / Pendlay Row — 메인·폭발적 당기기
- 덤벨 원암 로우 / One-Arm Dumbbell Row — 메인·보조·단측
- 체스트 서포티드 덤벨 로우 / Chest-Supported Dumbbell Row — 메인, 허리 부담 감소
- 시티드 케이블 로우 / Seated Cable Row — 메인·보조
- 머신 시티드 로우 / Seated Row Machine — 메인
- T바 로우 / T-Bar Row — 메인
- 랜드마인 원암 로우 / One-Arm Landmine Row — 보조·단측
- 씰 로우 / Seal Row — 메인, 허리 부담 감소
- 하이 로우 머신 / High Row Machine — 보조

### 4.3 견갑 안정화

- 밴드 풀어파트 / Band Pull-Apart — 활성화
- 밴드 페이스 풀 / Band Face Pull — 활성화·프리액티베이션
- 케이블 페이스 풀 / Cable Face Pull — 보조·견갑 외회전
- 프론 Y 레이즈 / Prone Y Raise — 활성화·보조
- 프론 T 레이즈 / Prone T Raise — 보조
- 프론 W 레이즈 / Prone W Raise — 활성화
- Y-T-W 복합 / Y-T-W Complex — 활성화·워밍업
- 밴드 로우 투 외회전 / Band Row to External Rotation — 활성화
- 케이블 로우 투 외회전 / Cable Row to External Rotation — 보조
- 월 슬라이드 / Wall Slide — 활성화·상방회전

### 4.4 척추기립근·허리 안정화

- 버드독 / Bird Dog — 활성화·복귀
- 프론 코브라 / Prone Cobra — 활성화
- 아이소메트릭 백 익스텐션 / Isometric Back Extension — 보조
- 45도 백 익스텐션 / 45-Degree Back Extension — 보조
- 수평 백 익스텐션 / Horizontal Back Extension — 보조·발전
- 리버스 하이퍼 / Reverse Hyperextension — 보조
- 소렌슨 홀드 / Sorensen Hold — 평가·보조

RDL·굿모닝·데드리프트는 등 운동이 아니라 하체 `힙힌지·복합 하체`에 둔다.

## 5. 어깨

### 5.1 어깨 프레스

- 월 오버헤드 리치 / Wall Overhead Reach — 활성화·복귀
- 밴드 오버헤드 프레스 / Band Overhead Press — 활성화·회귀
- 하프니링 랜드마인 프레스 / Half-Kneeling Landmine Press — 보조·단측 안정화
- 스탠딩 랜드마인 프레스 / Standing Landmine Press — 보조
- 머신 숄더 프레스 / Machine Shoulder Press — 메인·회귀
- 시티드 덤벨 숄더 프레스 / Seated Dumbbell Shoulder Press — 메인
- 스탠딩 덤벨 숄더 프레스 / Standing Dumbbell Shoulder Press — 메인·몸통 안정화
- 바벨 오버헤드 프레스 / Barbell Overhead Press — 메인
- 뉴트럴그립 덤벨 프레스 / Neutral-Grip Dumbbell Press — 메인·보조
- 싱글암 덤벨 오버헤드 프레스 / Single-Arm Dumbbell Overhead Press — 보조·단측
- 바텀업 케틀벨 프레스 / Bottoms-Up Kettlebell Press — 보조·안정화
- 아놀드 프레스 / Arnold Press — 보조

### 5.2 측면 어깨

- 밴드 레터럴 레이즈 / Band Lateral Raise — 활성화
- 덤벨 레터럴 레이즈 / Dumbbell Lateral Raise — 보조
- 케이블 레터럴 레이즈 / Cable Lateral Raise — 보조
- 싱글암 케이블 레터럴 레이즈 / Single-Arm Cable Lateral Raise — 보조·단측
- 머신 레터럴 레이즈 / Machine Lateral Raise — 보조
- 린어웨이 레터럴 레이즈 / Lean-Away Lateral Raise — 보조·발전
- 라잉 레터럴 레이즈 / Lying Lateral Raise — 보조
- 스캐풀라 플레인 레이즈 / Scaption Raise — 활성화·보조

### 5.3 후면 어깨

- 밴드 리버스 플라이 / Band Reverse Fly — 활성화
- 덤벨 벤트오버 리버스 플라이 / Bent-Over Dumbbell Reverse Fly — 보조
- 체스트 서포티드 리버스 플라이 / Chest-Supported Reverse Fly — 보조
- 케이블 리버스 플라이 / Cable Reverse Fly — 보조
- 싱글암 케이블 리버스 플라이 / Single-Arm Cable Reverse Fly — 보조·단측
- 리버스 펙덱 / Reverse Pec Deck — 보조
- 리어델트 로우 / Rear-Delt Row — 보조

페이스 풀은 `견갑 안정화`에 한 번만 등록하고 후면 어깨와 연결한다.

### 5.4 회전근개·어깨 안정화

- 밴드 외회전 / Band External Rotation — 활성화·복귀
- 케이블 외회전 / Cable External Rotation — 보조
- 사이드라잉 덤벨 외회전 / Side-Lying Dumbbell External Rotation — 활성화·보조
- 밴드 내회전 / Band Internal Rotation — 활성화·복귀
- 90/90 밴드 외회전 / 90/90 Band External Rotation — 활성화
- 하프니링 90/90 케이블 외회전 / Half-Kneeling 90/90 Cable External Rotation — 보조
- 폼롤러 월 슬라이드 / Foam-Roller Wall Slide — 활성화
- 스캐풀라 푸시업 / Scapular Push-up — 활성화
- 바텀업 케틀벨 캐리 / Bottoms-Up Kettlebell Carry — 안정화
- 오버헤드 캐리 / Overhead Carry — 안정화·전신 연결

### 5.5 어깨 파워

- 메디신볼 오버헤드 스로 / Medicine Ball Overhead Throw — 파워
- 메디신볼 오버헤드 슬램 / Medicine Ball Overhead Slam — 파워
- 싱글암 메디신볼 숄더 스로 / Single-Arm Medicine Ball Shoulder Throw — 파워
- 푸시 프레스 / Push Press — 전신 파워
- 랜드마인 푸시 프레스 / Landmine Push Press — 단측 파워
- 스플릿 스탠스 랜드마인 프레스 / Split-Stance Landmine Press — 파워·축구 전이

## 6. 팔

팔은 독립 메인 세션보다 상체 훈련의 보조와 팔꿈치·손목 부하 내성 관리에 우선 사용한다.

### 6.1 이두근·팔꿈치 굴곡

- 밴드 바이셉 컬 / Band Biceps Curl — 활성화·워밍업
- 덤벨 바이셉 컬 / Dumbbell Biceps Curl — 보조
- 바벨 바이셉 컬 / Barbell Biceps Curl — 보조
- EZ바 컬 / EZ-Bar Curl — 보조, 손목 부담 조절
- 해머 컬 / Hammer Curl — 보조, 상완근·상완요골근
- 인클라인 덤벨 컬 / Incline Dumbbell Curl — 보조
- 프리처 컬 / Preacher Curl — 보조·고립
- 케이블 컬 / Cable Curl — 보조
- 싱글암 케이블 컬 / Single-Arm Cable Curl — 보조·단측
- 리버스 컬 / Reverse Curl — 보조·전완 연결

### 6.2 삼두근·팔꿈치 신전

- 밴드 트라이셉 프레스다운 / Band Triceps Pressdown — 활성화·워밍업
- 케이블 트라이셉 프레스다운 / Cable Triceps Pressdown — 보조
- 로프 트라이셉 프레스다운 / Rope Triceps Pressdown — 보조
- 오버헤드 케이블 트라이셉 익스텐션 / Overhead Cable Triceps Extension — 보조
- 덤벨 오버헤드 트라이셉 익스텐션 / Dumbbell Overhead Triceps Extension — 보조
- 라잉 트라이셉 익스텐션 / Lying Triceps Extension — 보조
- 클로즈그립 벤치프레스 / Close-Grip Bench Press — 메인·보조
- 어시스트 벤치 딥 / Assisted Bench Dip — 회귀·보조
- 벤치 딥 / Bench Dip — 보조·주의
- 싱글암 케이블 프레스다운 / Single-Arm Cable Pressdown — 보조·단측

### 6.3 전완·그립

- 손목 굴곡 / Wrist Curl — 보조·복귀
- 손목 신전 / Wrist Extension — 보조·복귀
- 회내·회외 운동 / Forearm Pronation-Supination — 활성화·복귀
- 플레이트 핀치 / Plate Pinch — 그립 보조
- 데드행 / Dead Hang — 그립·견갑 보조
- 팻그립 홀드 / Fat-Grip Hold — 그립 발전
- 파머스 캐리 / Farmer's Carry — 그립·전신 안정화
- 수트케이스 캐리 / Suitcase Carry — 그립·측면 코어
- 타월 행 / Towel Hang — 그립 고급

# 하체

## 7. 대퇴·무릎 중심

### 7.1 대퇴사두근·양측 무릎 우세

- 스페니시 스쿼트 아이소메트릭 / Spanish Squat Isometric — 활성화·복귀
- 월 싯 / Wall Sit — 활성화·등척성 보조
- 고블릿 스쿼트 / Goblet Squat — 회귀·메인·보조
- 바벨 백 스쿼트 / Barbell Back Squat — 메인
- 프론트 스쿼트 / Front Squat — 메인
- 세이프티바 스쿼트 / Safety-Bar Squat — 메인, 몸통 부담 조절
- 해크 스쿼트 / Hack Squat — 메인
- 레그 프레스 / Leg Press — 메인·보조
- 레그 익스텐션 / Leg Extension — 보조·복귀
- 벨트 스쿼트 / Belt Squat — 메인, 척추 부하 조절

### 7.2 단측 무릎 우세

- 스플릿 스쿼트 아이소메트릭 / Split-Squat Isometric — 활성화·복귀
- 스플릿 스쿼트 / Split Squat — 메인·보조
- 불가리안 스플릿 스쿼트 / Bulgarian Split Squat — 메인·발전
- 리버스 런지 / Reverse Lunge — 메인·보조
- 포워드 런지 / Forward Lunge — 보조·감속
- 워킹 런지 / Walking Lunge — 보조·기능적
- 스텝업 / Step-Up — 메인·보조
- 스텝다운 / Step-Down — 복귀·감속 제어
- 싱글레그 스쿼트 투 박스 / Single-Leg Squat to Box — 회귀·단측
- 피스톨 스쿼트 / Pistol Squat — 고급

### 7.3 내전근·측면 대퇴

- 애덕터 록백 / Adductor Rock-Back — 워밍업·가동성
- 볼 스퀴즈 아이소메트릭 / Ball Squeeze Isometric — 활성화·복귀
- 코펜하겐 플랭크 숏레버 / Short-Lever Copenhagen Plank — 활성화·복귀
- 코펜하겐 플랭크 롱레버 / Long-Lever Copenhagen Plank — 보조·발전
- 측면 런지 / Lateral Lunge — 메인·보조
- 코사크 스쿼트 / Cossack Squat — 보조·가동성
- 케이블 힙 어덕션 / Cable Hip Adduction — 보조
- 슬라이드보드 레터럴 런지 / Slideboard Lateral Lunge — 보조·측면 감속

## 8. 햄스트링

### 8.1 무릎 굴곡

- 브릿지 힐 홀드 / Bridge Heel Hold — 활성화·복귀
- 밴드 레그 컬 / Band Leg Curl — 활성화·보조
- 슬라이더 레그 컬 / Slider Leg Curl — 보조
- 스위스볼 레그 컬 / Swiss-Ball Leg Curl — 보조·몸통 안정화
- 머신 라잉 레그 컬 / Lying Leg Curl — 메인·보조
- 머신 시티드 레그 컬 / Seated Leg Curl — 메인·보조
- 싱글레그 레그 컬 / Single-Leg Leg Curl — 보조·단측
- 어시스트 노르딕 햄스트링 / Assisted Nordic Hamstring Curl — 회귀·보조
- 노르딕 햄스트링 컬 / Nordic Hamstring Curl — 보조·고강도 편심
- 글루트햄 레이즈 / Glute-Ham Raise — 메인·발전

### 8.2 햄스트링 길이·편심 제어

- 인버티드 햄스트링 / Inverted Hamstring — 워밍업·활성화
- 싱글레그 워크아웃 / Single-Leg Hamstring Walkout — 보조
- 햄스트링 워크아웃 / Hamstring Walkout — 활성화·보조
- 플라이휠 레그 컬 / Flywheel Leg Curl — 보조·고급 편심

RDL 계열은 `힙힌지·복합 하체`에 한 번만 등록하고 햄스트링과 연결한다.

## 9. 둔근·고관절

### 9.1 고관절 신전

- 글루트 브리지 / Glute Bridge — 활성화·회귀
- 싱글레그 글루트 브리지 / Single-Leg Glute Bridge — 활성화·단측
- 바벨 글루트 브리지 / Barbell Glute Bridge — 메인·보조
- 힙 쓰러스트 / Hip Thrust — 메인
- 싱글레그 힙 쓰러스트 / Single-Leg Hip Thrust — 보조·단측
- 케이블 풀스루 / Cable Pull-Through — 보조·힌지 학습
- 케이블 힙 익스텐션 / Cable Hip Extension — 보조
- 리버스 하이퍼 / Reverse Hyperextension — 보조, 허리 안정화 연결

### 9.2 고관절 외전·골반 안정화

- 클램쉘 / Clamshell — 활성화·복귀
- 밴드 힙 어브덕션 / Band Hip Abduction — 활성화
- 사이드라잉 힙 어브덕션 / Side-Lying Hip Abduction — 활성화·보조
- 몬스터 워크 / Monster Walk — 활성화·프리액티베이션
- 레터럴 밴드 워크 / Lateral Band Walk — 활성화·프리액티베이션
- 케이블 힙 어브덕션 / Cable Hip Abduction — 보조
- 머신 힙 어브덕션 / Hip Abduction Machine — 보조
- 힙 에어플레인 / Hip Airplane — 안정화·기능적

### 9.3 고관절 굴곡

- 밴드 마치 / Band-Resisted March — 활성화·달리기 준비
- 월 드릴 아이소메트릭 마치 / Wall-Drill Isometric March — 활성화·프리액티베이션
- 케이블 힙 플렉션 / Cable Hip Flexion — 보조
- 행잉 니 드라이브 / Hanging Knee Drive — 보조·코어 연결

## 10. 종아리·발목

### 10.1 무릎 편 상태 족저굴곡·비복근

- 양발 카프 레이즈 / Double-Leg Calf Raise — 활성화·회귀
- 싱글레그 카프 레이즈 / Single-Leg Calf Raise — 보조·단측
- 스탠딩 머신 카프 레이즈 / Standing Machine Calf Raise — 메인·보조
- 레그프레스 카프 레이즈 / Leg-Press Calf Raise — 보조
- 아이소메트릭 카프 홀드 / Isometric Calf Hold — 복귀·건 부하 관리

### 10.2 무릎 굽힌 상태 족저굴곡·가자미근

- 시티드 카프 레이즈 / Seated Calf Raise — 메인·보조
- 벤트니 싱글레그 카프 레이즈 / Bent-Knee Single-Leg Calf Raise — 보조·단측
- 솔레우스 아이소메트릭 홀드 / Soleus Isometric Hold — 활성화·복귀

### 10.3 발목 배측굴곡·발 기능

- 티비얼리스 레이즈 / Tibialis Raise — 활성화·보조
- 밴드 발목 배측굴곡 / Band Ankle Dorsiflexion — 복귀·활성화
- 숏풋 / Short-Foot Exercise — 활성화·발 안정화
- 토 요가 / Toe Yoga — 활성화·발 조절
- 발목 포고 준비 / Ankle Pogo Preparation — 프리액티베이션·점프 연결

## 11. 힙힌지·복합 하체

둔근·햄스트링·척추기립근이 함께 작용하는 종합 패턴이며 특정 근육군의 직접 대체 목록과 분리한다.

- 힙힌지 월 드릴 / Hip-Hinge Wall Drill — 학습·워밍업
- 밴드 힙힌지 / Band Hip Hinge — 활성화·학습
- 케틀벨 데드리프트 / Kettlebell Deadlift — 회귀·메인
- 트랩바 데드리프트 / Trap-Bar Deadlift — 메인
- 컨벤셔널 데드리프트 / Conventional Deadlift — 메인·고급
- 스모 데드리프트 / Sumo Deadlift — 메인
- 루마니안 데드리프트 / Romanian Deadlift — 메인
- 덤벨 루마니안 데드리프트 / Dumbbell Romanian Deadlift — 메인·보조
- 싱글레그 루마니안 데드리프트 / Single-Leg Romanian Deadlift — 보조·단측 안정화
- 킥스탠드 루마니안 데드리프트 / Kickstand Romanian Deadlift — 회귀·단측
- 굿모닝 / Good Morning — 보조·고급
- 케이블 풀스루 / Cable Pull-Through — 보조·힌지 학습

# 전신·파워

## 12. 올림픽 리프트

### 12.1 학습·회귀

- 점프 슈러그 / Jump Shrug
- 하이 풀 / High Pull
- 행 하이 풀 / Hang High Pull
- 클린 풀 / Clean Pull
- 스내치 풀 / Snatch Pull
- 머슬 클린 / Muscle Clean
- 머슬 스내치 / Muscle Snatch

### 12.2 클린 계열

- 행 파워 클린 / Hang Power Clean
- 파워 클린 / Power Clean
- 블록 파워 클린 / Block Power Clean
- 클린 / Clean
- 덤벨 행 파워 클린 / Dumbbell Hang Power Clean
- 케틀벨 클린 / Kettlebell Clean

### 12.3 스내치 계열

- 행 파워 스내치 / Hang Power Snatch
- 파워 스내치 / Power Snatch
- 블록 파워 스내치 / Block Power Snatch
- 덤벨 스내치 / Dumbbell Snatch
- 케틀벨 스내치 / Kettlebell Snatch

### 12.4 저크·드라이브

- 푸시 프레스 / Push Press
- 파워 저크 / Power Jerk
- 스플릿 저크 / Split Jerk
- 푸시 저크 / Push Jerk

올림픽 리프트는 기술 숙련도, 바 속도, 코치 감독을 필수 메타데이터로 관리한다.

## 13. 점프

### 13.1 착지·저강도 준비

- 스냅다운 / Snap Down
- 스쿼트 랜딩 / Squat Landing
- 포고 점프 / Pogo Jump
- 라인 홉 / Line Hop
- 점프 앤드 스틱 / Jump and Stick

### 13.2 수직 점프

- 카운터무브먼트 점프 / Countermovement Jump
- 스쿼트 점프 / Squat Jump
- 박스 점프 / Box Jump
- 허들 점프 / Hurdle Jump
- 반복 수직 점프 / Repeated Vertical Jump
- 웨이티드 점프 스쿼트 / Loaded Jump Squat

### 13.3 수평 점프

- 브로드 점프 / Broad Jump
- 연속 브로드 점프 / Repeated Broad Jump
- 싱글레그 브로드 점프 / Single-Leg Broad Jump
- 바운딩 / Bounding

### 13.4 측면·다방향 점프

- 래터럴 바운드 / Lateral Bound
- 스케이터 점프 / Skater Jump
- 싱글레그 래터럴 홉 / Single-Leg Lateral Hop
- 멀티디렉셔널 홉 / Multidirectional Hop
- 크로스오버 바운드 / Crossover Bound

### 13.5 반응성·드롭 점프

- 드롭 랜딩 / Drop Landing
- 데프스 점프 / Depth Jump
- 드롭 점프 / Drop Jump
- 반복 허들 홉 / Repeated Hurdle Hop
- 싱글레그 포고 / Single-Leg Pogo

반응성·드롭 점프는 고급으로 두고 접촉 횟수, 표면, 착지 품질, 이전 고강도 노출을 확인한다.

## 14. 폭발 동작

### 14.1 메디신볼 던지기

- 메디신볼 체스트 패스 / Medicine Ball Chest Pass
- 메디신볼 오버헤드 스로 / Medicine Ball Overhead Throw
- 메디신볼 오버헤드 슬램 / Medicine Ball Overhead Slam
- 메디신볼 스쿱 토스 / Medicine Ball Scoop Toss
- 메디신볼 로테이셔널 스로 / Medicine Ball Rotational Throw
- 스플릿 스탠스 로테이셔널 스로 / Split-Stance Rotational Throw

### 14.2 탄도성 전신 동작

- 케틀벨 스윙 / Kettlebell Swing
- 덤벨 스내치 / Dumbbell Snatch
- 랜드마인 스러스터 / Landmine Thruster
- 덤벨 스러스터 / Dumbbell Thruster
- 배틀로프 슬램 / Battle Rope Slam
- 배틀로프 얼터네이팅 웨이브 / Battle Rope Alternating Wave

### 14.3 썰매·저항 가속

- 헤비 슬레드 푸시 / Heavy Sled Push
- 라이트 슬레드 스프린트 / Light Sled Sprint
- 슬레드 드래그 / Sled Drag
- 백워드 슬레드 드래그 / Backward Sled Drag
- 레지스티드 마치 / Resisted March

# 코어

## 15. 코어

### 15.1 항신전

- 데드버그 / Dead Bug — 활성화·회귀
- 밴드 데드버그 / Band-Resisted Dead Bug — 발전
- 플랭크 / Front Plank — 기본
- 롱레버 플랭크 / Long-Lever Plank — 발전
- 바디쏘 / Body Saw — 발전
- 앱휠 롤아웃 / Ab-Wheel Rollout — 고급
- 스위스볼 롤아웃 / Swiss-Ball Rollout — 보조

### 15.2 항회전

- 팔로프 프레스 아이소메트릭 / Pallof Press Isometric — 활성화·기본
- 팔로프 프레스 / Pallof Press — 기본
- 하프니링 팔로프 프레스 / Half-Kneeling Pallof Press — 단측 안정화
- 팔로프 프레스 워크아웃 / Pallof Press Walkout — 발전
- 버드독 로우 / Bird-Dog Row — 발전
- 플랭크 숄더 탭 / Plank Shoulder Tap — 보조

### 15.3 항측굴

- 사이드 플랭크 숏레버 / Short-Lever Side Plank — 회귀
- 사이드 플랭크 / Side Plank — 기본
- 스타 사이드 플랭크 / Star Side Plank — 발전
- 수트케이스 캐리 / Suitcase Carry — 기능적
- 오프셋 파머스 캐리 / Offset Farmer's Carry — 기능적

### 15.4 회전·대각선 힘 전달

- 케이블 촙 / Cable Chop
- 케이블 리프트 / Cable Lift
- 하프니링 케이블 촙 / Half-Kneeling Cable Chop
- 랜드마인 로테이션 / Landmine Rotation
- 러시안 트위스트 / Russian Twist — 제한적 보조
- 메디신볼 로테이셔널 스로 / Medicine Ball Rotational Throw — 파워 연결

## 16. 척추 안정화

- 브레이싱 호흡 / Bracing Breathing — 학습·활성화
- 버드독 / Bird Dog — 활성화·복귀
- 맥길 컬업 / McGill Curl-Up — 활성화·복귀
- 프론 플랭크 / Front Plank — 기본
- 사이드 플랭크 / Side Plank — 기본
- 소렌슨 홀드 / Sorensen Hold — 후면 안정화·평가
- 데드버그 / Dead Bug — 항신전 연결
- 베어 플랭크 / Bear Plank — 기능적 안정화

중복 운동은 주 분류에 한 번만 등록하고 척추 안정화 태그로 연결한다.

## 17. 기능적 동작

### 17.1 캐리

- 파머스 캐리 / Farmer's Carry
- 수트케이스 캐리 / Suitcase Carry
- 프론트랙 캐리 / Front-Rack Carry
- 오버헤드 캐리 / Overhead Carry
- 웨이터 캐리 / Waiter's Carry
- 베어허그 캐리 / Bear-Hug Carry

### 17.2 크롤·이동

- 베어 크롤 / Bear Crawl
- 레터럴 베어 크롤 / Lateral Bear Crawl
- 크랩 워크 / Crab Walk
- 크로스 크롤 / Cross Crawl

### 17.3 겟업·전신 연결

- 하프 겟업 / Half Get-Up
- 터키시 겟업 / Turkish Get-Up
- 톨니링 투 스탠드 / Tall-Kneeling to Stand
- 하프니링 리프트 / Half-Kneeling Lift
- 샌드백 숄더링 / Sandbag Shouldering

### 17.4 축구 준비 통합 동작

- 월 드릴 마치 / Wall-Drill March
- A마치 저항 운동 / Resisted A-March
- 스플릿 스탠스 케이블 프레스 / Split-Stance Cable Press
- 스플릿 스탠스 케이블 로우 / Split-Stance Cable Row
- 싱글레그 RDL 투 니드라이브 / Single-Leg RDL to Knee Drive

# 18. 직접 대체와 보완 관계 규칙

1. 직접 대체: 같은 `display_group + movement_pattern + primary_role` 우선.
2. 회귀: 같은 운동군에서 진행 단계가 더 낮고 피로 비용이 같거나 낮은 운동.
3. 발전: 같은 운동군에서 진행 단계 또는 안정성·외부 부하 요구가 더 높은 운동.
4. 보완: 다른 운동군이지만 협력근, 안정화, 반대 패턴을 보완하는 운동.
5. 슈퍼세트: 동일 운동의 대체가 아니라 주동-길항, 메인-보완, 상체-하체 규칙으로 별도 생성.
6. 부상·통증·기구 제한을 통과하지 못한 운동은 모든 후보에서 제외한다.
7. 후보가 부족하면 다른 부위를 자동 삽입하지 않고 부족 사유를 코치에게 표시한다.

## 18.1 복수 분류 운동의 대표 저장 위치

아래 운동은 DB에 한 번만 저장하고 나머지 분류에서는 연결 태그로 조회한다.

| 운동 | 대표 저장 위치 | 연결 분류 |
|---|---|---|
| 페이스 풀 | 등 · 견갑 안정화 | 어깨 · 후면 어깨/회전근개 |
| 스캐풀라 푸시업 | 어깨 · 회전근개·안정화 | 가슴 워밍업, 견갑 안정화 |
| 월 슬라이드 | 등 · 견갑 안정화 | 어깨 안정화, 프리액티베이션 |
| 푸시 프레스 | 전신·파워 · 올림픽 저크·드라이브 | 어깨 파워 |
| 메디신볼 오버헤드 스로·슬램 | 전신·파워 · 폭발 동작 | 어깨 파워 |
| 메디신볼 체스트 패스 | 전신·파워 · 폭발 동작 | 가슴 파워 |
| 메디신볼 로테이셔널 스로 | 전신·파워 · 폭발 동작 | 코어 회전 파워 |
| 덤벨 스내치 | 전신·파워 · 올림픽 스내치 계열 | 탄도성 전신 동작 |
| 케이블 풀스루 | 하체 · 힙힌지·복합 하체 | 둔근 고관절 신전 |
| 리버스 하이퍼 | 등 · 척추기립근·허리 안정화 | 둔근 고관절 신전 |
| 버드독 | 코어 · 척추 안정화 | 등 허리 안정화 |
| 데드버그·플랭크·사이드 플랭크 | 코어 · 항신전/항측굴 | 척추 안정화 |
| 소렌슨 홀드 | 등 · 척추기립근·허리 안정화 | 코어 척추 안정화·평가 |
| 파머스·수트케이스·오버헤드 캐리 | 코어 · 기능적 동작·캐리 | 전완·그립, 어깨 안정화 |

# 19. 다음 구현 단계

1. 현 DB 운동을 이 명세에 매핑하는 감사표 작성.
2. 한글·영문 중복을 대표 행으로 통합하고 기존 행은 비활성화.
3. 신규 마스터 필드와 표준 분류값을 마이그레이션으로 추가.
4. 각 운동의 회귀·대체·발전 관계를 관계 테이블로 저장.
5. 근력운동 추천과 프리액티베이션 추천이 동일 마스터를 조회하도록 통합.
6. 개발 버전에서 부위별 추천·변경·후보 부족·부상 필터를 검증.
