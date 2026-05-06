# 🚀 Getting Started with Cordenex v2

This guide will help you set up Cordenex for the first time and start your first autonomous engineering session.

## 🛠 Prerequisites

-   **Go 1.22+** (if building from source)
-   **Node.js & NPM** (if installing via NPM)
-   **An API Key** from one of the following providers:
    -   [Anthropic](https://console.anthropic.com/) (Recommended: Claude 3.5 Sonnet)
    -   [Groq](https://console.groq.com/) (Recommended: Llama 3.3 70B for Speed)
    -   [Google AI](https://aistudio.google.com/) (Gemini 2.0 Flash)
    -   [OpenAI](https://platform.openai.com/) (GPT-4o)

---

## 📥 Installation

### Method 1: NPM (Global)
```bash
npm install -g @cortiqa/cordenex
```

### Method 2: From Source (Binary)
```bash
git clone https://github.com/cortiqa/cordenex.git
cd cordenex
go build -o cordenex ./cmd/cordenex
# Move to your path
mv cordenex /usr/local/bin/
```

---

## 🔑 Initial Configuration

Before running, you need to tell Cordenex which AI to use.

```bash
# Example: Using Anthropic
cordenex config set providers.anthropic.api_key your_key_here
cordenex switch claude-3-5-sonnet

# Or using Groq (Free/Fast)
cordenex config set providers.groq.api_key your_key_here
cordenex switch llama-3.3-70b-versatile
```

---

## 💻 Your First Turn

1.  Navigate to a project directory:
    ```bash
    cd my-react-app
    ```

2.  Initialize Project Memory:
    ```bash
    cordenex init
    ```
    *This creates a `CORDENEX.md` where you can tell the AI about your project's coding style.*

3.  Open the Chat:
    ```bash
    cordenex chat
    ```

4.  Ask for a task:
    > "Refactor the Navbar component to use TailwindCSS and add a mobile responsive menu."

5.  Observe the AI:
    -   It will **Think** and analyze the existing component.
    -   It will **Request Permission** to edit files.
    -   It will **Heal** itself if it makes a syntax mistake.

---

## ❓ Common Issues

### 429 Rate Limit
If you are using free-tier Groq or Anthropic keys, you might hit rate limits. Add a paid key via `cordenex set providers.<name>.api_key <key>` to resolve this.

### Permission Denied
Cordenex respects directory boundaries. If it tries to write outside the project root, it will be blocked. Use the `--cwd` flag if you want to explicitly set the root.

---

[Back to Home](../README.md)
