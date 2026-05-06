# 🌟 Features of Cordenex v2

Cordenex v2 is packed with features designed to make terminal-based AI engineering fast, safe, and powerful.

---

## 🧠 Intelligence & Memory

### Project Memory (`CORDENEX.md`)
Unlike generic AI chats, Cordenex remembers your project's specific needs. By creating a `CORDENEX.md` file in your root, you can:
-   Enforce coding styles (e.g., "Use functional components for React").
-   Define ignored directories.
-   Specify tech stack versions.
-   Set architectural rules.

### Session Journaling
Cordenex maintains a persistent journal of your session history. If you close your terminal and come back later, the AI can resume with context of what was recently changed and what the next goals were.

### Smart Context Manager
Cordenex automatically manages the context window of your LLM. It selects the most relevant files based on your query and automatically prunes older or less relevant information to keep the conversation focused and cost-effective.

---

## ⚡ Autonomous Engine

### Parallel Tooling
Cordenex can run multiple tools in parallel. This is especially useful for:
-   Bulk file creations.
-   Running tests while simultaneously searching the codebase.
-   Performing multi-file refactors.

### Undo System
Every destructive action (file write, delete, shell command with side effects) can be undone. Use the `/undo` command to step back through your history and restore files to their previous state.

### Multi-Model Support
Cordenex is model-agnostic. You can switch between:
-   **Anthropic**: Claude 3.5 Sonnet (Best for coding).
-   **OpenAI**: GPT-4o.
-   **Google**: Gemini 2.0 Flash/Pro.
-   **Groq**: Llama 3.3 (Extreme speed).
-   **Ollama**: For local, private execution.

---

## 🛡️ Safety & Permissions

Cordenex implements a tiered permission system:

1.  **Read-Only**: Access to read files and list directories. Always allowed.
2.  **Write**: Creating or modifying files. Asks for permission by default (can be toggled with `/permissions`).
3.  **Dangerous**: Shell commands (`rm`, `npm install`, etc.) and system-level changes. Always requires explicit confirmation.

### Guardrails
Cordenex prevents common AI mistakes like:
-   Deleting critical system files.
-   Writing empty files.
-   Creating infinite loops in agentic planning.

---

## 🔌 Advanced Integrations

### MCP (Model Context Protocol)
Connect Cordenex to a growing ecosystem of MCP servers. This allows the AI to:
-   Query your local databases (PostgreSQL, SQLite).
-   Interact with your Google Calendar or Slack.
-   Use specialized documentation search tools.

### Cost Tracking & Budgeting
Monitor your spending in real-time. Cordenex provides:
-   Per-turn cost estimates.
-   Cumulative session spending.
-   Budget alerts when you approach your set limit.
