# 운동 마스터 DB 비교 감사

생성 기준: `EXERCISE_MASTER_ZERO_BASE.md` 및 저장소 마이그레이션 파일

## 요약

| 항목 | 수량 |
|---|---:|
| 새 마스터 원본 행 | 358 |
| 새 마스터 고유 운동 | 342 |
| 기존 마이그레이션 고유 운동 | 116 |
| 영문명 기준 동일 운동 | 65 |
| 새 마스터에만 있는 운동 | 277 |
| 기존 목록에만 있는 운동 | 51 |
| 새 마스터 내 중복·교차 등록 후보 | 15 |
| 기존 목록 내 중복 후보 | 89 |

> 이 감사는 저장소 마이그레이션을 기준으로 합니다. 운영 DB에서 코치가 직접 추가한 운동은 이전 직전 별도 조회하여 보존합니다.

## 이전 원칙

1. 기존 운동은 자동 삭제하지 않는다.
2. 영문명 정규화가 일치하는 운동은 새 한글 대표명과 분류를 연결한다.
3. 새 마스터 운동은 신규 등록 후보로 둔다.
4. 기존에만 있는 운동은 코치 추가 운동과 구형 시스템 운동을 구분한 뒤 유지·연결·비활성화를 결정한다.
5. 중복은 삭제하지 않고 대표 운동으로 연결한 뒤 숨김 처리한다.

## 새로 추가할 운동 후보 (277)

| 한글명 | 영문명 | 영역 | 부위 | 표시 그룹 |
| --- | --- | --- | --- | --- |
| 벽 푸시업 | Wall Push-up | 상체 | 가슴 | 가슴 전체 |
| 인클라인 푸시업 | Incline Push-up | 상체 | 가슴 | 가슴 전체 |
| 니 푸시업 | Knee Push-up | 상체 | 가슴 | 가슴 전체 |
| 뉴트럴그립 덤벨 벤치프레스 | Neutral-Grip Dumbbell Bench Press | 상체 | 가슴 | 가슴 전체 |
| 덤벨 플로어 프레스 | Dumbbell Floor Press | 상체 | 가슴 | 가슴 전체 |
| 싱글암 덤벨 벤치프레스 | Single-Arm Dumbbell Bench Press | 상체 | 가슴 | 가슴 전체 |
| 디피싯 푸시업 | Deficit Push-up | 상체 | 가슴 | 가슴 전체 |
| 서스펜션 푸시업 | Suspension Push-up | 상체 | 가슴 | 가슴 전체 |
| 인클라인 바벨 벤치프레스 | Incline Barbell Bench Press | 상체 | 가슴 | 위가슴 |
| 인클라인 덤벨 벤치프레스 | Incline Dumbbell Bench Press | 상체 | 가슴 | 위가슴 |
| 인클라인 체스트 프레스 | Incline Chest Press | 상체 | 가슴 | 위가슴 |
| 싱글암 인클라인 덤벨 프레스 | Single-Arm Incline Dumbbell Press | 상체 | 가슴 | 위가슴 |
| 로우 인클라인 덤벨 프레스 | Low-Incline Dumbbell Press | 상체 | 가슴 | 위가슴 |
| 로우 투 하이 케이블 프레스 | Low-to-High Cable Press | 상체 | 가슴 | 위가슴 |
| 디클라인 바벨 벤치프레스 | Decline Barbell Bench Press | 상체 | 가슴 | 밑가슴 |
| 디클라인 덤벨 벤치프레스 | Decline Dumbbell Bench Press | 상체 | 가슴 | 밑가슴 |
| 디클라인 체스트 프레스 | Decline Chest Press | 상체 | 가슴 | 밑가슴 |
| 어시스트 체스트 딥 | Assisted Chest Dip | 상체 | 가슴 | 밑가슴 |
| 체스트 딥 | Chest Dip | 상체 | 가슴 | 밑가슴 |
| 하이 투 로우 케이블 프레스 | High-to-Low Cable Press | 상체 | 가슴 | 밑가슴 |
| 밴드 체스트 플라이 | Band Chest Fly | 상체 | 가슴 | 가슴 모으기 |
| 덤벨 플라이 | Dumbbell Fly | 상체 | 가슴 | 가슴 모으기 |
| 케이블 체스트 플라이 | Cable Chest Fly | 상체 | 가슴 | 가슴 모으기 |
| 펙덱 플라이 | Pec Deck Fly | 상체 | 가슴 | 가슴 모으기 |
| 싱글암 케이블 플라이 | Single-Arm Cable Fly | 상체 | 가슴 | 가슴 모으기 |
| 로우 투 하이 케이블 플라이 | Low-to-High Cable Fly | 상체 | 가슴 | 가슴 모으기 |
| 하이 투 로우 케이블 플라이 | High-to-Low Cable Fly | 상체 | 가슴 | 가슴 모으기 |
| 스탠딩 메디신볼 체스트 패스 | Standing Medicine Ball Chest Pass | 상체 | 가슴 | 가슴 파워 |
| 니링 메디신볼 체스트 패스 | Kneeling Medicine Ball Chest Pass | 상체 | 가슴 | 가슴 파워 |
| 하프니링 메디신볼 체스트 패스 | Half-Kneeling Medicine Ball Chest Pass | 상체 | 가슴 | 가슴 파워 |
| 스플릿 스탠스 체스트 패스 | Split-Stance Chest Pass | 상체 | 가슴 | 가슴 파워 |
| 월 체스트 패스 | Repeated Wall Chest Pass | 상체 | 가슴 | 가슴 파워 |
| 플라이오 푸시업 | Plyometric Push-up | 상체 | 가슴 | 가슴 파워 |
| 메디신볼 푸시업 | Medicine Ball Push-up | 상체 | 가슴 | 가슴 파워 |
| 박스 투 박스 플라이오 푸시업 | Box-to-Box Plyometric Push-up | 상체 | 가슴 | 가슴 파워 |
| 스캐풀라 풀업 | Scapular Pull-up | 상체 | 등 | 광배근·수직 당기기 |
| 밴드 스트레이트암 풀다운 | Band Straight-Arm Pulldown | 상체 | 등 | 광배근·수직 당기기 |
| 어시스트 풀업 | Assisted Pull-up | 상체 | 등 | 광배근·수직 당기기 |
| 뉴트럴그립 풀업 | Neutral-Grip Pull-up | 상체 | 등 | 광배근·수직 당기기 |
| 웨이티드 풀업 | Weighted Pull-up | 상체 | 등 | 광배근·수직 당기기 |
| 뉴트럴그립 랫 풀다운 | Neutral-Grip Lat Pulldown | 상체 | 등 | 광배근·수직 당기기 |
| 언더그립 랫 풀다운 | Underhand Lat Pulldown | 상체 | 등 | 광배근·수직 당기기 |
| 싱글암 랫 풀다운 | Single-Arm Lat Pulldown | 상체 | 등 | 광배근·수직 당기기 |
| 스트레이트암 풀다운 | Straight-Arm Pulldown | 상체 | 등 | 광배근·수직 당기기 |
| 밴드 로우 | Band Row | 상체 | 등 | 등 상부·수평 당기기 |
| 서스펜션 로우 | Suspension Row | 상체 | 등 | 등 상부·수평 당기기 |
| 펜들레이 로우 | Pendlay Row | 상체 | 등 | 등 상부·수평 당기기 |
| 덤벨 원암 로우 | One-Arm Dumbbell Row | 상체 | 등 | 등 상부·수평 당기기 |
| 체스트 서포티드 덤벨 로우 | Chest-Supported Dumbbell Row | 상체 | 등 | 등 상부·수평 당기기 |
| 머신 시티드 로우 | Seated Row Machine | 상체 | 등 | 등 상부·수평 당기기 |
| T바 로우 | T-Bar Row | 상체 | 등 | 등 상부·수평 당기기 |
| 랜드마인 원암 로우 | One-Arm Landmine Row | 상체 | 등 | 등 상부·수평 당기기 |
| 씰 로우 | Seal Row | 상체 | 등 | 등 상부·수평 당기기 |
| 하이 로우 머신 | High Row Machine | 상체 | 등 | 등 상부·수평 당기기 |
| 케이블 페이스 풀 | Cable Face Pull | 상체 | 등 | 견갑 안정화 |
| 프론 Y 레이즈 | Prone Y Raise | 상체 | 등 | 견갑 안정화 |
| 프론 T 레이즈 | Prone T Raise | 상체 | 등 | 견갑 안정화 |
| 프론 W 레이즈 | Prone W Raise | 상체 | 등 | 견갑 안정화 |
| Y-T-W 복합 | Y-T-W Complex | 상체 | 등 | 견갑 안정화 |
| 밴드 로우 투 외회전 | Band Row to External Rotation | 상체 | 등 | 견갑 안정화 |
| 케이블 로우 투 외회전 | Cable Row to External Rotation | 상체 | 등 | 견갑 안정화 |
| 프론 코브라 | Prone Cobra | 상체 | 등 | 척추기립근·허리 안정화 |
| 아이소메트릭 백 익스텐션 | Isometric Back Extension | 상체 | 등 | 척추기립근·허리 안정화 |
| 45도 백 익스텐션 | 45-Degree Back Extension | 상체 | 등 | 척추기립근·허리 안정화 |
| 수평 백 익스텐션 | Horizontal Back Extension | 상체 | 등 | 척추기립근·허리 안정화 |
| 리버스 하이퍼 | Reverse Hyperextension | 상체 | 등 | 척추기립근·허리 안정화 |
| 소렌슨 홀드 | Sorensen Hold | 상체 | 등 | 척추기립근·허리 안정화 |
| 월 오버헤드 리치 | Wall Overhead Reach | 상체 | 어깨 | 어깨 프레스 |
| 밴드 오버헤드 프레스 | Band Overhead Press | 상체 | 어깨 | 어깨 프레스 |
| 하프니링 랜드마인 프레스 | Half-Kneeling Landmine Press | 상체 | 어깨 | 어깨 프레스 |
| 스탠딩 랜드마인 프레스 | Standing Landmine Press | 상체 | 어깨 | 어깨 프레스 |
| 머신 숄더 프레스 | Machine Shoulder Press | 상체 | 어깨 | 어깨 프레스 |
| 시티드 덤벨 숄더 프레스 | Seated Dumbbell Shoulder Press | 상체 | 어깨 | 어깨 프레스 |
| 스탠딩 덤벨 숄더 프레스 | Standing Dumbbell Shoulder Press | 상체 | 어깨 | 어깨 프레스 |
| 바벨 오버헤드 프레스 | Barbell Overhead Press | 상체 | 어깨 | 어깨 프레스 |
| 뉴트럴그립 덤벨 프레스 | Neutral-Grip Dumbbell Press | 상체 | 어깨 | 어깨 프레스 |
| 싱글암 덤벨 오버헤드 프레스 | Single-Arm Dumbbell Overhead Press | 상체 | 어깨 | 어깨 프레스 |
| 바텀업 케틀벨 프레스 | Bottoms-Up Kettlebell Press | 상체 | 어깨 | 어깨 프레스 |
| 밴드 레터럴 레이즈 | Band Lateral Raise | 상체 | 어깨 | 측면 어깨 |
| 케이블 레터럴 레이즈 | Cable Lateral Raise | 상체 | 어깨 | 측면 어깨 |
| 싱글암 케이블 레터럴 레이즈 | Single-Arm Cable Lateral Raise | 상체 | 어깨 | 측면 어깨 |
| 머신 레터럴 레이즈 | Machine Lateral Raise | 상체 | 어깨 | 측면 어깨 |
| 린어웨이 레터럴 레이즈 | Lean-Away Lateral Raise | 상체 | 어깨 | 측면 어깨 |
| 라잉 레터럴 레이즈 | Lying Lateral Raise | 상체 | 어깨 | 측면 어깨 |
| 스캐풀라 플레인 레이즈 | Scaption Raise | 상체 | 어깨 | 측면 어깨 |
| 밴드 리버스 플라이 | Band Reverse Fly | 상체 | 어깨 | 후면 어깨 |
| 덤벨 벤트오버 리버스 플라이 | Bent-Over Dumbbell Reverse Fly | 상체 | 어깨 | 후면 어깨 |
| 체스트 서포티드 리버스 플라이 | Chest-Supported Reverse Fly | 상체 | 어깨 | 후면 어깨 |
| 케이블 리버스 플라이 | Cable Reverse Fly | 상체 | 어깨 | 후면 어깨 |
| 싱글암 케이블 리버스 플라이 | Single-Arm Cable Reverse Fly | 상체 | 어깨 | 후면 어깨 |
| 리버스 펙덱 | Reverse Pec Deck | 상체 | 어깨 | 후면 어깨 |
| 리어델트 로우 | Rear-Delt Row | 상체 | 어깨 | 후면 어깨 |
| 밴드 외회전 | Band External Rotation | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 케이블 외회전 | Cable External Rotation | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 사이드라잉 덤벨 외회전 | Side-Lying Dumbbell External Rotation | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 밴드 내회전 | Band Internal Rotation | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 90 | 90 밴드 외회전 / 90/90 Band External Rotation | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 하프니링 90 | 90 케이블 외회전 / Half-Kneeling 90/90 Cable External Rotation | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 폼롤러 월 슬라이드 | Foam-Roller Wall Slide | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 스캐풀라 푸시업 | Scapular Push-up | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 바텀업 케틀벨 캐리 | Bottoms-Up Kettlebell Carry | 상체 | 어깨 | 회전근개·어깨 안정화 |
| 오버헤드 캐리 | Overhead Carry | 코어 | 기능적 동작 | 캐리 |
| 메디신볼 오버헤드 스로 | Medicine Ball Overhead Throw | 전신·파워 | 폭발 동작 | 메디신볼 던지기 |
| 메디신볼 오버헤드 슬램 | Medicine Ball Overhead Slam | 전신·파워 | 폭발 동작 | 메디신볼 던지기 |
| 싱글암 메디신볼 숄더 스로 | Single-Arm Medicine Ball Shoulder Throw | 상체 | 어깨 | 어깨 파워 |
| 랜드마인 푸시 프레스 | Landmine Push Press | 상체 | 어깨 | 어깨 파워 |
| 스플릿 스탠스 랜드마인 프레스 | Split-Stance Landmine Press | 상체 | 어깨 | 어깨 파워 |
| 밴드 바이셉 컬 | Band Biceps Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 덤벨 바이셉 컬 | Dumbbell Biceps Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 바벨 바이셉 컬 | Barbell Biceps Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| EZ바 컬 | EZ-Bar Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 해머 컬 | Hammer Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 인클라인 덤벨 컬 | Incline Dumbbell Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 프리처 컬 | Preacher Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 케이블 컬 | Cable Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 싱글암 케이블 컬 | Single-Arm Cable Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 리버스 컬 | Reverse Curl | 상체 | 팔 | 이두근·팔꿈치 굴곡 |
| 밴드 트라이셉 프레스다운 | Band Triceps Pressdown | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 케이블 트라이셉 프레스다운 | Cable Triceps Pressdown | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 로프 트라이셉 프레스다운 | Rope Triceps Pressdown | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 오버헤드 케이블 트라이셉 익스텐션 | Overhead Cable Triceps Extension | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 덤벨 오버헤드 트라이셉 익스텐션 | Dumbbell Overhead Triceps Extension | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 라잉 트라이셉 익스텐션 | Lying Triceps Extension | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 클로즈그립 벤치프레스 | Close-Grip Bench Press | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 어시스트 벤치 딥 | Assisted Bench Dip | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 벤치 딥 | Bench Dip | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 싱글암 케이블 프레스다운 | Single-Arm Cable Pressdown | 상체 | 팔 | 삼두근·팔꿈치 신전 |
| 손목 굴곡 | Wrist Curl | 상체 | 팔 | 전완·그립 |
| 손목 신전 | Wrist Extension | 상체 | 팔 | 전완·그립 |
| 회내·회외 운동 | Forearm Pronation-Supination | 상체 | 팔 | 전완·그립 |
| 플레이트 핀치 | Plate Pinch | 상체 | 팔 | 전완·그립 |
| 데드행 | Dead Hang | 상체 | 팔 | 전완·그립 |
| 팻그립 홀드 | Fat-Grip Hold | 상체 | 팔 | 전완·그립 |
| 파머스 캐리 | Farmer's Carry | 코어 | 기능적 동작 | 캐리 |
| 타월 행 | Towel Hang | 상체 | 팔 | 전완·그립 |
| 스페니시 스쿼트 아이소메트릭 | Spanish Squat Isometric | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 월 싯 | Wall Sit | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 세이프티바 스쿼트 | Safety-Bar Squat | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 해크 스쿼트 | Hack Squat | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 레그 프레스 | Leg Press | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 레그 익스텐션 | Leg Extension | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 벨트 스쿼트 | Belt Squat | 하체 | 대퇴·무릎 중심 | 대퇴사두근·양측 무릎 우세 |
| 스플릿 스쿼트 아이소메트릭 | Split-Squat Isometric | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 스플릿 스쿼트 | Split Squat | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 포워드 런지 | Forward Lunge | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 워킹 런지 | Walking Lunge | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 스텝다운 | Step-Down | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 싱글레그 스쿼트 투 박스 | Single-Leg Squat to Box | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 피스톨 스쿼트 | Pistol Squat | 하체 | 대퇴·무릎 중심 | 단측 무릎 우세 |
| 애덕터 록백 | Adductor Rock-Back | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 볼 스퀴즈 아이소메트릭 | Ball Squeeze Isometric | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 코펜하겐 플랭크 숏레버 | Short-Lever Copenhagen Plank | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 코펜하겐 플랭크 롱레버 | Long-Lever Copenhagen Plank | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 코사크 스쿼트 | Cossack Squat | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 케이블 힙 어덕션 | Cable Hip Adduction | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 슬라이드보드 레터럴 런지 | Slideboard Lateral Lunge | 하체 | 대퇴·무릎 중심 | 내전근·측면 대퇴 |
| 브릿지 힐 홀드 | Bridge Heel Hold | 하체 | 햄스트링 | 무릎 굴곡 |
| 밴드 레그 컬 | Band Leg Curl | 하체 | 햄스트링 | 무릎 굴곡 |
| 스위스볼 레그 컬 | Swiss-Ball Leg Curl | 하체 | 햄스트링 | 무릎 굴곡 |
| 머신 라잉 레그 컬 | Lying Leg Curl | 하체 | 햄스트링 | 무릎 굴곡 |
| 머신 시티드 레그 컬 | Seated Leg Curl | 하체 | 햄스트링 | 무릎 굴곡 |
| 싱글레그 레그 컬 | Single-Leg Leg Curl | 하체 | 햄스트링 | 무릎 굴곡 |
| 어시스트 노르딕 햄스트링 | Assisted Nordic Hamstring Curl | 하체 | 햄스트링 | 무릎 굴곡 |
| 싱글레그 워크아웃 | Single-Leg Hamstring Walkout | 하체 | 햄스트링 | 햄스트링 길이·편심 제어 |
| 햄스트링 워크아웃 | Hamstring Walkout | 하체 | 햄스트링 | 햄스트링 길이·편심 제어 |
| 플라이휠 레그 컬 | Flywheel Leg Curl | 하체 | 햄스트링 | 햄스트링 길이·편심 제어 |
| 글루트 브리지 | Glute Bridge | 하체 | 둔근·고관절 | 고관절 신전 |
| 싱글레그 글루트 브리지 | Single-Leg Glute Bridge | 하체 | 둔근·고관절 | 고관절 신전 |
| 케이블 힙 익스텐션 | Cable Hip Extension | 하체 | 둔근·고관절 | 고관절 신전 |
| 밴드 힙 어브덕션 | Band Hip Abduction | 하체 | 둔근·고관절 | 고관절 외전·골반 안정화 |
| 사이드라잉 힙 어브덕션 | Side-Lying Hip Abduction | 하체 | 둔근·고관절 | 고관절 외전·골반 안정화 |
| 몬스터 워크 | Monster Walk | 하체 | 둔근·고관절 | 고관절 외전·골반 안정화 |
| 케이블 힙 어브덕션 | Cable Hip Abduction | 하체 | 둔근·고관절 | 고관절 외전·골반 안정화 |
| 머신 힙 어브덕션 | Hip Abduction Machine | 하체 | 둔근·고관절 | 고관절 외전·골반 안정화 |
| 힙 에어플레인 | Hip Airplane | 하체 | 둔근·고관절 | 고관절 외전·골반 안정화 |
| 밴드 마치 | Band-Resisted March | 하체 | 둔근·고관절 | 고관절 굴곡 |
| 월 드릴 아이소메트릭 마치 | Wall-Drill Isometric March | 하체 | 둔근·고관절 | 고관절 굴곡 |
| 케이블 힙 플렉션 | Cable Hip Flexion | 하체 | 둔근·고관절 | 고관절 굴곡 |
| 행잉 니 드라이브 | Hanging Knee Drive | 하체 | 둔근·고관절 | 고관절 굴곡 |
| 양발 카프 레이즈 | Double-Leg Calf Raise | 하체 | 종아리·발목 | 무릎 편 상태 족저굴곡·비복근 |
| 스탠딩 머신 카프 레이즈 | Standing Machine Calf Raise | 하체 | 종아리·발목 | 무릎 편 상태 족저굴곡·비복근 |
| 레그프레스 카프 레이즈 | Leg-Press Calf Raise | 하체 | 종아리·발목 | 무릎 편 상태 족저굴곡·비복근 |
| 아이소메트릭 카프 홀드 | Isometric Calf Hold | 하체 | 종아리·발목 | 무릎 편 상태 족저굴곡·비복근 |
| 벤트니 싱글레그 카프 레이즈 | Bent-Knee Single-Leg Calf Raise | 하체 | 종아리·발목 | 무릎 굽힌 상태 족저굴곡·가자미근 |
| 솔레우스 아이소메트릭 홀드 | Soleus Isometric Hold | 하체 | 종아리·발목 | 무릎 굽힌 상태 족저굴곡·가자미근 |
| 티비얼리스 레이즈 | Tibialis Raise | 하체 | 종아리·발목 | 발목 배측굴곡·발 기능 |
| 밴드 발목 배측굴곡 | Band Ankle Dorsiflexion | 하체 | 종아리·발목 | 발목 배측굴곡·발 기능 |
| 숏풋 | Short-Foot Exercise | 하체 | 종아리·발목 | 발목 배측굴곡·발 기능 |
| 토 요가 | Toe Yoga | 하체 | 종아리·발목 | 발목 배측굴곡·발 기능 |
| 발목 포고 준비 | Ankle Pogo Preparation | 하체 | 종아리·발목 | 발목 배측굴곡·발 기능 |
| 힙힌지 월 드릴 | Hip-Hinge Wall Drill | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 밴드 힙힌지 | Band Hip Hinge | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 케틀벨 데드리프트 | Kettlebell Deadlift | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 컨벤셔널 데드리프트 | Conventional Deadlift | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 스모 데드리프트 | Sumo Deadlift | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 싱글레그 루마니안 데드리프트 | Single-Leg Romanian Deadlift | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 킥스탠드 루마니안 데드리프트 | Kickstand Romanian Deadlift | 하체 | 힙힌지·복합 하체 | 힙힌지·복합 하체 |
| 점프 슈러그 | Jump Shrug | 전신·파워 | 올림픽 리프트 | 학습·회귀 |
| 하이 풀 | High Pull | 전신·파워 | 올림픽 리프트 | 학습·회귀 |
| 행 하이 풀 | Hang High Pull | 전신·파워 | 올림픽 리프트 | 학습·회귀 |
| 스내치 풀 | Snatch Pull | 전신·파워 | 올림픽 리프트 | 학습·회귀 |
| 머슬 클린 | Muscle Clean | 전신·파워 | 올림픽 리프트 | 학습·회귀 |
| 머슬 스내치 | Muscle Snatch | 전신·파워 | 올림픽 리프트 | 학습·회귀 |
| 블록 파워 클린 | Block Power Clean | 전신·파워 | 올림픽 리프트 | 클린 계열 |
| 클린 | Clean | 전신·파워 | 올림픽 리프트 | 클린 계열 |
| 덤벨 행 파워 클린 | Dumbbell Hang Power Clean | 전신·파워 | 올림픽 리프트 | 클린 계열 |
| 파워 스내치 | Power Snatch | 전신·파워 | 올림픽 리프트 | 스내치 계열 |
| 블록 파워 스내치 | Block Power Snatch | 전신·파워 | 올림픽 리프트 | 스내치 계열 |
| 덤벨 스내치 | Dumbbell Snatch | 전신·파워 | 올림픽 리프트 | 스내치 계열 |
| 케틀벨 스내치 | Kettlebell Snatch | 전신·파워 | 올림픽 리프트 | 스내치 계열 |
| 파워 저크 | Power Jerk | 전신·파워 | 올림픽 리프트 | 저크·드라이브 |
| 스플릿 저크 | Split Jerk | 전신·파워 | 올림픽 리프트 | 저크·드라이브 |
| 푸시 저크 | Push Jerk | 전신·파워 | 올림픽 리프트 | 저크·드라이브 |
| 스냅다운 | Snap Down | 전신·파워 | 점프 | 착지·저강도 준비 |
| 스쿼트 랜딩 | Squat Landing | 전신·파워 | 점프 | 착지·저강도 준비 |
| 포고 점프 | Pogo Jump | 전신·파워 | 점프 | 착지·저강도 준비 |
| 라인 홉 | Line Hop | 전신·파워 | 점프 | 착지·저강도 준비 |
| 점프 앤드 스틱 | Jump and Stick | 전신·파워 | 점프 | 착지·저강도 준비 |
| 스쿼트 점프 | Squat Jump | 전신·파워 | 점프 | 수직 점프 |
| 반복 수직 점프 | Repeated Vertical Jump | 전신·파워 | 점프 | 수직 점프 |
| 웨이티드 점프 스쿼트 | Loaded Jump Squat | 전신·파워 | 점프 | 수직 점프 |
| 연속 브로드 점프 | Repeated Broad Jump | 전신·파워 | 점프 | 수평 점프 |
| 싱글레그 브로드 점프 | Single-Leg Broad Jump | 전신·파워 | 점프 | 수평 점프 |
| 바운딩 | Bounding | 전신·파워 | 점프 | 수평 점프 |
| 스케이터 점프 | Skater Jump | 전신·파워 | 점프 | 측면·다방향 점프 |
| 싱글레그 래터럴 홉 | Single-Leg Lateral Hop | 전신·파워 | 점프 | 측면·다방향 점프 |
| 멀티디렉셔널 홉 | Multidirectional Hop | 전신·파워 | 점프 | 측면·다방향 점프 |
| 크로스오버 바운드 | Crossover Bound | 전신·파워 | 점프 | 측면·다방향 점프 |
| 드롭 랜딩 | Drop Landing | 전신·파워 | 점프 | 반응성·드롭 점프 |
| 드롭 점프 | Drop Jump | 전신·파워 | 점프 | 반응성·드롭 점프 |
| 반복 허들 홉 | Repeated Hurdle Hop | 전신·파워 | 점프 | 반응성·드롭 점프 |
| 싱글레그 포고 | Single-Leg Pogo | 전신·파워 | 점프 | 반응성·드롭 점프 |
| 메디신볼 체스트 패스 | Medicine Ball Chest Pass | 전신·파워 | 폭발 동작 | 메디신볼 던지기 |
| 스플릿 스탠스 로테이셔널 스로 | Split-Stance Rotational Throw | 전신·파워 | 폭발 동작 | 메디신볼 던지기 |
| 랜드마인 스러스터 | Landmine Thruster | 전신·파워 | 폭발 동작 | 탄도성 전신 동작 |
| 배틀로프 슬램 | Battle Rope Slam | 전신·파워 | 폭발 동작 | 탄도성 전신 동작 |
| 배틀로프 얼터네이팅 웨이브 | Battle Rope Alternating Wave | 전신·파워 | 폭발 동작 | 탄도성 전신 동작 |
| 헤비 슬레드 푸시 | Heavy Sled Push | 전신·파워 | 폭발 동작 | 썰매·저항 가속 |
| 라이트 슬레드 스프린트 | Light Sled Sprint | 전신·파워 | 폭발 동작 | 썰매·저항 가속 |
| 슬레드 드래그 | Sled Drag | 전신·파워 | 폭발 동작 | 썰매·저항 가속 |
| 백워드 슬레드 드래그 | Backward Sled Drag | 전신·파워 | 폭발 동작 | 썰매·저항 가속 |
| 레지스티드 마치 | Resisted March | 전신·파워 | 폭발 동작 | 썰매·저항 가속 |
| 밴드 데드버그 | Band-Resisted Dead Bug | 코어 | 코어 | 항신전 |
| 플랭크 | Front Plank | 코어 | 코어 | 항신전 |
| 바디쏘 | Body Saw | 코어 | 코어 | 항신전 |
| 스위스볼 롤아웃 | Swiss-Ball Rollout | 코어 | 코어 | 항신전 |
| 팔로프 프레스 아이소메트릭 | Pallof Press Isometric | 코어 | 코어 | 항회전 |
| 팔로프 프레스 워크아웃 | Pallof Press Walkout | 코어 | 코어 | 항회전 |
| 버드독 로우 | Bird-Dog Row | 코어 | 코어 | 항회전 |
| 플랭크 숄더 탭 | Plank Shoulder Tap | 코어 | 코어 | 항회전 |
| 사이드 플랭크 숏레버 | Short-Lever Side Plank | 코어 | 코어 | 항측굴 |
| 스타 사이드 플랭크 | Star Side Plank | 코어 | 코어 | 항측굴 |
| 오프셋 파머스 캐리 | Offset Farmer's Carry | 코어 | 코어 | 항측굴 |
| 케이블 촙 | Cable Chop | 코어 | 코어 | 회전·대각선 힘 전달 |
| 케이블 리프트 | Cable Lift | 코어 | 코어 | 회전·대각선 힘 전달 |
| 하프니링 케이블 촙 | Half-Kneeling Cable Chop | 코어 | 코어 | 회전·대각선 힘 전달 |
| 랜드마인 로테이션 | Landmine Rotation | 코어 | 코어 | 회전·대각선 힘 전달 |
| 브레이싱 호흡 | Bracing Breathing | 코어 | 척추 안정화 | 척추 안정화 |
| 맥길 컬업 | McGill Curl-Up | 코어 | 척추 안정화 | 척추 안정화 |
| 베어 플랭크 | Bear Plank | 코어 | 척추 안정화 | 척추 안정화 |
| 프론트랙 캐리 | Front-Rack Carry | 코어 | 기능적 동작 | 캐리 |
| 웨이터 캐리 | Waiter's Carry | 코어 | 기능적 동작 | 캐리 |
| 베어허그 캐리 | Bear-Hug Carry | 코어 | 기능적 동작 | 캐리 |
| 베어 크롤 | Bear Crawl | 코어 | 기능적 동작 | 크롤·이동 |
| 레터럴 베어 크롤 | Lateral Bear Crawl | 코어 | 기능적 동작 | 크롤·이동 |
| 크랩 워크 | Crab Walk | 코어 | 기능적 동작 | 크롤·이동 |
| 크로스 크롤 | Cross Crawl | 코어 | 기능적 동작 | 크롤·이동 |
| 하프 겟업 | Half Get-Up | 코어 | 기능적 동작 | 겟업·전신 연결 |
| 터키시 겟업 | Turkish Get-Up | 코어 | 기능적 동작 | 겟업·전신 연결 |
| 톨니링 투 스탠드 | Tall-Kneeling to Stand | 코어 | 기능적 동작 | 겟업·전신 연결 |
| 하프니링 리프트 | Half-Kneeling Lift | 코어 | 기능적 동작 | 겟업·전신 연결 |
| 샌드백 숄더링 | Sandbag Shouldering | 코어 | 기능적 동작 | 겟업·전신 연결 |
| 월 드릴 마치 | Wall-Drill March | 코어 | 기능적 동작 | 축구 준비 통합 동작 |
| A마치 저항 운동 | Resisted A-March | 코어 | 기능적 동작 | 축구 준비 통합 동작 |
| 스플릿 스탠스 케이블 프레스 | Split-Stance Cable Press | 코어 | 기능적 동작 | 축구 준비 통합 동작 |
| 스플릿 스탠스 케이블 로우 | Split-Stance Cable Row | 코어 | 기능적 동작 | 축구 준비 통합 동작 |
| 싱글레그 RDL 투 니드라이브 | Single-Leg RDL to Knee Drive | 코어 | 기능적 동작 | 축구 준비 통합 동작 |

## 기존 목록에만 있는 운동 (51)

| 기존 한글/표시명 | 기존 영문명 | 출처 |
| --- | --- | --- |
| 벤치 프레스 | Bench Press | 001_gym_tables.sql |
| 인클라인 벤치 프레스 | Incline Bench Press | 001_gym_tables.sql |
| 바벨 로우 | Barbell Row | 001_gym_tables.sql |
| 덤벨 로우 | DB Row | 001_gym_tables.sql |
| 페이스 풀 | Face Pull | 001_gym_tables.sql |
| 오버헤드 프레스 | Overhead Press | 001_gym_tables.sql |
| 견갑 활성화 | Scapular Activation | 001_gym_tables.sql |
| 백 스쿼트 | Back Squat | 001_gym_tables.sql |
| 싱글 레그 스쿼트 | Single-leg Squat | 001_gym_tables.sql |
| 레그 컬 | Leg Curl | 001_gym_tables.sql |
| 카프 레이즈 | Calf Raise | 001_gym_tables.sql |
| 플랭크 | Plank | 001_gym_tables.sql |
| 케이블 우드촙 | Cable Woodchop | 001_gym_tables.sql |
| 크런치 | Crunch | 001_gym_tables.sql |
| 행 클린 | Hang Clean | 001_gym_tables.sql |
| 배틀로프 | Battle Rope | 001_gym_tables.sql |
| 힙 서클 | Hip Circle | 001_gym_tables.sql |
| 발목 모빌리티 | Ankle Mobility | 001_gym_tables.sql |
| Incline DB Press | Incline DB Press | 025_exercise_pool_unification.sql |
| Med Ball Explosive Push-up | Med Ball Explosive Push-up | 025_exercise_pool_unification.sql |
| DB Single-arm Row | DB Single-arm Row | 025_exercise_pool_unification.sql |
| Landmine Row | Landmine Row | 025_exercise_pool_unification.sql |
| DB Seal Row | DB Seal Row | 025_exercise_pool_unification.sql |
| DB Shoulder Press | DB Shoulder Press | 025_exercise_pool_unification.sql |
| KB Bottoms-up Press | KB Bottoms-up Press | 025_exercise_pool_unification.sql |
| Barbell Hip Thrust | Barbell Hip Thrust | 025_exercise_pool_unification.sql |
| Band Hip Extension | Band Hip Extension | 025_exercise_pool_unification.sql |
| Barbell Romanian Deadlift | Barbell Romanian Deadlift | 025_exercise_pool_unification.sql |
| Single-leg RDL | Single-leg RDL | 025_exercise_pool_unification.sql |
| DB Leg Curl (Prone) | DB Leg Curl (Prone) | 025_exercise_pool_unification.sql |
| Landmine Squat | Landmine Squat | 025_exercise_pool_unification.sql |
| Standing Calf Raise | Standing Calf Raise | 025_exercise_pool_unification.sql |
| Eccentric Calf Raise | Eccentric Calf Raise | 025_exercise_pool_unification.sql |
| DB Hang Clean | DB Hang Clean | 025_exercise_pool_unification.sql |
| Barbell Squat + Jump | Barbell Squat + Jump | 025_exercise_pool_unification.sql |
| Trap Bar Jump Squat | Trap Bar Jump Squat | 025_exercise_pool_unification.sql |
| Landmine Clean to Press | Landmine Clean to Press | 025_exercise_pool_unification.sql |
| Deadlift + Broad Jump | Deadlift + Broad Jump | 025_exercise_pool_unification.sql |
| KB Goblet Squat + Press | KB Goblet Squat + Press | 025_exercise_pool_unification.sql |
| Med Ball Slam | Med Ball Slam | 025_exercise_pool_unification.sql |
| Stability Ball Rollout | Stability Ball Rollout | 025_exercise_pool_unification.sql |
| Hollow Body Hold | Hollow Body Hold | 025_exercise_pool_unification.sql |
| Band Anti-Extension Press | Band Anti-Extension Press | 025_exercise_pool_unification.sql |
| Single-arm Farmer Carry | Single-arm Farmer Carry | 025_exercise_pool_unification.sql |
| Copenhagen Plank | Copenhagen Plank | 025_exercise_pool_unification.sql |
| Tall Kneeling Chop | Tall Kneeling Chop | 025_exercise_pool_unification.sql |
| Side Plank + Hip Abduction | Side Plank + Hip Abduction | 025_exercise_pool_unification.sql |
| Single-leg RDL Anti-Lat | Single-leg RDL Anti-Lat | 025_exercise_pool_unification.sql |
| Band Woodchop | Band Woodchop | 025_exercise_pool_unification.sql |
| Side Med Ball Slam | Side Med Ball Slam | 025_exercise_pool_unification.sql |
| Cable Band Lift | Cable Band Lift | 025_exercise_pool_unification.sql |

## 새 마스터 중복·교차 등록 후보 (15)

| 정규화 이름 | 등록 위치 |
| --- | --- |
| Bird Dog | 등 > 척추기립근·허리 안정화 / 척추 안정화 > 척추 안정화 |
| Reverse Hyperextension | 등 > 척추기립근·허리 안정화 / 둔근·고관절 > 고관절 신전 |
| Sorensen Hold | 등 > 척추기립근·허리 안정화 / 척추 안정화 > 척추 안정화 |
| Overhead Carry | 어깨 > 회전근개·어깨 안정화 / 기능적 동작 > 캐리 |
| Medicine Ball Overhead Throw | 어깨 > 어깨 파워 / 폭발 동작 > 메디신볼 던지기 |
| Medicine Ball Overhead Slam | 어깨 > 어깨 파워 / 폭발 동작 > 메디신볼 던지기 |
| Push Press | 어깨 > 어깨 파워 / 올림픽 리프트 > 저크·드라이브 |
| Farmer's Carry | 팔 > 전완·그립 / 기능적 동작 > 캐리 |
| Suitcase Carry | 팔 > 전완·그립 / 코어 > 항측굴 / 기능적 동작 > 캐리 |
| Cable Pull-Through | 둔근·고관절 > 고관절 신전 / 힙힌지·복합 하체 > 힙힌지·복합 하체 |
| Dumbbell Snatch | 올림픽 리프트 > 스내치 계열 / 폭발 동작 > 탄도성 전신 동작 |
| Medicine Ball Rotational Throw | 폭발 동작 > 메디신볼 던지기 / 코어 > 회전·대각선 힘 전달 |
| Dead Bug | 코어 > 항신전 / 척추 안정화 > 척추 안정화 |
| Front Plank | 코어 > 항신전 / 척추 안정화 > 척추 안정화 |
| Side Plank | 코어 > 항측굴 / 척추 안정화 > 척추 안정화 |

## 기존 목록 중복 후보 (89)

| 정규화 이름 | 기존 표기 |
| --- | --- |
| DB Bench Press | 덤벨 벤치 프레스 (001_gym_tables.sql) / DB Bench Press (025_exercise_pool_unification.sql) / DB Bench Press (025_exercise_pool_unification.sql) |
| Push-up | 푸시업 (001_gym_tables.sql) / Push-up (025_exercise_pool_unification.sql) / Push-up (025_exercise_pool_unification.sql) |
| Pull-up | 풀업 (001_gym_tables.sql) / Pull-up (025_exercise_pool_unification.sql) / Pull-up (025_exercise_pool_unification.sql) |
| Overhead Press | 오버헤드 프레스 (001_gym_tables.sql) / Overhead Press (025_exercise_pool_unification.sql) / Overhead Press (025_exercise_pool_unification.sql) |
| Front Squat | 프론트 스쿼트 (001_gym_tables.sql) / Front Squat (025_exercise_pool_unification.sql) / Front Squat (025_exercise_pool_unification.sql) |
| Bulgarian Split Squat | 불가리안 스플릿 스쿼트 (001_gym_tables.sql) / Bulgarian Split Squat (025_exercise_pool_unification.sql) / Bulgarian Split Squat (025_exercise_pool_unification.sql) |
| Plank | 플랭크 (001_gym_tables.sql) / Plank (025_exercise_pool_unification.sql) / Plank (025_exercise_pool_unification.sql) |
| Dead Bug | 데드버그 (001_gym_tables.sql) / Dead Bug (025_exercise_pool_unification.sql) / Dead Bug (025_exercise_pool_unification.sql) |
| Pallof Press | 팔로프 프레스 (001_gym_tables.sql) / Pallof Press (025_exercise_pool_unification.sql) / Pallof Press (025_exercise_pool_unification.sql) |
| Kettlebell Swing | 케틀벨 스윙 (001_gym_tables.sql) / KB Swing (025_exercise_pool_unification.sql) / KB Swing (025_exercise_pool_unification.sql) |
| Box Jump | 박스 점프 (001_gym_tables.sql) / Box Jump (025_exercise_pool_unification.sql) / Box Jump (025_exercise_pool_unification.sql) |
| Broad Jump | 브로드 점프 (001_gym_tables.sql) / Broad Jump (025_exercise_pool_unification.sql) / Broad Jump (025_exercise_pool_unification.sql) |
| Lateral Bound | 래터럴 바운드 (001_gym_tables.sql) / Lateral Bound (025_exercise_pool_unification.sql) / Lateral Bound (025_exercise_pool_unification.sql) |
| Barbell Bench Press | Barbell Bench Press (025_exercise_pool_unification.sql) / Barbell Bench Press (025_exercise_pool_unification.sql) |
| Incline DB Press | Incline DB Press (025_exercise_pool_unification.sql) / Incline DB Press (025_exercise_pool_unification.sql) |
| Weighted Push-up | Weighted Push-up (025_exercise_pool_unification.sql) / Weighted Push-up (025_exercise_pool_unification.sql) |
| Med Ball Explosive Push-up | Med Ball Explosive Push-up (025_exercise_pool_unification.sql) / Med Ball Explosive Push-up (025_exercise_pool_unification.sql) |
| Landmine Press | Landmine Press (025_exercise_pool_unification.sql) / Landmine Press (025_exercise_pool_unification.sql) / Landmine Press (025_exercise_pool_unification.sql) / Landmine Press (025_exercise_pool_unification.sql) |
| Barbell Bent-over Row | Barbell Bent-over Row (025_exercise_pool_unification.sql) / Barbell Bent-over Row (025_exercise_pool_unification.sql) |
| DB Single-arm Row | DB Single-arm Row (025_exercise_pool_unification.sql) / DB Single-arm Row (025_exercise_pool_unification.sql) |
| Chin-up | Chin-up (025_exercise_pool_unification.sql) / Chin-up (025_exercise_pool_unification.sql) |
| Inverted Row | Inverted Row (025_exercise_pool_unification.sql) / Inverted Row (025_exercise_pool_unification.sql) |
| Landmine Row | Landmine Row (025_exercise_pool_unification.sql) / Landmine Row (025_exercise_pool_unification.sql) |
| Band Pull-apart | Band Pull-apart (025_exercise_pool_unification.sql) / Band Pull-apart (025_exercise_pool_unification.sql) |
| DB Seal Row | DB Seal Row (025_exercise_pool_unification.sql) / DB Seal Row (025_exercise_pool_unification.sql) |
| DB Shoulder Press | DB Shoulder Press (025_exercise_pool_unification.sql) / DB Shoulder Press (025_exercise_pool_unification.sql) |
| DB Lateral Raise | DB Lateral Raise (025_exercise_pool_unification.sql) / DB Lateral Raise (025_exercise_pool_unification.sql) |
| Band Face Pull | Band Face Pull (025_exercise_pool_unification.sql) / Band Face Pull (025_exercise_pool_unification.sql) |
| KB Bottoms-up Press | KB Bottoms-up Press (025_exercise_pool_unification.sql) / KB Bottoms-up Press (025_exercise_pool_unification.sql) |
| Arnold Press | Arnold Press (025_exercise_pool_unification.sql) / Arnold Press (025_exercise_pool_unification.sql) |
| Barbell Hip Thrust | Barbell Hip Thrust (025_exercise_pool_unification.sql) / Barbell Hip Thrust (025_exercise_pool_unification.sql) |
| Single-leg Hip Thrust | Single-leg Hip Thrust (025_exercise_pool_unification.sql) / Single-leg Hip Thrust (025_exercise_pool_unification.sql) |
| Barbell Glute Bridge | Barbell Glute Bridge (025_exercise_pool_unification.sql) / Barbell Glute Bridge (025_exercise_pool_unification.sql) |
| Band Hip Extension | Band Hip Extension (025_exercise_pool_unification.sql) / Band Hip Extension (025_exercise_pool_unification.sql) |
| DB Romanian Deadlift | DB Romanian Deadlift (025_exercise_pool_unification.sql) / DB Romanian Deadlift (025_exercise_pool_unification.sql) |
| Cable Pull-through | Cable Pull-through (025_exercise_pool_unification.sql) / Cable Pull-through (025_exercise_pool_unification.sql) |
| Nordic Hamstring Curl | Nordic Hamstring Curl (025_exercise_pool_unification.sql) / Nordic Hamstring Curl (025_exercise_pool_unification.sql) |
| Barbell Romanian Deadlift | Barbell Romanian Deadlift (025_exercise_pool_unification.sql) / Barbell Romanian Deadlift (025_exercise_pool_unification.sql) |
| Single-leg RDL | Single-leg RDL (025_exercise_pool_unification.sql) / Single-leg RDL (025_exercise_pool_unification.sql) |
| Glute-Ham Raise | Glute-Ham Raise (025_exercise_pool_unification.sql) / Glute-Ham Raise (025_exercise_pool_unification.sql) |
| Slider Leg Curl | Slider Leg Curl (025_exercise_pool_unification.sql) / Slider Leg Curl (025_exercise_pool_unification.sql) |
| Good Morning | Good Morning (025_exercise_pool_unification.sql) / Good Morning (025_exercise_pool_unification.sql) |
| DB Leg Curl (Prone) | DB Leg Curl (Prone) (025_exercise_pool_unification.sql) / DB Leg Curl (Prone) (025_exercise_pool_unification.sql) |
| Barbell Back Squat | Barbell Back Squat (025_exercise_pool_unification.sql) / Barbell Back Squat (025_exercise_pool_unification.sql) |
| Trap Bar Deadlift | Trap Bar Deadlift (025_exercise_pool_unification.sql) / Trap Bar Deadlift (025_exercise_pool_unification.sql) |
| Goblet Squat | Goblet Squat (025_exercise_pool_unification.sql) / Goblet Squat (025_exercise_pool_unification.sql) |
| Reverse Lunge | Reverse Lunge (025_exercise_pool_unification.sql) / Reverse Lunge (025_exercise_pool_unification.sql) |
| Step-up | Step-up (025_exercise_pool_unification.sql) / Step-up (025_exercise_pool_unification.sql) |
| Landmine Squat | Landmine Squat (025_exercise_pool_unification.sql) / Landmine Squat (025_exercise_pool_unification.sql) |
| Lateral Lunge | Lateral Lunge (025_exercise_pool_unification.sql) / Lateral Lunge (025_exercise_pool_unification.sql) |
| Standing Calf Raise | Standing Calf Raise (025_exercise_pool_unification.sql) / Standing Calf Raise (025_exercise_pool_unification.sql) |
| Single-leg Calf Raise | Single-leg Calf Raise (025_exercise_pool_unification.sql) / Single-leg Calf Raise (025_exercise_pool_unification.sql) |
| Seated Calf Raise | Seated Calf Raise (025_exercise_pool_unification.sql) / Seated Calf Raise (025_exercise_pool_unification.sql) |
| Eccentric Calf Raise | Eccentric Calf Raise (025_exercise_pool_unification.sql) / Eccentric Calf Raise (025_exercise_pool_unification.sql) |
| Hang Power Clean | Hang Power Clean (025_exercise_pool_unification.sql) / Hang Power Clean (025_exercise_pool_unification.sql) |
| Hang Power Snatch | Hang Power Snatch (025_exercise_pool_unification.sql) / Hang Power Snatch (025_exercise_pool_unification.sql) |
| Clean Pull | Clean Pull (025_exercise_pool_unification.sql) / Clean Pull (025_exercise_pool_unification.sql) |
| KB Clean | KB Clean (025_exercise_pool_unification.sql) / KB Clean (025_exercise_pool_unification.sql) |
| DB Hang Clean | DB Hang Clean (025_exercise_pool_unification.sql) / DB Hang Clean (025_exercise_pool_unification.sql) |
| Barbell Squat + Jump | Barbell Squat + Jump (025_exercise_pool_unification.sql) / Barbell Squat + Jump (025_exercise_pool_unification.sql) |
| Trap Bar Jump Squat | Trap Bar Jump Squat (025_exercise_pool_unification.sql) / Trap Bar Jump Squat (025_exercise_pool_unification.sql) |
| Landmine Clean to Press | Landmine Clean to Press (025_exercise_pool_unification.sql) / Landmine Clean to Press (025_exercise_pool_unification.sql) |
| DB Thruster | DB Thruster (025_exercise_pool_unification.sql) / DB Thruster (025_exercise_pool_unification.sql) |
| Deadlift + Broad Jump | Deadlift + Broad Jump (025_exercise_pool_unification.sql) / Deadlift + Broad Jump (025_exercise_pool_unification.sql) |
| KB Goblet Squat + Press | KB Goblet Squat + Press (025_exercise_pool_unification.sql) / KB Goblet Squat + Press (025_exercise_pool_unification.sql) |
| Depth Jump | Depth Jump (025_exercise_pool_unification.sql) / Depth Jump (025_exercise_pool_unification.sql) |
| Med Ball Slam | Med Ball Slam (025_exercise_pool_unification.sql) / Med Ball Slam (025_exercise_pool_unification.sql) |
| Hurdle Jump | Hurdle Jump (025_exercise_pool_unification.sql) / Hurdle Jump (025_exercise_pool_unification.sql) |
| Ab Wheel Rollout | Ab Wheel Rollout (025_exercise_pool_unification.sql) / Ab Wheel Rollout (025_exercise_pool_unification.sql) |
| Stability Ball Rollout | Stability Ball Rollout (025_exercise_pool_unification.sql) / Stability Ball Rollout (025_exercise_pool_unification.sql) |
| Long Lever Plank | Long Lever Plank (025_exercise_pool_unification.sql) / Long Lever Plank (025_exercise_pool_unification.sql) |
| Hollow Body Hold | Hollow Body Hold (025_exercise_pool_unification.sql) / Hollow Body Hold (025_exercise_pool_unification.sql) |
| Band Anti-Extension Press | Band Anti-Extension Press (025_exercise_pool_unification.sql) / Band Anti-Extension Press (025_exercise_pool_unification.sql) |
| Single-arm Farmer Carry | Single-arm Farmer Carry (025_exercise_pool_unification.sql) / Single-arm Farmer Carry (025_exercise_pool_unification.sql) |
| Copenhagen Plank | Copenhagen Plank (025_exercise_pool_unification.sql) / Copenhagen Plank (025_exercise_pool_unification.sql) |
| Bird Dog | Bird Dog (025_exercise_pool_unification.sql) / Bird Dog (025_exercise_pool_unification.sql) |
| Half-kneeling Pallof Press | Half-kneeling Pallof Press (025_exercise_pool_unification.sql) / Half-kneeling Pallof Press (025_exercise_pool_unification.sql) |
| Tall Kneeling Chop | Tall Kneeling Chop (025_exercise_pool_unification.sql) / Tall Kneeling Chop (025_exercise_pool_unification.sql) |
| Side Plank | Side Plank (025_exercise_pool_unification.sql) / Side Plank (025_exercise_pool_unification.sql) |
| Side Plank + Hip Abduction | Side Plank + Hip Abduction (025_exercise_pool_unification.sql) / Side Plank + Hip Abduction (025_exercise_pool_unification.sql) |
| Suitcase Carry | Suitcase Carry (025_exercise_pool_unification.sql) / Suitcase Carry (025_exercise_pool_unification.sql) |
| Lateral Band Walk | Lateral Band Walk (025_exercise_pool_unification.sql) / Lateral Band Walk (025_exercise_pool_unification.sql) |
| Single-leg RDL Anti-Lat | Single-leg RDL Anti-Lat (025_exercise_pool_unification.sql) / Single-leg RDL Anti-Lat (025_exercise_pool_unification.sql) |
| Med Ball Rotational Throw | Med Ball Rotational Throw (025_exercise_pool_unification.sql) / Med Ball Rotational Throw (025_exercise_pool_unification.sql) |
| Med Ball Scoop Toss | Med Ball Scoop Toss (025_exercise_pool_unification.sql) / Med Ball Scoop Toss (025_exercise_pool_unification.sql) |
| Band Woodchop | Band Woodchop (025_exercise_pool_unification.sql) / Band Woodchop (025_exercise_pool_unification.sql) |
| Side Med Ball Slam | Side Med Ball Slam (025_exercise_pool_unification.sql) / Side Med Ball Slam (025_exercise_pool_unification.sql) |
| Russian Twist | Russian Twist (025_exercise_pool_unification.sql) / Russian Twist (025_exercise_pool_unification.sql) |
| Cable Band Lift | Cable Band Lift (025_exercise_pool_unification.sql) / Cable Band Lift (025_exercise_pool_unification.sql) |
