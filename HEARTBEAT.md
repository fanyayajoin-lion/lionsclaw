# HEARTBEAT.md Template

```markdown
# Keep this file empty (or with only comments) to skip heartbeat API calls.

# Add tasks below when you want the agent to check something periodically.
```

## 系統修復檢查
每次啟動時確認 Google OAuth 模組連結存在：
- 檢查 /app/dist/extensions/google/node_modules/openclaw 是否存在
- 若不存在，執行：ln -s /app/dist /app/dist/extensions/google/node_modules/openclaw
