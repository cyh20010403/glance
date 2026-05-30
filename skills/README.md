# 可用 Skills

本项目已安装的插件和可调用的技能（skills）列表。

## 内置 Skills

| 命令 | 名称 | 说明 |
|------|------|------|
| `/deep-research` | 深度研究 | 多源搜索、交叉验证、生成带引用报告 |
| `/code-review` | 代码审查 | 审查当前 diff 的正确性、bug、可优化点 |
| `/security-review` | 安全审查 | 对当前分支改动做安全审查 |
| `/verify` | 验证 | 运行应用并确认改动是否按预期工作 |
| `/simplify` | 简化代码 | 审查代码并应用复用/简化/优化建议 |
| `/loop` | 循环任务 | 设置定时重复任务（e.g. `/loop 5m /command`） |
| `/claude-api` | Claude API | 构建/调试 Claude API / Anthropic SDK 应用 |
| `/run` | 运行项目 | 启动项目查看效果 |
| `/init` | 初始化 | 初始化 CLAUDE.md 项目文档 |
| `/review` | 审查 PR | 审查 Pull Request |
| `/update-config` | 配置管理 | 修改 settings.json（权限、环境变量、钩子等） |
| `/keybindings-help` | 快捷键 | 自定义键盘快捷键 |
| `/fewer-permission-prompts` | 减少权限提示 | 扫描常用只读命令并添加白名单 |
| `/frontend-design` | 前端设计 | 创建高质量前端界面（插件安装） |

## 插件（Plugins）

- **frontend-design** — 生成生产级前端界面

## 调用方式

在对话中直接输入 `/<skill-name>` 即可调用，例如：

```
/frontend-design 帮我设计一个登录页面
/code-review 审查一下当前的改动
```

也可以直接在对话中说任务，我会自动匹配并使用合适的 skill。
