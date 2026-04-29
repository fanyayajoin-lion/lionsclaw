# Skill: comfyui-runner

透過 ComfyUI API 執行工作流生圖，支援 LoRA、自訂模型、完整 ComfyUI 工作流。

## 環境變數
- `COMFYUI_URL` — ComfyUI 主機位址（需開啟外網存取）
  - 同主機：`http://127.0.0.1:8188`
  - 不同主機：`http://YOUR_COMFYUI_IP:8188`

## 工作流 JSON 位置
所有工作流存放在 `workflows/` 目錄：
- `workflows/default.json` — 預設通用工作流
- `workflows/客戶名_用途.json` — 客戶專屬工作流

從 ComfyUI 匯出：**Save（存檔）→ Export（匯出）→ 存到 `workflows/`**

## 呼叫方式

```bash
# 基本呼叫（使用 JSON 內的預設尺寸）
comfyui-runner \
  --workflow workflows/default.json \
  --prompt "YOUR_PROMPT_HERE" \
  --output output/images/

# 指定尺寸（覆蓋 JSON 內的設定）
comfyui-runner \
  --workflow workflows/default.json \
  --prompt "YOUR_PROMPT_HERE" \
  --width 1024 --height 1024 \
  --output output/images/

# 使用 LoRA（prompt 裡要包含 LoRA 關鍵字）
comfyui-runner \
  --workflow workflows/lora_workflow.json \
  --prompt "YOUR_PROMPT_HERE, <lora:YOUR_LORA_NAME:0.8>" \
  --output output/images/
```

## LoRA 使用規則
- prompt 必須包含 LoRA 觸發關鍵字（由工作流 JSON 決定）
- 格式：`<lora:LORA_檔名不含副檔名:權重>` （例如 `<lora:lion_brand_v1:0.8>`）
- 若不確定觸發詞，查看工作流 JSON 或詢問業萱

## 工作流變數對照
| 參數 | 說明 | 預設值來源 |
|------|------|-----------|
| `--width` | 圖片寬度 | JSON 內節點設定 |
| `--height` | 圖片高度 | JSON 內節點設定 |
| `--steps` | 推理步數 | JSON 內節點設定 |
| `--cfg` | CFG Scale | JSON 內節點設定 |
| `--seed` | 隨機種子（不指定則隨機）| 隨機 |

## 各平台尺寸建議
| 用途 | width | height |
|------|-------|--------|
| FB / IG 方形貼文 | 1024 | 1024 |
| IG 限時動態 | 768 | 1344 |
| FB 橫幅 | 1344 | 768 |
| 脆封面 | 1024 | 1024 |

## 使用流程
1. 讀該客戶 BRAND.md，確認視覺風格與 LoRA 設定
2. 選對應工作流（`workflows/` 目錄）
3. 撰寫 prompt（英文，若有 LoRA 記得帶關鍵字）
4. 執行 comfyui-runner，指定尺寸
5. 存檔到 `output/images/`
6. 連圖帶文推 Telegram 給業萱確認

## ComfyUI 外網設定（OpenClaw 和 ComfyUI 不同主機時）
ComfyUI 啟動時加參數：
```bash
python main.py --listen 0.0.0.0 --port 8188
```
然後把 `COMFYUI_URL` 設為 ComfyUI 主機的外網 IP 或域名。

## 注意
- 群獅業萱人物形象：女性T（短髮、中性俐落穿著），不使用男性形象
- 生圖前必須讀過 BRAND.md
- 對外使用前一律等業萱確認
