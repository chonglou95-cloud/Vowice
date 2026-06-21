# 竞品 App Store 评论原始数据说明

> 抓取日期：2026-06-20
> 数据来源：Apple iTunes RSS API（公开接口，无需登录）

## 抓取方式

通过苹果官方 RSS API，分两个排序各抓取最多 500 条，合并去重：

- `sortBy=mostRecent`：最新评论（按时间倒序）
- `sortBy=mostHelpful`：高赞评论（按有用票数倒序）

## 原始数据文件

两个 CSV 文件已下载至你的 **Mac Downloads 文件夹**：

| 文件名 | 评论数 | 说明 |
|---|---|---|
| `星野_App Store评论_863条.csv` | 863 条 | mostRecent + mostHelpful 去重合并 |
| `筑梦岛_App Store评论_673条.csv` | 673 条 | mostRecent + mostHelpful 去重合并 |

CSV 字段：`rating`（1-5分）、`date`（日期）、`title`（标题）、`content`（评论内容）

## 关于 Glow（MiniMax）

经多区搜索确认：**Glow 目前已全区下架**，在中国区、美区、港区、台区、新加坡区、日本区均无法找到。

MiniMax 在国区的现存 C 端产品为：
- **星野**（AI 陪伴 / 角色扮演）→ 本次竞品分析主要对象
- **海螺 AI**（视频创作，与陪伴无关）

## 苹果 API 限制说明

苹果公开 RSS 接口最多只提供 **每款 app 最近 1000 条评论**（两种排序各 500 条）。如需更多历史数据，需使用 Sensor Tower / AppFollow 等付费服务。
