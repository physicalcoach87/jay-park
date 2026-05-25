import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const { email, password, club_id: reqClubId, role: reqRole } = await req.json();
    if (!email || !password) {
      return new Response(JSON.stringify({ error: "이메일과 비밀번호는 필수입니다." }), {
        status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 호출자 인증 및 역할 확인
    const authHeader = req.headers.get("Authorization");
    const callerClient = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_ANON_KEY")!,
      { global: { headers: { Authorization: authHeader! } } }
    );
    const { data: { user: caller } } = await callerClient.auth.getUser();
    if (!caller) {
      return new Response(JSON.stringify({ error: "인증이 필요합니다." }), {
        status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
    const { data: callerProf } = await callerClient
      .from("profiles").select("role,club_id").eq("id", caller.id).single();

    const callerRole = callerProf?.role;

    // superadmin: 모든 역할·모든 팀 생성 가능
    // admin: coach/physical/medical만, 자기 팀에만
    if (callerRole === "superadmin") {
      // OK — no restrictions
    } else if (callerRole === "admin") {
      const forbidden = ["admin", "superadmin"];
      if (forbidden.includes(reqRole)) {
        return new Response(JSON.stringify({ error: "팀 관리자는 admin 이상 역할을 생성할 수 없습니다." }), {
          status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }
    } else {
      return new Response(JSON.stringify({ error: "권한이 없습니다." }), {
        status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // club_id 결정: admin이면 반드시 자기 팀, superadmin은 요청값 사용
    const finalClubId = callerRole === "admin" ? callerProf.club_id : (reqClubId || null);

    // 서비스 롤 키로 유저 생성
    const adminClient = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );
    const { data: newUser, error: createErr } = await adminClient.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
    });
    if (createErr) {
      return new Response(JSON.stringify({ error: createErr.message }), {
        status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // profiles 생성
    await adminClient.from("profiles").upsert({
      id: newUser.user.id,
      email,
      club_id: finalClubId,
      role: reqRole || "coach",
    });

    return new Response(JSON.stringify({ success: true, user_id: newUser.user.id }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: e.message }), {
      status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
