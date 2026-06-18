# Vowice 用户调研问卷使用说明

## 这份问卷验证什么

这不是市场规模调查，而是一轮面向产品决策的探索性问卷，预计完成时间为 5–8 分钟。它主要验证：

1. 用户在什么场景下需要语音陪伴。
2. 声音定制、情境通话、共同记忆、主动语音中，哪些体验更值得优先开发。
3. 用户能接受怎样的主动联系和记忆边界。
4. 隐私、依赖、越界、声音自然度等顾虑的相对优先级。

问卷不要求姓名或联系方式，只收集与产品方向有关的选择和一条选填建议。

## 文件说明

- `Vowice_用户研究问卷.html`：可直接打开和部署的问卷。
- `survey-config.js`：切换本地演示与正式数据收集。
- `supabase-survey.sql`：创建数据库表和只写权限。
- `Vowice_问卷字段说明.md`：题目、字段和研究目的对照。
- `Vowice_问卷视觉概念.png`：视觉方向留档。

## 先在本地试填

1. 保持 `survey-config.js` 中的 `mode: "local"`。
2. 直接打开 `Vowice_用户研究问卷.html`。
3. 演示答案只保存在当前浏览器，不会上传。
4. 在网址末尾加入 `?admin=1`，可在完成页导出该浏览器中的演示数据。

本地数据只适合验收，不适合正式招募。清除浏览器数据后，本地答案也会被清除。

## 用 Supabase 正式收集

Supabase 会基于数据库表生成 REST API，网页可以直接提交数据。官方建议同时使用最小权限的 `GRANT` 和行级安全策略（RLS）限制访问：

- [Supabase Data REST API](https://supabase.com/docs/guides/api)
- [Supabase API 安全指南](https://supabase.com/docs/guides/api/securing-your-api)

### 1. 建表并设置权限

1. 创建 Supabase 项目。
2. 打开 `SQL Editor`。
3. 完整执行 `supabase-survey.sql`。
4. 在 `Table Editor` 中确认 `vowice_survey_responses` 已创建且 RLS 开启。

脚本只授予匿名网页 `INSERT` 权限，没有 `SELECT`、`UPDATE` 或 `DELETE` 权限。不要把 `service_role` 密钥放入网页。

### 2. 配置网页

编辑 `survey-config.js`：

```js
window.VOWICE_SURVEY_CONFIG = {
  mode: "supabase",
  supabaseUrl: "https://你的项目编号.supabase.co",
  supabaseAnonKey: "你的 publishable 或 anon key",
  table: "vowice_survey_responses"
};
```

公开网页中只能使用 Supabase 的 publishable/anon key。数据库安全依赖 RLS 和最小权限设置，不能依赖隐藏前端密钥。

### 3. 部署静态网页

把本文件夹中的 HTML、JS 一起部署到任一静态托管服务，例如 GitHub Pages、Netlify 或 Vercel。部署后请用手机和电脑各提交一次测试答案，再在 Supabase 后台确认：

- 两条数据都已写入。
- 数据中不包含姓名、手机号、邮箱或其他联系字段。
- 公开网页无法读取表内数据。
- 提交失败时，页面会保留待重试答案，不会要求用户重新填写。

## 投放建议

- 首轮收集 30–50 份用于发现方向，不把小样本百分比包装成市场结论。
- 招募渠道至少覆盖：AI 陪伴用户、声音内容偏好者、感兴趣但未长期使用者。
- 同一渠道不要占样本的 70% 以上，并记录渠道来源。
- 作品集展示“假设—证据—决策”，不要只展示饼图和百分比。

## 数据处理边界

- 不尝试通过开放题内容识别受访者身份。
- 不在作品集中放可识别的私密倾诉或完整原话。
- 如果正式公开投放，应补充实际负责主体、联系邮箱、保存期限和退出/删除请求方式。
