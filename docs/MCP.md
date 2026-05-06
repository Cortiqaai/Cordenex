# 🔌 Model Context Protocol (MCP) in Cordenex

Cordenex v2 supports the **Model Context Protocol (MCP)**, allowing the AI to interact with external tools, databases, and services seamlessly.

---

## 🛠️ What is MCP?

MCP is an open standard that allows developers to build "servers" that expose tools and data to AI models. By connecting Cordenex to an MCP server, you give the AI "superpowers" beyond just coding and shell access.

---

## ⚙️ Configuration

To add an MCP server, update your `cordenex.yaml` configuration file. You can find this file in your home directory under `~/.cordenex/config.yaml` or use the CLI:

### Adding a Server via CLI
```bash
cordenex config set mcp_servers.my_server.command "npx"
cordenex config set mcp_servers.my_server.args ["-y", "@modelcontextprotocol/server-postgres", "postgresql://localhost/mydb"]
```

### Manual YAML Configuration
```yaml
mcp_servers:
  postgres:
    command: "npx"
    args:
      - "-y"
      - "@modelcontextprotocol/server-postgres"
      - "postgresql://localhost/mydb"
  github:
    command: "npx"
    args:
      - "-y"
      - "@modelcontextprotocol/server-github"
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "your_token_here"
```

---

## 🚀 Usage

Once configured, Cordenex automatically connects to the MCP servers on startup.

1.  **Tool Discovery**: Cordenex fetches all available tools from the connected servers.
2.  **Execution**: When you ask a question like "What are the latest issues in the cordenex repo?", the AI will realize it can use the `github` MCP tool to fetch the data.
3.  **Context**: Data retrieved via MCP is injected into the context window, allowing the AI to reason about it alongside your code.

---

## 📂 Popular MCP Servers to Try

- **[Postgres](https://github.com/modelcontextprotocol/servers/tree/main/src/postgres)**: Query and analyze your databases.
- **[GitHub](https://github.com/modelcontextprotocol/servers/tree/main/src/github)**: Manage issues, PRs, and repository metadata.
- **[Slack](https://github.com/modelcontextprotocol/servers/tree/main/src/slack)**: Send messages and read channel history.
- **[Google Maps](https://github.com/modelcontextprotocol/servers/tree/main/src/google-maps)**: Fetch location data and coordinates.

For a full list of community-built servers, visit the [MCP Gallery](https://mcp.dev).
