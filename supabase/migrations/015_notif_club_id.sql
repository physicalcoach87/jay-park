-- ============================================================
-- 015_notif_club_id.sql — 알림 club_id 자동 채움 + 푸시 발송 준비
--
-- 문제: 앱이 notifications insert 시 club_id를 안 넣음.
--   - 슈퍼어드민은 RLS WITH CHECK를 통과하지만
--   - 일반 팀 관리자(비-슈퍼어드민)는 club_id 누락으로 저장 거부됨
--   - 팀 전체 공지 푸시도 club_id로 대상을 좁혀야 함
--
-- 해결: BEFORE INSERT 트리거로 club_id를 작성자의 소속 클럽으로 자동 채움
--       (BEFORE 트리거가 먼저 실행되고 그 결과에 RLS WITH CHECK가 적용되므로
--        insert가 정상 통과함). 클라이언트 코드 수정 불필요.
-- ============================================================

CREATE OR REPLACE FUNCTION fill_notification_club()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF NEW.club_id IS NULL THEN
    NEW.club_id := app_staff_club();  -- 작성자(코치) 소속 클럽
  END IF;
  RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS trg_fill_notification_club ON notifications;
CREATE TRIGGER trg_fill_notification_club
  BEFORE INSERT ON notifications
  FOR EACH ROW EXECUTE FUNCTION fill_notification_club();

-- 참고: 과거에 club_id 없이 저장된 알림이 있으면 아래로 보정 가능(선택)
-- UPDATE notifications n SET club_id = p.club_id
--   FROM player_profiles p
--   WHERE n.club_id IS NULL AND n.target_type='player' AND n.target_value::text = p.id::text;
