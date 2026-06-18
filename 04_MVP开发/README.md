# Vowice MVP 开发

本目录用于存放可运行 MVP 源码、接口文档、数据库迁移、测试和构建说明。

## 建议工程结构

```text
04_MVP开发/
├── app/                  # Expo React Native
├── api/                  # FastAPI
├── supabase/
│   ├── migrations/
│   └── seed/
├── docs/
│   ├── api.md
│   ├── architecture.md
│   └── licenses.md
├── tests/
├── .env.example
└── README.md
```

## 开发底线

- API Key 只保存在服务端环境变量，不写入 App 或 Git。
- ASR、LLM 和 TTS 通过 Provider 接口封装。
- 新功能同时提交成功、空、加载、错误和恢复状态。
- 不将真实用户录音、访谈记录或生产凭据放入仓库。
- 每晚 Agent 完成后，次日先读 diff、测试结果和未解决问题，再进行人工合并。

