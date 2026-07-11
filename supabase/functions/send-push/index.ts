import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import webpush from "npm:web-push@3.6.7";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};
const json = (b: unknown, status = 200) =>
  new Response(JSON.stringify(b), { status, headers: { ...corsHeaders, "Content-Type": "application/json" } });

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  const SERVICE = Deno.env.get("SUPA_SERVICE_ROLE") ?? Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
  const URL     = Deno.env.get("SUPA_URL") ?? Deno.env.get("SUPABASE_URL") ?? "";

  // 인증: 서비스롤로 호출된 경우만 허용 (DB 웹훅에서 Authorization 헤더로 전달)
  const auth = req.headers.get("Authorization") ?? "";
  if (!SERVICE || auth !== `Bearer ${SERVICE}`) return json({ error: "unauthorized" }, 401);

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "bad json" }, 400); }

  // DB 웹훅 형태({type,record}) 또는 직접 호출({title,...}) 모두 지원
  const n = body?.record ?? body;
  if (!n || !n.title) return json({ error: "no notification" }, 400);

  webpush.setVapidDetails(
    Deno.env.get("VAPID_SUBJECT") ?? "mailto:coach@ipark.com",
    Deno.env.get("VAPID_PUBLIC_KEY")!,
    Deno.env.get("VAPID_PRIVATE_KEY")!,
  );
  const admin = createClient(URL, SERVICE);

  // 수신 대상 player_id 결정
  const tt = String(n.target_type ?? "").toLowerCase();
  let pids: string[] = [];
  if (tt === "player") {
    pids = [n.target_value ?? n.player_id].filter(Boolean);
  } else if (tt === "all" || tt === "team") {
    if (n.club_id) {
      const { data: ps } = await admin.from("player_profiles")
        .select("id").eq("club_id", n.club_id).neq("status", "transferred");
      pids = (ps ?? []).map((p: any) => p.id);
    }
  }
  if (!pids.length) return json({ sent: 0, reason: "no recipients" });

  const { data: subs } = await admin.from("push_subscriptions").select("*").in("player_id", pids);
  if (!subs?.length) return json({ sent: 0, reason: "no subscriptions" });

  const payload = JSON.stringify({
    title: n.title,
    body: n.body ?? "",
    url: "/ipark-player/",
    tag: "ipark-" + (n.id ?? Date.now()),
  });

  let sent = 0, removed = 0, failed = 0;
  for (const s of subs) {
    try {
      await webpush.sendNotification(
        { endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } },
        payload,
      );
      sent++;
    } catch (e) {
      const code = (e as any)?.statusCode;
      if (code === 404 || code === 410) {
        // 만료/폐기된 구독 → 정리
        await admin.from("push_subscriptions").delete().eq("endpoint", s.endpoint);
        removed++;
      } else {
        failed++;
      }
    }
  }
  return json({ sent, removed, failed, recipients: pids.length });
});
