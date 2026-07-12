import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import webpush from "npm:web-push@3.6.7";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};
const json = (b: unknown, status = 200) =>
  new Response(JSON.stringify(b), { status, headers: { ...corsHeaders, "Content-Type": "application/json" } });

const PUBLISHABLE = "sb_publishable_sj1Pro0Pwv3i-RzQdHsEPw_WLJUsa9V"; // 공개키(로그인 검증용)

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  const SERVICE = Deno.env.get("SUPA_SERVICE_ROLE") ?? Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
  const URL     = Deno.env.get("SUPA_URL") ?? Deno.env.get("SUPABASE_URL") ?? "";
  if (!SERVICE || !URL) return json({ error: "server misconfigured" }, 500);

  const admin = createClient(URL, SERVICE);

  // ── 인증: 서비스롤(서버) 또는 로그인한 스태프(코치앱) 만 허용 ──
  const authHeader = req.headers.get("Authorization") ?? "";
  const token = authHeader.replace("Bearer ", "");
  let isService = false;
  let callerClub: string | null = null;
  let callerSuper = false;

  if (token && token === SERVICE) {
    isService = true;
  } else {
    // 로그인한 사용자 토큰 검증
    const userClient = createClient(URL, PUBLISHABLE, { global: { headers: { Authorization: authHeader } } });
    const { data: { user } } = await userClient.auth.getUser();
    if (!user) return json({ error: "unauthorized" }, 401);
    const { data: prof } = await admin.from("profiles").select("role,club_id").eq("id", user.id).single();
    if (!prof) return json({ error: "forbidden (not staff)" }, 403); // 선수 계정 등 차단
    callerClub = prof.club_id;
    callerSuper = prof.role === "superadmin";
  }

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "bad json" }, 400); }
  const n = body?.record ?? body;
  if (!n || !n.title) return json({ error: "no notification" }, 400);

  // ── 수신 대상 player_id ──
  const tt = String(n.target_type ?? "").toLowerCase();
  let pids: string[] = [];
  if (tt === "player") {
    const pid = n.target_value ?? n.player_id;
    if (pid) {
      // 타 팀 선수에게 못 보내게: 대상 선수의 소속 클럽 확인
      const { data: pl } = await admin.from("player_profiles").select("id,club_id").eq("id", pid).single();
      if (pl && (isService || callerSuper || pl.club_id === callerClub)) pids = [pl.id];
    }
  } else if (tt === "all" || tt === "team") {
    const club = isService ? (n.club_id ?? null) : callerClub;
    if (club) {
      const { data: ps } = await admin.from("player_profiles")
        .select("id").eq("club_id", club).neq("status", "transferred");
      pids = (ps ?? []).map((p: any) => p.id);
    }
  }
  if (!pids.length) return json({ sent: 0, reason: "no recipients" });

  const { data: subs } = await admin.from("push_subscriptions").select("*").in("player_id", pids);
  if (!subs?.length) return json({ sent: 0, reason: "no subscriptions" });

  webpush.setVapidDetails(
    Deno.env.get("VAPID_SUBJECT") ?? "mailto:coach@ipark.com",
    Deno.env.get("VAPID_PUBLIC_KEY")!,
    Deno.env.get("VAPID_PRIVATE_KEY")!,
  );
  const payload = JSON.stringify({
    title: n.title, body: n.body ?? "", url: "/ipark-player/", tag: "ipark-" + (n.id ?? Date.now()),
  });

  let sent = 0, removed = 0, failed = 0;
  for (const s of subs) {
    try {
      await webpush.sendNotification({ endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } }, payload);
      sent++;
    } catch (e) {
      const code = (e as any)?.statusCode;
      if (code === 404 || code === 410) { await admin.from("push_subscriptions").delete().eq("endpoint", s.endpoint); removed++; }
      else failed++;
    }
  }
  return json({ sent, removed, failed, recipients: pids.length });
});
