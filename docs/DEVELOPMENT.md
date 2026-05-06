# 🛠️ Development & Contributing Guide

Thank you for your interest in contributing to Cordenex v2! This guide will help you set up your environment and understand the codebase.

---

## 🏗️ Project Structure

- **`cmd/cordenex/`**: Entry point for the CLI.
- **`internal/app/`**: Application bootstrapping and subsystem initialization.
- **`internal/core/`**: Core logic (Engine, Orchestrator, Memory, Journal).
- **`internal/cli/`**: Cobra command definitions and TUI logic.
- **`internal/providers/`**: LLM provider implementations (OpenAI, Anthropic, etc.).
- **`internal/tools/`**: Filesystem, Shell, and Search tool implementations.
- **`internal/utils/`**: Shared utilities (logging, colors, token counting).
- **`pkg/`**: Publicly accessible types and API clients.

---

## 🚀 Setting Up for Development

### Prerequisites
- **Go**: 1.21 or higher.
- **Node.js/NPM**: For building the wrapper (optional).
- **Make**: For running build tasks (optional but recommended).

### 1. Clone the Repository
```bash
git clone https://github.com/cortiqa/cordenex.git
cd cordenex
```

### 2. Build from Source
```bash
# Build to the bin/ directory
go build -o bin/cordenex ./cmd/cordenex

# Or use the Makefile
make build
```

### 3. Run Tests
```bash
# Run all tests
go test ./...

# Run tests for a specific package
go test ./internal/core/...
```

---

## 🧪 Testing Guidelines

- **Unit Tests**: Place tests in the same directory as the code (e.g., `engine_test.go`).
- **Mocking**: Use the interfaces defined in `internal/providers/provider.go` to mock LLM responses.
- **Golden Files**: For CLI output testing, use the `testdata` pattern.

---

## 🤝 Contribution Workflow

1.  **Fork** the repository.
2.  **Create a branch** for your feature or bugfix: `git checkout -b feature/cool-new-thing`.
3.  **Commit** your changes with clear, descriptive messages.
4.  **Push** to your fork and **open a Pull Request**.

### PR Requirements
- All tests must pass.
- Code should follow standard Go formatting (`go fmt`).
- New features should include documentation updates.
- If adding a new provider, ensure it implements the full `Provider` interface.

---

## 📜 License
Cordenex is released under the **MIT License**. By contributing, you agree that your contributions will be licensed under the same terms.
