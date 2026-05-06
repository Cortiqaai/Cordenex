# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Cordenex Makefile
# Built by Cortiqa
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

BINARY_NAME  := cordenex
MODULE       := github.com/cortiqa/cordenex
MAIN_PKG     := ./cmd/cordenex

# Version info
VERSION      := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
COMMIT       := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
BUILD_DATE   := $(shell date -u '+%Y-%m-%dT%H:%M:%SZ')

# Go settings
GO           := go
GOFLAGS      :=
LDFLAGS      := -s -w \
	-X '$(MODULE)/internal/app.Version=$(VERSION)' \
	-X '$(MODULE)/internal/app.Commit=$(COMMIT)' \
	-X '$(MODULE)/internal/app.BuildDate=$(BUILD_DATE)'

# Directories
BUILD_DIR    := build
DIST_DIR     := dist
COVER_DIR    := coverage

# Tools
GOLINT       := golangci-lint
GOTEST       := $(GO) test
GOFMT        := gofmt
GOIMPORTS    := goimports

# Colors
GREEN        := \033[32m
YELLOW       := \033[33m
CYAN         := \033[36m
RESET        := \033[0m

.DEFAULT_GOAL := help

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# BUILD
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: build
build: ## Build the binary
	@echo "$(CYAN)► Building $(BINARY_NAME) $(VERSION)...$(RESET)"
	@mkdir -p $(BUILD_DIR)
	$(GO) build $(GOFLAGS) -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY_NAME) $(MAIN_PKG)
	@echo "$(GREEN)✓ Built: $(BUILD_DIR)/$(BINARY_NAME)$(RESET)"

.PHONY: build-all
build-all: ## Build for all platforms
	@echo "$(CYAN)► Building for all platforms...$(RESET)"
	@mkdir -p $(BUILD_DIR)
	GOOS=linux   GOARCH=amd64 $(GO) build -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY_NAME)-linux-amd64     $(MAIN_PKG)
	GOOS=linux   GOARCH=arm64 $(GO) build -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY_NAME)-linux-arm64     $(MAIN_PKG)
	GOOS=darwin  GOARCH=amd64 $(GO) build -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64    $(MAIN_PKG)
	GOOS=darwin  GOARCH=arm64 $(GO) build -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY_NAME)-darwin-arm64    $(MAIN_PKG)
	GOOS=windows GOARCH=amd64 $(GO) build -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY_NAME)-windows-amd64.exe $(MAIN_PKG)
	@echo "$(GREEN)✓ All platforms built$(RESET)"

.PHONY: install
install: build ## Build and install to $GOPATH/bin
	@echo "$(CYAN)► Installing $(BINARY_NAME)...$(RESET)"
	@cp $(BUILD_DIR)/$(BINARY_NAME) $(GOPATH)/bin/$(BINARY_NAME) 2>/dev/null || \
		cp $(BUILD_DIR)/$(BINARY_NAME) $(HOME)/go/bin/$(BINARY_NAME)
	@echo "$(GREEN)✓ Installed to GOPATH/bin$(RESET)"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# DEVELOPMENT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: dev
dev: ## Run with race detector (development mode)
	@echo "$(CYAN)► Running in dev mode with race detector...$(RESET)"
	$(GO) run -race -ldflags "$(LDFLAGS)" $(MAIN_PKG) $(ARGS)

.PHONY: dev-tui
dev-tui: ## Run TUI in development mode
	@echo "$(CYAN)► Running TUI in dev mode...$(RESET)"
	$(GO) run -race -ldflags "$(LDFLAGS)" $(MAIN_PKG) --tui $(ARGS)

.PHONY: run
run: build ## Build and run
	./$(BUILD_DIR)/$(BINARY_NAME) $(ARGS)

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# TESTING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: test
test: ## Run all tests
	@echo "$(CYAN)► Running tests...$(RESET)"
	$(GOTEST) -v -count=1 -timeout 120s ./...
	@echo "$(GREEN)✓ All tests passed$(RESET)"

.PHONY: test-short
test-short: ## Run tests (skip long-running)
	@echo "$(CYAN)► Running short tests...$(RESET)"
	$(GOTEST) -short -count=1 -timeout 60s ./...

.PHONY: test-race
test-race: ## Run tests with race detector
	@echo "$(CYAN)► Running tests with race detector...$(RESET)"
	$(GOTEST) -race -count=1 -timeout 180s ./...

.PHONY: test-coverage
test-coverage: ## Run tests with coverage report
	@echo "$(CYAN)► Running tests with coverage...$(RESET)"
	@mkdir -p $(COVER_DIR)
	$(GOTEST) -v -coverprofile=$(COVER_DIR)/coverage.out -covermode=atomic ./...
	$(GO) tool cover -html=$(COVER_DIR)/coverage.out -o $(COVER_DIR)/coverage.html
	$(GO) tool cover -func=$(COVER_DIR)/coverage.out | tail -1
	@echo "$(GREEN)✓ Coverage report: $(COVER_DIR)/coverage.html$(RESET)"

.PHONY: test-e2e
test-e2e: build ## Run end-to-end tests
	@echo "$(CYAN)► Running e2e tests...$(RESET)"
	CORDENEX_BINARY=$(BUILD_DIR)/$(BINARY_NAME) $(GOTEST) -v -tags=e2e -timeout 300s ./test/e2e/...

.PHONY: test-integration
test-integration: ## Run integration tests
	@echo "$(CYAN)► Running integration tests...$(RESET)"
	$(GOTEST) -v -tags=integration -timeout 300s ./test/integration/...

.PHONY: bench
bench: ## Run benchmarks
	@echo "$(CYAN)► Running benchmarks...$(RESET)"
	$(GOTEST) -bench=. -benchmem -run=^$ ./...

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# QUALITY
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: lint
lint: ## Run linter
	@echo "$(CYAN)► Running linter...$(RESET)"
	$(GOLINT) run ./...
	@echo "$(GREEN)✓ Lint passed$(RESET)"

.PHONY: lint-fix
lint-fix: ## Run linter and fix issues
	@echo "$(CYAN)► Running linter with auto-fix...$(RESET)"
	$(GOLINT) run --fix ./...

.PHONY: fmt
fmt: ## Format code
	@echo "$(CYAN)► Formatting code...$(RESET)"
	$(GOFMT) -s -w .
	$(GOIMPORTS) -w . 2>/dev/null || true
	@echo "$(GREEN)✓ Code formatted$(RESET)"

.PHONY: vet
vet: ## Run go vet
	@echo "$(CYAN)► Running go vet...$(RESET)"
	$(GO) vet ./...

.PHONY: check
check: fmt vet lint test ## Run all checks (format, vet, lint, test)
	@echo "$(GREEN)✓ All checks passed$(RESET)"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# DEPENDENCIES
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: deps
deps: ## Tidy and download dependencies
	@echo "$(CYAN)► Tidying dependencies...$(RESET)"
	$(GO) mod tidy
	$(GO) mod download
	$(GO) mod verify
	@echo "$(GREEN)✓ Dependencies ready$(RESET)"

.PHONY: deps-update
deps-update: ## Update all dependencies
	@echo "$(CYAN)► Updating dependencies...$(RESET)"
	$(GO) get -u ./...
	$(GO) mod tidy
	@echo "$(GREEN)✓ Dependencies updated$(RESET)"

.PHONY: deps-graph
deps-graph: ## Show dependency graph
	$(GO) mod graph | head -50

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# RELEASE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: release
release: ## Create release with goreleaser
	@echo "$(CYAN)► Creating release...$(RESET)"
	goreleaser release --clean
	@echo "$(GREEN)✓ Release created$(RESET)"

.PHONY: release-dry
release-dry: ## Dry-run release (no publish)
	@echo "$(CYAN)► Dry-run release...$(RESET)"
	goreleaser release --snapshot --clean

.PHONY: release-check
release-check: ## Validate goreleaser config
	goreleaser check

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# DOCKER
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: docker-build
docker-build: ## Build Docker image
	@echo "$(CYAN)► Building Docker image...$(RESET)"
	docker build -t cortiqa/cordenex:$(VERSION) -t cortiqa/cordenex:latest .
	@echo "$(GREEN)✓ Docker image built$(RESET)"

.PHONY: docker-run
docker-run: ## Run in Docker
	docker run --rm -it -v $(PWD):/workspace cortiqa/cordenex:latest $(ARGS)

.PHONY: docker-push
docker-push: ## Push Docker image
	docker push cortiqa/cordenex:$(VERSION)
	docker push cortiqa/cordenex:latest

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PROTOBUF (future)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: proto
proto: ## Generate protobuf code (future)
	@echo "$(YELLOW)► Protobuf generation not yet configured$(RESET)"
	@echo "  Add .proto files to api/proto/ when ready"
	# protoc --go_out=. --go-grpc_out=. api/proto/*.proto

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CLEANUP
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: clean
clean: ## Remove build artifacts
	@echo "$(CYAN)► Cleaning...$(RESET)"
	rm -rf $(BUILD_DIR) $(DIST_DIR) $(COVER_DIR)
	$(GO) clean -cache -testcache
	@echo "$(GREEN)✓ Clean$(RESET)"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# HELP
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: help
help: ## Show this help
	@echo ""
	@echo "$(CYAN)Cordenex — AI-powered coding assistant$(RESET)"
	@echo "$(CYAN)Built by Cortiqa$(RESET)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(RESET) %s\n", $$1, $$2}'
	@echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# INFO
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

.PHONY: version
version: ## Print version info
	@echo "Version:    $(VERSION)"
	@echo "Commit:     $(COMMIT)"
	@echo "Build Date: $(BUILD_DATE)"
	@echo "Go:         $(shell $(GO) version)"
