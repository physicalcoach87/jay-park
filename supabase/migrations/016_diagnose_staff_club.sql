-- ============================================================
-- 016_diagnose_staff_club.sql — 스태프 데이터 안 보임 진단 (읽기전용, 안전)
-- 결과 3개 표를 캡처해서 공유해주세요.
-- ============================================================

-- ① 스태프 계정별 소속 클럽 (superadmin 제외)
--    club_id가 비어(NULL) 있거나 club 이름이 안 뜨면 그게 원인
SELECT p.email, p.role, p.club_id, c.name AS club_name
FROM profiles p LEFT JOIN clubs c ON c.id = p.club_id
WHERE COALESCE(p.role,'') <> 'superadmin'
ORDER BY p.email;

-- ② 등록된 클럽 목록
SELECT id, name FROM clubs ORDER BY created_at;

-- ③ 데이터가 어느 club_id로 저장돼 있는지 (선수·GPS)
SELECT 'player_profiles' AS tbl, club_id, count(*) FROM player_profiles GROUP BY club_id
UNION ALL
SELECT 'gps_records', club_id, count(*) FROM gps_records GROUP BY club_id
ORDER BY tbl;
