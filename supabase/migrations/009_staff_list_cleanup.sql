-- ============================================================
-- 009_staff_list_cleanup.sql — 스텝 승인 대기 목록 선수 계정 오염 제거
-- 지금 바로 실행 가능 (앱 영향 없음)
--
-- 원인: handle_new_user 트리거가 모든 신규 auth 계정에 스텝 프로필을
--       생성 → 선수 로그인 계정(p-...@player.internal)도 승인 대기에 표시됨
-- ============================================================

-- ① 이미 생성된 선수 계정의 스텝 프로필 삭제
DELETE FROM public.profiles WHERE email LIKE 'p-%@player.internal';

-- ② 트리거 함수 수정: 선수 계정은 스텝 프로필을 만들지 않음
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  -- 선수앱 로그인용 내부 계정은 스텝이 아님 → 프로필 생성 안 함
  IF new.email LIKE 'p-%@player.internal' THEN
    RETURN new;
  END IF;
  INSERT INTO public.profiles (id, email, name, role, approved)
  VALUES (
    new.id, new.email,
    new.raw_user_meta_data->>'name',
    COALESCE(new.raw_user_meta_data->>'role', 'coach'),
    false
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ③ 확인: 0이 나와야 정상
SELECT count(*) AS "남은 선수계정 프로필(0이어야 함)"
FROM public.profiles WHERE email LIKE 'p-%@player.internal';
