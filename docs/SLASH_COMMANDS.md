# ⚡ Slash Commands Reference

Slash commands are special instructions you can type directly into the `cordenex chat` input to control the engine without using natural language.

## 🔄 History & Changes

### `/undo`
**Action**: Reverts the very last set of file modifications made by the AI.
-   Cordenex keeps a byte-level backup of files before editing.
-   Useful if the AI introduces a regression or misinterprets a prompt.

### `/changes`
**Action**: Displays a list of all files created, modified, or read during the **current session**.
-   Shows line counts and action icons (✨, 📝, 👁️).

### `/clear`
**Action**: Wipes the current conversation history.
-   Useful for starting a fresh task without previous context interference.
-   Note: This does not affect the Journal or `CORDENEX.md`.

---

## 🧠 Memory & Context

### `/init`
**Action**: Initializes a `CORDENEX.md` file in the current directory.
-   Populates it with a boilerplate for your project.

### `/memory`
**Action**: Displays the status of your Project Memory.
-   Tells you if `CORDENEX.md` was found and what rules are currently active.

---

## 🛡️ Permission Control

### `/permissions`
**Usage**: `/permissions [status | allow-write | allow-all | reset]`

| Sub-command | Effect |
| :--- | :--- |
| `status` | Shows current level and stats. |
| `allow-write`| AI can edit/create files without asking. Shell still asks. |
| `allow-all` | AI can do everything (including shell) without asking. **(⚠ Use with caution)** |
| `reset` | Back to default (ask for everything except reading). |

---

## 🤖 Model Management

### `/model <id>`
**Action**: Quickly switches the AI model without exiting the chat.
-   Example: `/model gpt-4o`

---

[Back to Home](../README.md)
