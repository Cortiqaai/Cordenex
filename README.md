# 🤖 Cordenex v2 — Autonomous AI Software Engineer

[![Version](https://img.shields.io/badge/version-0.2.1--beta-blue.svg)](https://github.com/cortiqa/cordenex)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Built by Cortiqa](https://img.shields.io/badge/built%20by-Cortiqa-purple.svg)](https://cortiqa.vercel.app)
[![Documentation](https://img.shields.io/badge/docs-comprehensive-orange.svg)](docs/INDEX.md)

**Cordenex** is a high-performance, autonomous AI coding assistant designed for the terminal. Inspired by the reasoning capabilities of **Claude Code** and the power of multi-agent workflows, Cordenex brings state-of-the-art engineering capabilities to your local environment.

> "Stop chatting with code. Start engineering with it."

---

![Cordenex Terminal Mockup](cordenex_terminal_mockup_1777606305263.png)

## 🔥 Key Pillars of Cordenex v2

### 1. 🧠 Project Intelligence & Memory
*   **`CORDENEX.md` (Project Memory)**: Define project-specific rules and conventions that persist across sessions.
*   **Auto-Context Detection**: Automatic analysis of languages, frameworks, and dependencies for hyper-relevant suggestions.
*   **Session Journaling**: Maintains continuity by remembering past accomplishments and next steps.

### 2. ⚡ Autonomous Multi-Agent Engine
*   **Parallel Execution**: Runs multiple file operations, shell commands, and searches concurrently to maximize speed.
*   **Self-Healing Workflows**: Automatically diagnoses tool failures, build errors, and bugs to fix itself.
*   **Role-Based Agents**: Specialized agents for Planning, Coding, Testing, and Reviewing.

### 3. 🛡️ Safety & Permission Tiers
*   **Tiered Permissions**: Granular control over Read, Write, and Dangerous (Shell/Delete) operations.
*   **Smart Approvals**: Batch-approve parallel actions to maintain security without friction.

### 4. 🔌 Extensible Ecosystem
*   **MCP Support**: Connect to Model Context Protocol servers for database, GitHub, and Slack integrations.
*   **Universal Providers**: Supports Anthropic, OpenAI, Google Gemini, Groq, and Ollama (Offline).

---

## 🚀 Quick Start

### 1. Install via NPM
```bash
npm install -g @cortiqa/cordenex
```

### 2. Setup your Provider
```bash
# Set your API Key (e.g., Anthropic)
cordenex config set providers.anthropic.api_key YOUR_KEY

# Launch the interactive chat
cordenex chat
```

---

## 💻 Commands at a Glance

| Command | Description |
| :--- | :--- |
| `cordenex chat` | Enter the main interactive engineering session. |
| `cordenex ask "task"` | Execute a one-shot autonomous task. |
| `cordenex init` | Create a `CORDENEX.md` for your project. |
| `cordenex config list` | View all current settings. |
| `cordenex models` | List available AI models. |

### ⚡ Interactive Slash Commands
*   **`/undo`**: Revert the last file change set.
*   **`/memory`**: View/edit project rules.
*   **`/changes`**: Summary of files modified.
*   **`/mcp`**: List active MCP tools and servers.

---

## 📚 Documentation

For detailed guides, please explore our full documentation suite:

-   **[Getting Started](docs/GETTING_STARTED.md)**
-   **[Architecture Deep Dive](ARCHITECTURE.md)**
-   **[Autonomous Agents](docs/AGENTS.md)**
-   **[Feature Breakdown](docs/FEATURES.md)**
-   **[MCP Integration](docs/MCP.md)**
-   **[Development Guide](docs/DEVELOPMENT.md)**

---

## 🤝 Contributing

We love contributions! Whether it's adding a new provider, fixing a bug, or improving documentation, check out our [Development Guide](docs/DEVELOPMENT.md) to get started.

---

Built with ❤️ by **Cortiqa**
[Website](https://cortiqa.vercel.app) | [Twitter](https://twitter.com/cortiqa_ai) | [Discord](https://discord.gg/cortiqa)
