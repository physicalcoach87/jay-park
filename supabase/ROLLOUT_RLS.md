# RLS 실제 적용 순서 (데이터 격리)

⚠️ **순서를 지키지 않으면 앱이 멈춥니다.** 위에서 아래로 하나씩.

## 현재 문제 (왜 하는가)
- RLS 정책이 전부 `USING(true)` = 자물쇠에 열쇠가 꽂혀 있는 상태
- anon 키로 **모든 클럽의 선수 PIN·부상·웰니스·GPS 전체 조회 가능** (확인됨)
- 선수앱 로그인이 브라우저에서 PIN을 비교 → PIN이 클라이언트로 노출
- 타 팀 납품(상용화) 전 반드시 해결해야 하는 항목

## 적용 순서

### 1단계 — 준비 (지금 바로, 앱 영향 없음)
1. Supabase 대시보드 → SQL Editor → `migrations/006_rls_prep.sql` 전체 실행
   - auth 연결 컬럼, 헬퍼 함수, 초대 RPC, PIN 가드 트리거 생성
2. Edge Function 배포: 대시보드 → Edge Functions → New Function →
   이름 `player-login`, `functions/player-login/index.ts` 내용 붙여넣기 → Deploy
   - **"Verify JWT" 옵션 끄기** (로그인 전 호출이므로)

### 2단계 — 앱 배포
3. **선수앱** (`ipark-player/index.html`) 푸시 → GitHub Pages 배포
   - 선수들은 다음 접속 때 한 번 재로그인하게 됨 (이름+PIN 동일, 달라지는 것 없음)
4. **코치 웹앱**: index-dev.html 테스트 후 index.html 복사 → 푸시
   - 초대 링크 가입 흐름이 RPC 방식으로 변경됨 (겉보기 동일)

### 3단계 — 전환 확인 (선수 전원 재로그인 대기, 보통 1~2일)
5. SQL Editor에서 확인:
   ```sql
   SELECT name FROM player_profiles
   WHERE auth_user_id IS NULL AND status != 'transferred';
   ```
   → **0명이 될 때까지 대기.** 남은 선수는 단톡방에 재로그인 안내.

### 4단계 — 잠금 (핵심)
6. `migrations/007_rls_enforce.sql` 전체 실행
   - 이 순간부터 anon 키로는 아무것도 못 읽음
7. 즉시 동작 확인:
   - 코치 웹/모바일 로그인 → 팀요약·선수데이터 표시 확인
   - 선수앱 로그인 → 웰니스 입력 1건 테스트
   - 시크릿창 콘솔에서 침투 테스트 (아래) → **빈 배열이 나와야 정상**
   ```js
   // 로그인 없이 실행했을 때 []가 나와야 함
   fetch('https://gmrhkbddhzpfqzkhuvgf.supabase.co/rest/v1/player_profiles?select=name,pin',
     {headers:{apikey:'sb_publishable_sj1Pro0Pwv3i-RzQdHsEPw_WLJUsa9V'}}).then(r=>r.json()).then(console.log)
   ```

### 문제 발생 시 롤백
급할 때 (특정 테이블만 문제):
```sql
ALTER TABLE <문제테이블> DISABLE ROW LEVEL SECURITY;
```
→ 원인 파악 후 다시 ENABLE. (007 파일 하단 롤백 주석 참조)

## 이후 남은 보안 항목 (다음 단계)
- [ ] Storage 버킷(운동 영상) 정책 점검 — 이번 범위에서 제외됨
- [ ] player_profiles.access_token 컬럼 — 미사용 확인됨, 삭제 권장
- [ ] PIN 해시 저장 (현재 평문) — player-login 함수가 자리를 잡으면 bcrypt 전환
- [ ] CLAUDE.md에 적힌 구(legacy) anon key 폐기 확인
