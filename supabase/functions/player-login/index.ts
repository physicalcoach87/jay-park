import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status, headers: { ...corsHeaders, "Content-Type": "application/json" },
  });

const MAX_FAILS = 5;
const LOCK_MINUTES = 5;

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const { name, pin } = await req.json();
    if (!name || !pin) return json({ error: "이름과 PIN을 입력하세요." }, 400);

    const admin = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    // 이름으로 선수 조회 (대소문자 무관, 정확 일치 우선 — 기존 앱과 동일 로직)
    const { data: rows, error: qErr } = await admin
      .from("player_profiles")
      .select("id, name, pin, status, club_id, auth_user_id, failed_logins, locked_until")
      .ilike("name", name.trim());
    if (qErr) return json({ error: "조회 실패: " + qErr.message }, 500);
    if (!rows?.length) return json({ error: "not_found" }, 404);

    const player =
      rows.find((p) => p.name.trim() === name.trim()) || rows[0];

    if (player.status === "transferred") return json({ error: "transferred" }, 403);

    // 잠금 확인
    if (player.locked_until && new Date(player.locked_until) > new Date()) {
      return json({ error: "locked", until: player.locked_until }, 429);
    }

    // PIN 검증 (미설정 시 기본 '0000' — 기존 앱과 동일)
    const expected = player.pin || "0000";
    if (pin !== expected) {
      const fails = (player.failed_logins || 0) + 1;
      const patch: Record<string, unknown> = { failed_logins: fails };
      if (fails >= MAX_FAILS) {
        patch.locked_until = new Date(Date.now() + LOCK_MINUTES * 60000).toISOString();
        patch.failed_logins = 0;
      }
      await admin.from("player_profiles").update(patch).eq("id", player.id);
      return json({ error: "wrong_pin" }, 401);
    }

    // 성공 → 실패 카운터 초기화
    if (player.failed_logins || player.locked_until) {
      await admin.from("player_profiles")
        .update({ failed_logins: 0, locked_until: null }).eq("id", player.id);
    }

    // 선수용 Auth 계정 확보 (없으면 생성)
    const email = `p-${player.id}@player.internal`;
    let authUserId = player.auth_user_id;
    if (!authUserId) {
      const { data: created, error: cErr } = await admin.auth.admin.createUser({
        email, email_confirm: true,
        user_metadata: { player_id: player.id, club_id: player.club_id },
      });
      if (cErr && !cErr.message?.includes("already")) {
        return json({ error: "계정 생성 실패: " + cErr.message }, 500);
      }
      authUserId = created?.user?.id ?? null;
      if (!authUserId) {
        // 이미 존재하는 경우 이메일로 검색
        const { data: list } = await admin.auth.admin.listUsers();
        authUserId = list?.users?.find((u) => u.email === email)?.id ?? null;
      }
      if (!authUserId) return json({ error: "계정 확인 실패" }, 500);
      await admin.from("player_profiles")
        .update({ auth_user_id: authUserId }).eq("id", player.id);
    }

    // 세션 발급용 매직링크 토큰 생성 → 클라이언트가 verifyOtp로 세션 획득
    const { data: link, error: lErr } = await admin.auth.admin.generateLink({
      type: "magiclink", email,
    });
    if (lErr || !link?.properties?.hashed_token) {
      return json({ error: "세션 발급 실패: " + (lErr?.message || "") }, 500);
    }

    return json({
      token_hash: link.properties.hashed_token,
      player_id: player.id,
    });
  } catch (e) {
    return json({ error: "서버 오류: " + (e as Error).message }, 500);
  }
});
