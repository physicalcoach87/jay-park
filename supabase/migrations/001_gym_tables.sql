-- ============================================================
-- GYM 세션 자동화 시스템 — Phase 1 테이블 생성
-- Supabase SQL Editor에서 실행
-- ============================================================

-- ① 내 체육관 세팅
create table if not exists gym_settings (
  id          uuid primary key default gen_random_uuid(),
  coach_id    text not null,
  name        text not null,
  equipment   jsonb not null default '[]',  -- [{ "name": "바벨", "quantity": 2 }]
  is_default  boolean default false,
  created_at  timestamptz default now()
);

-- ② 운동 종목 풀
create table if not exists exercises (
  id                   uuid primary key default gen_random_uuid(),
  name_ko              text not null,
  name_en              text not null,
  category             text not null check (category in ('일반','특수_파워','특수_점프','특수_활성화')),
  body_part            text not null check (body_part in ('상체','하체','코어','전신')),
  sub_area             text,
  purposes             text[] not null default '{}',
  primary_muscle_ko    text not null,
  primary_muscle_en    text not null,
  synergist_ko         text,
  synergist_en         text,
  antagonist_ko        text,
  antagonist_en        text,
  equipment_priority   text[] not null default '{}',
  difficulty           text not null check (difficulty in ('초급','중급','고급')),
  coaching_cue         text,
  is_custom            boolean default false,
  coach_id             text,
  created_at           timestamptz default now()
);

-- ③ 생성된 세션 이력
create table if not exists gym_sessions (
  id                uuid primary key default gen_random_uuid(),
  coach_id          text not null,
  session_type      text not null check (session_type in ('단체','개인')),
  input_params      jsonb not null,
  generated_session jsonb not null,
  sent_to_players   text[] default '{}',
  created_at        timestamptz default now()
);

-- ============================================================
-- 기본 운동 종목 시드 데이터 (상체 — 기존 코드 기반)
-- ============================================================

insert into exercises (name_ko, name_en, category, body_part, sub_area, purposes, primary_muscle_ko, primary_muscle_en, antagonist_ko, antagonist_en, equipment_priority, difficulty, coaching_cue) values

-- 상체 가슴
('벤치 프레스', 'Bench Press', '일반', '상체', '가슴', ARRAY['근력','근비대'], '대흉근', 'Pectoralis Major', '광배근', 'Latissimus Dorsi', ARRAY['바벨','덤벨','머신'], '중급', '견갑 후인 고정 후 폭발적 push, 팔꿈치 45~75도 유지'),
('덤벨 벤치 프레스', 'DB Bench Press', '일반', '상체', '가슴', ARRAY['근력','근비대'], '대흉근', 'Pectoralis Major', '광배근', 'Latissimus Dorsi', ARRAY['덤벨'], '중급', '가동범위 더 깊게, 좌우 불균형 교정'),
('인클라인 벤치 프레스', 'Incline Bench Press', '일반', '상체', '가슴', ARRAY['근력','근비대'], '상부 대흉근', 'Upper Pectoralis Major', '광배근', 'Latissimus Dorsi', ARRAY['바벨','덤벨'], '중급', '45도 경사, 어깨 안정화 유지'),
('푸시업', 'Push-up', '일반', '상체', '가슴', ARRAY['근지구력','활성화'], '대흉근', 'Pectoralis Major', '광배근', 'Latissimus Dorsi', ARRAY['맨몸'], '초급', '몸통 일직선 유지, 견갑골 안정화'),

-- 상체 등
('바벨 로우', 'Barbell Row', '일반', '상체', '등', ARRAY['근력','근비대'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['바벨'], '중급', '엉덩이 힌지, 팔꿈치 몸통 근접'),
('덤벨 로우', 'DB Row', '일반', '상체', '등', ARRAY['근력','근비대'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['덤벨'], '초급', '각측, 견갑골 완전 후인'),
('시티드 로우', 'Seated Cable Row', '일반', '상체', '등', ARRAY['근력','근비대','근지구력'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['케이블','머신'], '초급', '팔꿈치 몸통 근접, 견갑 완전 후인'),
('페이스 풀', 'Face Pull', '일반', '상체', '등', ARRAY['근지구력','활성화'], '후면 삼각근', 'Posterior Deltoid', '전면 삼각근', 'Anterior Deltoid', ARRAY['케이블','밴드'], '초급', '외회전 강조, 어깨 균형 교정'),
('풀업', 'Pull-up', '일반', '상체', '등', ARRAY['근력','근비대'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['풀업바'], '중급', '완전 신전 → 완전 굴곡, 체중 컨트롤'),
('랫 풀다운', 'Lat Pulldown', '일반', '상체', '등', ARRAY['근력','근비대'], '광배근', 'Latissimus Dorsi', '대흉근', 'Pectoralis Major', ARRAY['케이블','머신'], '초급', '가슴 향해 당기기, 견갑 후하방 회전'),

-- 상체 어깨
('푸시 프레스', 'Push Press', '일반', '상체', '어깨', ARRAY['파워','근력'], '삼각근', 'Deltoid', '광배근', 'Latissimus Dorsi', ARRAY['바벨'], '중급', '하체 드라이브 활용, 오버헤드 잠금'),
('오버헤드 프레스', 'Overhead Press', '일반', '상체', '어깨', ARRAY['근력','근비대'], '삼각근', 'Deltoid', '광배근', 'Latissimus Dorsi', ARRAY['바벨','덤벨'], '중급', '코어 긴장 유지, 바 이동 경로 직선'),
('견갑 활성화', 'Scapular Activation', '일반', '상체', '어깨', ARRAY['활성화'], '능형근', 'Rhomboids', '소흉근', 'Pectoralis Minor', ARRAY['밴드'], '초급', '밴드, 어깨 균형 교정'),

-- 하체
('백 스쿼트', 'Back Squat', '일반', '하체', '대퇴사두', ARRAY['근력','파워','근비대'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['바벨'], '중급', '무릎 발끝 방향, 등 중립 유지'),
('프론트 스쿼트', 'Front Squat', '일반', '하체', '대퇴사두', ARRAY['근력','파워'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['바벨'], '고급', '팔꿈치 높이 유지, 코어 긴장'),
('루마니안 데드리프트', 'Romanian Deadlift', '일반', '하체', '햄스트링', ARRAY['근력','근비대'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['바벨','덤벨'], '중급', '고관절 힌지 기반, 등 중립'),
('힙 쓰러스트', 'Hip Thrust', '일반', '하체', '둔근', ARRAY['근력','근비대'], '대둔근', 'Gluteus Maximus', '대퇴사두근', 'Quadriceps', ARRAY['바벨','덤벨'], '초급', '골반 후방경사, 무릎 90도 유지'),
('불가리안 스플릿 스쿼트', 'Bulgarian Split Squat', '일반', '하체', '대퇴사두', ARRAY['근력','근비대'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['덤벨','바벨'], '중급', '앞발에 중심, 상체 직립'),
('싱글 레그 스쿼트', 'Single-leg Squat', '일반', '하체', '대퇴사두', ARRAY['근력','근지구력'], '대퇴사두근', 'Quadriceps', '햄스트링', 'Hamstrings', ARRAY['맨몸'], '고급', '무릎 외회전 유지, 고관절 힌지 혼합'),
('레그 컬', 'Leg Curl', '일반', '하체', '햄스트링', ARRAY['근비대','근지구력'], '햄스트링', 'Hamstrings', '대퇴사두근', 'Quadriceps', ARRAY['머신'], '초급', '골반 안정화, 완전 신전-굴곡'),
('카프 레이즈', 'Calf Raise', '일반', '하체', '종아리', ARRAY['근지구력','근비대'], '비복근', 'Gastrocnemius', '전경골근', 'Tibialis Anterior', ARRAY['맨몸','머신'], '초급', '완전 신전, 천천히 내려오기'),

-- 코어
('플랭크', 'Plank', '일반', '코어', '항신전', ARRAY['근지구력','활성화'], '복횡근', 'Transversus Abdominis', null, null, ARRAY['맨몸'], '초급', '몸통 일직선, 호흡 유지'),
('데드버그', 'Dead Bug', '일반', '코어', '항신전', ARRAY['활성화','근지구력'], '복횡근', 'Transversus Abdominis', null, null, ARRAY['맨몸'], '초급', '요추 바닥 고정, 천천히 사지 확장'),
('팔로프 프레스', 'Pallof Press', '일반', '코어', '항회전', ARRAY['근지구력','활성화'], '복사근', 'Obliques', null, null, ARRAY['케이블','밴드'], '초급', '몸통 회전 억제, 코어 브레이싱'),
('케이블 우드촙', 'Cable Woodchop', '일반', '코어', '회전 파워', ARRAY['파워','근지구력'], '복사근', 'Obliques', null, null, ARRAY['케이블','밴드'], '중급', '엉덩이에서 회전 시작, 팔은 고정'),
('크런치', 'Crunch', '일반', '코어', '굴곡', ARRAY['근지구력','근비대'], '복직근', 'Rectus Abdominis', null, null, ARRAY['맨몸'], '초급', '요추 과신전 방지, 목 중립'),

-- 전신 파워 (특수)
('파워 클린', 'Power Clean', '특수_파워', '전신', '전신', ARRAY['파워'], '대퇴사두근', 'Quadriceps', null, null, ARRAY['바벨'], '고급', '트리플 익스텐션 폭발, 풀 언더'),
('행 클린', 'Hang Clean', '특수_파워', '전신', '전신', ARRAY['파워'], '대퇴사두근', 'Quadriceps', null, null, ARRAY['바벨'], '고급', '무릎 위에서 시작, 파워 포지션'),
('케틀벨 스윙', 'Kettlebell Swing', '특수_파워', '전신', '전신', ARRAY['파워','근지구력'], '대둔근', 'Gluteus Maximus', null, null, ARRAY['케틀벨'], '중급', '고관절 힌지 기반 폭발적 hip drive'),
('배틀로프', 'Battle Rope', '특수_파워', '전신', '전신', ARRAY['근지구력','파워'], '삼각근', 'Deltoid', null, null, ARRAY['배틀로프'], '초급', '무릎 약간 굽히고 폭발적 타격'),

-- 점프 (특수)
('CMJ', 'Countermovement Jump', '특수_점프', '전신', '전신', ARRAY['파워'], '대퇴사두근', 'Quadriceps', null, null, ARRAY['맨몸'], '중급', 'PAP 목적 — 근력 동작 후 60~120초 내 실시'),
('박스 점프', 'Box Jump', '특수_점프', '전신', '전신', ARRAY['파워'], '대퇴사두근', 'Quadriceps', null, null, ARRAY['플라이오박스'], '중급', '최대 높이 착지, 무릎 굴곡 충격 흡수'),
('브로드 점프', 'Broad Jump', '특수_점프', '전신', '전신', ARRAY['파워'], '대둔근', 'Gluteus Maximus', null, null, ARRAY['맨몸'], '중급', '수평 거리 최대화, 발 모아 착지'),
('래터럴 바운드', 'Lateral Bound', '특수_점프', '전신', '전신', ARRAY['파워'], '대둔근', 'Gluteus Maximus', null, null, ARRAY['맨몸'], '중급', '단측 도약, 반대발 착지 안정화'),

-- 활성화 (특수)
('월 슬라이드', 'Wall Slide', '특수_활성화', '상체', '어깨', ARRAY['활성화'], '하부 승모근', 'Lower Trapezius', null, null, ARRAY['맨몸'], '초급', '벽에 등 밀착, 팔꿈치·손목 벽 유지'),
('클램쉘', 'Clamshell', '특수_활성화', '하체', '둔근', ARRAY['활성화'], '중둔근', 'Gluteus Medius', null, null, ARRAY['밴드','맨몸'], '초급', '골반 고정, 엉덩이 개방 강조'),
('힙 서클', 'Hip Circle', '특수_활성화', '하체', '둔근', ARRAY['활성화'], '대둔근', 'Gluteus Maximus', null, null, ARRAY['맨몸','밴드'], '초급', '골반 수평 유지, 천천히 원 그리기'),
('인버티드 햄스트링', 'Inverted Hamstring', '특수_활성화', '하체', '햄스트링', ARRAY['활성화'], '햄스트링', 'Hamstrings', null, null, ARRAY['맨몸'], '중급', '한 발 균형, 등 중립 T자 유지'),
('발목 모빌리티', 'Ankle Mobility', '특수_활성화', '하체', '발목', ARRAY['활성화'], '비복근', 'Gastrocnemius', null, null, ARRAY['맨몸'], '초급', '무릎 앞으로 밀기, 발뒤꿈치 고정');
