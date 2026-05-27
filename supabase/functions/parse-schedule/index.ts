import Anthropic from "npm:@anthropic-ai/sdk";

const client = new Anthropic({ apiKey: Deno.env.get("ANTHROPIC_API_KEY") });

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, content-type",
  "Content-Type": "application/json",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: CORS });
  }

  try {
    const { imageBase64, imageType } = await req.json();
    if (!imageBase64) throw new Error("imageBase64 필요");

    const mediaType = (imageType || "image/jpeg") as
      | "image/jpeg"
      | "image/png"
      | "image/gif"
      | "image/webp";

    const msg = await client.messages.create({
      model: "claude-opus-4-7",
      max_tokens: 2000,
      messages: [
        {
          role: "user",
          content: [
            {
              type: "image",
              source: { type: "base64", media_type: mediaType, data: imageBase64 },
            },
            {
              type: "text",
              text: `이 이미지는 축구팀 주간 일정표입니다. 이미지에 있는 모든 일정을 빠짐없이 JSON 배열로 파싱해주세요.

각 항목 형식:
{
  "event_date": "YYYY-MM-DD",
  "start_time": "HH:MM",
  "event_type": "TRAINING|MATCH|GYM|REST|MEAL|SNACK|EVENT",
  "title": "일정 제목",
  "team": "ALL|A|B"
}

규칙:
- event_type: 훈련/연습 → TRAINING, 경기 → MATCH, 웨이트/GYM → GYM, 휴식/휴일 → REST, 식사 → MEAL, 간식/보충 → SNACK, 기타 → EVENT
- team: A팀만 → A, B팀만 → B, 전체/팀 전체/미표기 → ALL
- 날짜가 불명확하면 이미지 문맥(연도·월·주차)으로 추론. 연도는 2026
- start_time 없으면 null
- JSON 배열만 출력, 다른 텍스트 없이`,
            },
          ],
        },
      ],
    });

    const raw = msg.content[0].type === "text" ? msg.content[0].text.trim() : "[]";
    const match = raw.match(/\[[\s\S]*\]/);
    const events = match ? JSON.parse(match[0]) : [];

    return new Response(JSON.stringify({ events }), { headers: CORS });
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    return new Response(JSON.stringify({ error: message }), {
      status: 500,
      headers: CORS,
    });
  }
});
