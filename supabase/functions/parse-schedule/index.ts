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
      model: "claude-opus-4-8",
      max_tokens: 5000,
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
              text: `이 이미지는 축구팀 주간 일정표입니다. OCR 문자만 읽지 말고 표의 행/열, 병합 셀, 글자색과 A팀/B팀 영역을 함께 해석해 모든 일정을 JSON 배열로 파싱해주세요.

각 항목 형식:
{
  "event_date": "YYYY-MM-DD",
  "start_time": "HH:MM",
  "event_type": "TRAINING|MATCH|GYM|REST|MEAL|SNACK|EVENT",
  "title": "일정 제목",
  "team": "ALL|A|B",
  "description": "장소·시간대·비고 등 보조 정보",
  "confidence": "HIGH|MEDIUM|LOW",
  "review_reason": "사람의 확인이 필요한 이유 또는 빈 문자열"
}

규칙:
- 날짜 열을 먼저 확정한 뒤 각 날짜 안에서 조식/오전/중식/오후/석식/비고 순서로 읽는다.
- A팀 행은 A, B팀 행은 B. A/B 두 영역에 걸친 병합 셀과 공통 비고는 ALL이다.
- 팀 표기가 없는 공통 소집·이동·미팅·출발은 ALL로 처리한다.
- 도착, 미팅, 간식, 출발, 훈련, 경기는 한 문장으로 합치지 말고 시간별 별도 항목으로 만든다.
- 오전 또는 오후만 REST인 경우 해당 팀의 REST 항목으로 만들고, 하루 전체 REST이면 그 팀/전체의 시간 없는 REST 한 건으로 만든다.
- event_type: 필드 훈련/연습 → TRAINING, 경기 → MATCH, 웨이트/GYM → GYM, 휴식 → REST, 조식/중식/석식 → MEAL, 간식/보충 → SNACK, 도착/소집/미팅/출발/이동/기타 → EVENT.
- 장소 행의 값은 해당 날짜 세션의 description에 "장소: ..."로 넣는다.
- 비고 행의 식사 운영 정보 등은 관련 일정 description에 넣고, 연결하기 어렵다면 별도 EVENT로 만든다.
- 날짜가 불명확하면 이미지 문맥(연도·월·주차)으로 추론한다. 연도 표기가 없으면 현재 연도 ${new Date().getFullYear()}를 사용한다.
- start_time 없으면 null
- 추론했거나 팀/시간/셀 경계가 불명확하면 confidence를 MEDIUM 또는 LOW로 하고 review_reason에 이유를 쓴다.
- 이미지에 없는 내용은 만들지 않는다.
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
