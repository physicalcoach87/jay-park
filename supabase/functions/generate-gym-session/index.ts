import Anthropic from "npm:@anthropic-ai/sdk";

const client = new Anthropic({ apiKey: Deno.env.get("ANTHROPIC_API_KEY") });

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, content-type",
  "Content-Type": "application/json",
};

// MD → 목적 → 방법 권장 매핑
const MD_RECOMMENDATIONS: Record<string, { purpose: string; method: string; volume: string; intensity: string }> = {
  "MD-5": { purpose: "근비대/근지구력", method: "서킷",                    volume: "High",      intensity: "Low" },
  "MD-4": { purpose: "근력",           method: "슈퍼세트",                 volume: "High",      intensity: "Medium" },
  "MD-3": { purpose: "근력/파워",      method: "슈퍼세트, 컨트라스트",      volume: "High",      intensity: "High" },
  "MD-2": { purpose: "파워/활성화",    method: "컨트라스트",               volume: "Low",       intensity: "High" },
  "MD-1": { purpose: "활성화",         method: "슈퍼세트 (저볼륨)",         volume: "Low",       intensity: "Low" },
  "비시즌": { purpose: "근비대/근지구력", method: "서킷, 스트레이트",        volume: "Very High", intensity: "Low~Med" },
};

// 목적별 기본 처방 기준
const PURPOSE_PRESCRIPTION: Record<string, { sets: string; reps: string; intensity: string; rest: string }> = {
  "근력":    { sets: "4–5", reps: "3–6",   intensity: "85–95% 1RM", rest: "3–5분" },
  "파워":    { sets: "4–5", reps: "3–5",   intensity: "70–85% 1RM", rest: "3–4분" },
  "근비대":  { sets: "3–4", reps: "8–12",  intensity: "65–75% 1RM", rest: "60–90초" },
  "근지구력": { sets: "3",  reps: "15–20", intensity: "50–60% 1RM", rest: "30–60초" },
  "활성화":  { sets: "2–3", reps: "10–15", intensity: "낮음~중등도", rest: "30초" },
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: CORS });

  try {
    const body = await req.json();
    const {
      session_type,       // 'group' | 'individual'
      total_players,
      group_size,
      num_stations,
      md_stage,
      body_part,
      purpose,
      method,
      available_equipment,
      exercise_pool,      // exercises 테이블에서 필터링된 종목 목록
      num_exercises,      // 개인운동 전용
      position,           // 개인운동 전용 (포지션)
      session_duration,   // 세션 시간 (분)
    } = body;

    if (!md_stage || !body_part || !purpose || !method) {
      throw new Error("필수 파라미터 누락: md_stage, body_part, purpose, method");
    }

    const rec = MD_RECOMMENDATIONS[md_stage] || MD_RECOMMENDATIONS["MD-4"];
    const presc = PURPOSE_PRESCRIPTION[purpose] || PURPOSE_PRESCRIPTION["근력"];

    // 운동 풀 → AI에 전달할 형식으로 정리
    const poolSummary = (exercise_pool || [])
      .slice(0, 40) // 토큰 절약
      .map((e: Record<string, unknown>) =>
        `${e.name_ko}(${e.name_en}) | 주동근:${e.primary_muscle_ko} | 길항근:${e.antagonist_ko || "—"} | 난이도:${e.difficulty}`
      ).join("\n");

    // 단체 vs 개인 프롬프트 분기
    const isGroup = session_type === "group";
    const stationCount = num_stations || Math.ceil((total_players || 12) / (group_size || 3));

    const systemPrompt = `당신은 축구 피지컬 코치를 위한 GYM 세션 처방 전문가입니다.
주동근-길항근 슈퍼세트 원칙에 따라 과학적 근거가 있는 처방을 생성하세요.
반드시 JSON만 출력하세요. 설명 텍스트 없음.`;

    const userPrompt = isGroup
      ? `다음 조건으로 단체 GYM 세션을 처방하세요.

세션 조건:
- 총 인원: ${total_players}명 / 그룹당 ${group_size}명 / 스테이션 ${stationCount}개
- MD 단계: ${md_stage} (${rec.purpose} 권장)
- 운동 부위: ${body_part}
- 목적: ${purpose} → 처방 기준: ${presc.sets}세트 × ${presc.reps}회 / ${presc.intensity} / 휴식 ${presc.rest}
- 방법: ${method}
- 세션 시간: ${session_duration || 60}분
- 사용 가능 기구: ${(available_equipment || []).join(", ")}

사용 가능한 운동 풀:
${poolSummary || "기본 운동 종목 사용"}

출력 JSON 형식:
{
  "session_info": { "total_players": number, "group_size": number, "num_stations": number, "body_part": string, "md_stage": string, "purpose": string, "method": string, "total_duration_min": number },
  "intensity_rationale": "이 MD 단계에서 이 목적을 선택한 이유 1줄",
  "warmup_exercises": ["웜업 동작 1", "웜업 동작 2", "웜업 동작 3"],
  "stations": [
    {
      "number": 1,
      "primary_muscle_group": "주동근 (영문)",
      "antagonist_muscle_group": "길항근 (영문)",
      "exercise_a": { "name": string, "sets": number, "reps": string, "intensity_description": string, "coaching_cue": string },
      "exercise_b": { "name": string, "sets": number, "reps": string, "intensity_description": string, "coaching_cue": string },
      "rest_sec": number,
      "football_context": "축구 퍼포먼스 연계 설명 1줄"
    }
  ],
  "rotation_note": "그룹별 스테이션 이동 순서 설명",
  "timeline": [
    { "phase": string, "duration_min": number }
  ],
  "coaching_notes": ["코칭 포인트 1", "코칭 포인트 2", "코칭 포인트 3"]
}`
      : `다음 조건으로 개인 GYM 세션을 처방하세요.

세션 조건:
- 포지션: ${position || "범용"}
- MD 단계: ${md_stage}
- 운동 부위: ${body_part}
- 목적: ${purpose} → 처방 기준: ${presc.sets}세트 × ${presc.reps}회 / ${presc.intensity} / 휴식 ${presc.rest}
- 방법: ${method}
- 운동 종류 수: ${num_exercises || 4}개
- 세션 시간: ${session_duration || 45}분
- 사용 가능 기구: ${(available_equipment || []).join(", ")}

사용 가능한 운동 풀:
${poolSummary || "기본 운동 종목 사용"}

출력 JSON 형식:
{
  "session_info": { "position": string, "body_part": string, "md_stage": string, "purpose": string, "method": string, "num_exercises": number, "total_duration_min": number },
  "intensity_rationale": "이 MD 단계에서 이 목적을 선택한 이유 1줄",
  "warmup_exercises": ["웜업 동작 1", "웜업 동작 2"],
  "exercises": [
    {
      "order": 1,
      "name": string,
      "primary_muscle_ko": string,
      "paired_with": string | null,
      "sets": number,
      "reps": string,
      "intensity_description": string,
      "rest_sec": number,
      "coaching_cue": string,
      "football_context": "축구 퍼포먼스 연계 설명"
    }
  ],
  "coaching_notes": ["코칭 포인트 1", "코칭 포인트 2"]
}`;

    const msg = await client.messages.create({
      model: "claude-sonnet-4-6",
      max_tokens: 2000,
      system: systemPrompt,
      messages: [{ role: "user", content: userPrompt }],
    });

    const rawText = (msg.content[0] as { type: string; text: string }).text.trim();

    // JSON 파싱 (마크다운 코드블록 제거)
    const jsonStr = rawText.replace(/^```json?\n?/, "").replace(/\n?```$/, "");
    const sessionData = JSON.parse(jsonStr);

    return new Response(JSON.stringify({ ok: true, data: sessionData }), { headers: CORS });

  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    return new Response(JSON.stringify({ ok: false, error: message }), {
      status: 500,
      headers: CORS,
    });
  }
});
