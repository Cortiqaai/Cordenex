# 🤖 Autonomous Agents in Cordenex v2

Cordenex v2 utilizes a sophisticated multi-agent architecture to handle complex software engineering tasks. Instead of a single monolithic prompt, Cordenex breaks tasks down into specialized roles.

---

## 🏛️ The Agent Hierarchy

When you issue a complex command (e.g., "Implement a new authentication system"), the **Orchestrator** activates the **Agent Pipeline**, which cycles through several specialized agents:

### 1. 📅 The Planner
- **Role**: Architect & Project Manager.
- **Task**: Analyzes the codebase, identifies dependencies, and breaks the user's request into a set of sequential or parallel **Sub-Tasks**.
- **Output**: A structured execution plan that the user can review and approve.

### 2. 💻 The Coder
- **Role**: Lead Software Engineer.
- **Task**: Executes the plan by writing code, creating files, and refactoring existing logic.
- **Tools**: `write_file`, `replace_content`, `create_directory`, etc.

### 3. 🧪 The Tester
- **Role**: QA Engineer.
- **Task**: Identifies where tests are needed and writes unit or integration tests for the new code.
- **Logic**: It specifically looks for `_test.go` (in Go) or similar patterns to ensure code quality.

### 4. 🔍 The Reviewer
- **Role**: Security & Quality Auditor.
- **Task**: Reviews the changes made by the Coder. It checks for common bugs, security vulnerabilities, and adherence to the rules in `CORDENEX.md`.
- **Feedback**: If issues are found, it sends the task back to the Coder with specific feedback.

### 🐞 The Debugger (Reactive)
- **Role**: Problem Solver.
- **Task**: Automatically activates if a tool call fails or a build command returns an error.
- **Logic**: It analyzes the stack trace or error log and provides a fix to the Coder.

---

## ⚡ Parallel Execution

Cordenex agents are designed for speed. When the **Planner** identifies independent tasks, the **Engine** executes them in parallel.

**Example**:
- Agent 1: Creating `auth_service.go`
- Agent 2: Creating `user_model.go`
- Agent 3: Updating `main.go` routes

All three can happen simultaneously, reducing the total wait time by up to 60%.

---

## 🔄 Self-Healing Loops

The core of Cordenex's autonomy is its ability to "self-heal". If a task fails:
1.  **Detection**: The tool returns an error (e.g., "compiler error on line 42").
2.  **Analysis**: The **Debugger** agent identifies the root cause.
3.  **Correction**: The **Coder** receives the fix and reapplies the change.
4.  **Verification**: The task is re-run to ensure the fix worked.

This loop continues until the task is successful or the maximum iteration limit is reached.
