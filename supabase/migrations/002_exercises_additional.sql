-- ============================================================
-- GYM_POOL 고유 운동 추가 (Supabase 중복 제외)
-- ============================================================

insert into exercises (name_ko, name_en, category, body_part, sub_area, purposes, primary_muscle_ko, primary_muscle_en, antagonist_ko, antagonist_en, equipment_priority, difficulty, coaching_cue) values

-- 상체 / 등 (추가)
('친업', 'Chin-up', '일반', '상체', '등', ARRAY['근력','근비대'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['풀업바'], '중급', '역수 파지, 이두 보조 활용, 완전 신전부터 완전 굴곡'),
('인버티드 로우', 'Inverted Row', '일반', '상체', '등', ARRAY['근력','근비대','근지구력'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['맨몸'], '초급', '몸 전체 일직선, 견갑골 내전 완료까지 당기기, 난이도는 발 위치로 조절'),
('덤벨 씰 로우', 'DB Seal Row', '일반', '상체', '등', ARRAY['근력','근비대'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['덤벨'], '초급', '벤치에 엎드려 지지, 순수 상배 수축, 반동 제거'),

-- 상체 / 어깨 (추가)
('덤벨 숄더 프레스', 'DB Shoulder Press', '일반', '상체', '어깨', ARRAY['근력','근비대'], '삼각근', 'Deltoid', '광배근', 'Latissimus Dorsi', ARRAY['덤벨'], '초급', '중립 파지 선택 가능, 어깨 친화적 동작, 코어 긴장 유지'),
('덤벨 레터럴 레이즈', 'DB Lateral Raise', '일반', '상체', '어깨', ARRAY['근비대','근지구력'], '삼각근', 'Deltoid', '광배근', 'Latissimus Dorsi', ARRAY['덤벨'], '초급', '약간 전경사, 엄지 아래, 승모근 배제, 팔꿈치 살짝 굽힘'),
('랜드마인 프레스', 'Landmine Press', '일반', '상체', '어깨', ARRAY['근력','근비대'], '삼각근', 'Deltoid', '광배근', 'Latissimus Dorsi', ARRAY['바벨'], '초급', '견갑-흉부 리듬 유지, 단측 변형으로 불균형 교정 가능'),

-- 하체 / 햄스트링 (추가 — 축구 부상 예방 핵심)
('노르딕 햄스트링 컬', 'Nordic Hamstring Curl', '일반', '하체', '햄스트링', ARRAY['근력','근비대'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['맨몸'], '고급', '편심 수축 집중, 천천히 내려가기, 햄스트링 부상 예방 핵심 종목'),
('싱글 레그 RDL', 'Single-leg RDL', '일반', '하체', '햄스트링', ARRAY['근력','근비대'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['덤벨','맨몸'], '중급', '단다리 균형, 골반 수평 유지, T자 형태 유지'),
('글루트 햄 레이즈', 'Glute-Ham Raise', '일반', '하체', '햄스트링', ARRAY['근력','근비대'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['맨몸'], '고급', '완전 ROM, 무릎 신전까지, 햄스트링 편심 강화'),
('굿모닝', 'Good Morning', '일반', '하체', '햄스트링', ARRAY['근력','근비대'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['바벨'], '중급', '힙 힌지 강화, 척추 신전근 동반, 등 중립 필수'),
('슬라이더 레그 컬', 'Slider Leg Curl', '일반', '하체', '햄스트링', ARRAY['근비대','근지구력'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['맨몸'], '중급', '브릿지 자세에서 발뒤꿈치로 당기기, 골반 수평 유지'),

-- 하체 / 둔근 (추가)
('싱글 레그 힙 쓰러스트', 'Single-leg Hip Thrust', '일반', '하체', '둔근', ARRAY['근력','근비대'], '대둔근', 'Gluteus Maximus', '대퇴사두근', 'Quadriceps', ARRAY['맨몸'], '중급', '골반 안정화, 동측 햄스트링 개입 최소화, 완전 신전'),

-- 하체 / 대퇴사두 (추가)
('고블릿 스쿼트', 'Goblet Squat', '일반', '하체', '대퇴사두', ARRAY['근비대','근지구력'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['케틀벨','덤벨'], '초급', '팔꿈치로 무릎 외전, 깊은 스쿼트 패턴, 스쿼트 교육에 최적'),
('리버스 런지', 'Reverse Lunge', '일반', '하체', '대퇴사두', ARRAY['근력','근비대'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['덤벨','맨몸'], '초급', '전방 정강이 수직, 무릎 추적, 단측 부하 균형 훈련'),
('스텝업', 'Step-up', '일반', '하체', '대퇴사두', ARRAY['근력','근지구력'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['덤벨','맨몸'], '초급', '전방 발로 완전히 밀기, 보조 발 최소화, 단측 강화'),
('래터럴 런지', 'Lateral Lunge', '일반', '하체', '대퇴사두', ARRAY['근력','근비대'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['덤벨','맨몸'], '초급', '측면 부하, 내전근+쿼드 동시 자극, 지지발 완전 신전'),
('트랩바 데드리프트', 'Trap Bar Deadlift', '일반', '하체', '대퇴사두', ARRAY['근력','파워'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['트랩바'], '중급', '중립 파지, 고관절-슬관절 동시 신전, 척추 친화적'),

-- 코어 (추가)
('사이드 플랭크', 'Side Plank', '일반', '코어', '항측굴', ARRAY['근지구력','활성화'], '복사근', 'Obliques', null, null, ARRAY['맨몸'], '초급', '몸통 측면 일직선, 엉덩이 처짐 방지, 발 쌓거나 앞뒤 배치'),
('행잉 레그 레이즈', 'Hanging Leg Raise', '일반', '코어', '굴곡', ARRAY['근비대','근지구력'], '복직근', 'Rectus Abdominis', null, null, ARRAY['풀업바'], '중급', '골반 후방경사로 복직근 수축, 스윙 최소화, 하강 시 천천히'),
('RKC 플랭크', 'RKC Plank', '일반', '코어', '항신전', ARRAY['근지구력','활성화'], '복횡근', 'Transversus Abdominis', null, null, ARRAY['맨몸'], '중급', '팔꿈치 모아 바닥 긁기 + 발끝 당기기, 최대 긴장 등척성'),

-- 특수_파워 (추가)
('행 파워 스내치', 'Hang Power Snatch', '특수_파워', '전신', '전신', ARRAY['파워'], '대퇴사두근', 'Quadriceps', null, null, ARRAY['바벨'], '고급', '와이드 파지, 오버헤드 직선 경로, 트리플 익스텐션 폭발'),
('클린 풀', 'Clean Pull', '특수_파워', '전신', '전신', ARRAY['파워'], '대퇴사두근', 'Quadriceps', null, null, ARRAY['바벨'], '중급', '바 경로 신체 가까이, 발꿈치 들기, 트리플 익스텐션만'),
('덤벨 스내치', 'DB Snatch', '특수_파워', '전신', '전신', ARRAY['파워'], '대둔근', 'Gluteus Maximus', null, null, ARRAY['덤벨'], '중급', '한 손 파지, 오버헤드 직선 경로, 고관절 폭발');
