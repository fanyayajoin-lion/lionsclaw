# Skill: image-gen

透過 Zeabur AI Hub 呼叫 Gemini 原生生圖。

## 環境變數
- `ZEABUR_AI_HUB_API_KEY` — 已在環境中
- Endpoint：`https://hnd1.aihub.zeabur.ai`

## 呼叫與存檔（完整範例）

```bash
OUTPUT_DIR="$OPENCLAW_WORKSPACE/output/images"
mkdir -p "$OUTPUT_DIR"
FILENAME="$OUTPUT_DIR/$(date +%Y-%m-%d_%H%M%S).png"

curl -s https://hnd1.aihub.zeabur.ai/v1/chat/completions \
  -H "Authorization: Bearer $ZEABUR_AI_HUB_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"gemini-2.5-flash-image\",
    \"messages\": [{\"role\": \"user\", \"content\": \"$PROMPT\"}],
    \"response_modalities\": [\"IMAGE\"]
  }" \
| jq -r '.choices[0].message.images[0].image_url.url' \
| sed 's/data:image\/png;base64,//' \
| base64 -d > "$FILENAME"

echo "已存檔：$FILENAME"
```

## 回傳結構
```json
{
  "choices": [{
    "message": {
      "images": [{
        "image_url": { "url": "data:image/png;base64,..." }
      }]
    }
  }]
}
```

## 尺寸控制
Gemini 透過 prompt 控制比例，在 prompt 結尾加：
- 方形（FB/IG）：`square format, 1:1 aspect ratio`
- 直式（IG 限動）：`vertical format, 9:16 aspect ratio`
- 橫式（FB 橫幅）：`horizontal format, 16:9 aspect ratio`

## 傳圖到 Telegram

圖片存檔後，用 sendPhoto API 傳給業萱（不要把 base64 貼進訊息）：

```bash
# BOT_TOKEN = 對應客戶的 Bot token 環境變數
# CHAT_ID = 8187198139（業萱）
curl -s -F "chat_id=8187198139" \
  -F "photo=@$FILENAME" \
  -F "caption=$CAPTION" \
  "https://api.telegram.org/bot$BOT_TOKEN/sendPhoto"
```

## 使用流程
1. 讀該客戶 BRAND.md，確認視覺風格
2. 撰寫 prompt（英文），結尾加比例指示
3. 生圖並存檔到 `output/images/`
4. 用 sendPhoto 傳 PNG 檔 + 文案 caption 給業萱確認

## 注意
- 群獅業萱人物形象：女性T（短髮、中性俐落穿著）
- 生圖前必須讀過 BRAND.md
- 對外使用前一律等業萱確認
