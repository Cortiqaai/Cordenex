# ⚙️ Configuration Guide

Cordenex stores its configuration in `~/.cordenex/config.yaml`. You can modify this file directly or use the `cordenex set` command.

## 🔑 AI Providers

### Anthropic (Best Quality)
```bash
cordenex config set providers.anthropic.enabled true
cordenex config set providers.anthropic.api_key sk-ant-...
cordenex switch claude-3-5-sonnet
```

### Groq (Extreme Speed)
```bash
cordenex config set providers.groq.enabled true
cordenex config set providers.groq.api_key gsk_...
cordenex switch llama-3.3-70b-versatile
```

### Google Gemini
```bash
cordenex config set providers.gemini.enabled true
cordenex config set providers.gemini.api_key ai-...
cordenex switch gemini-2.0-flash
```

### Ollama (Local/Private)
Requires [Ollama](https://ollama.com/) running locally.
```bash
cordenex config set providers.ollama.enabled true
cordenex config set providers.ollama.base_url http://localhost:11434
cordenex switch llama3.2
```

---

## 🎨 UI & Aesthetics

| Key | Values | Description |
| :--- | :--- | :--- |
| `general.theme` | `dark`, `light` | Terminal UI theme. |
| `general.verbose` | `true`, `false` | Enable debug logging. |
| `general.interactive` | `true`, `false` | Disable for headless automation. |

```bash
# Example: Switch to light theme
cordenex config set general.theme light
```

---

## 💾 Session & Logging

Cordenex logs all AI interactions for self-improvement and debugging.

-   **Logs**: stored in `~/.cordenex/logs/`
-   **Journal**: stored in `~/.cordenex/journal.json`

To disable logging:
```bash
cordenex config set general.log_file ""
```

---

[Back to Home](../README.md)
