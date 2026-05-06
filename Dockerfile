# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Cordenex Dockerfile
# Multi-stage build — minimal final image
# Built by Cortiqa
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# ── Stage 1: Build ──────────────────────────────
FROM golang:1.23-alpine AS builder

# Install build dependencies
RUN apk add --no-cache \
    git \
    ca-certificates \
    tzdata \
    make

# Set working directory
WORKDIR /src

# Copy go mod files first (better layer caching)
COPY go.mod go.sum ./
RUN go mod download && go mod verify

# Copy source code
COPY . .

# Build arguments for version info
ARG VERSION=dev
ARG COMMIT=unknown
ARG BUILD_DATE=unknown

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-s -w \
        -X 'github.com/cortiqa/cordenex/internal/app.Version=${VERSION}' \
        -X 'github.com/cortiqa/cordenex/internal/app.Commit=${COMMIT}' \
        -X 'github.com/cortiqa/cordenex/internal/app.BuildDate=${BUILD_DATE}'" \
    -o /bin/cordenex \
    ./cmd/cordenex

# ── Stage 2: Final ─────────────────────────────
FROM alpine:3.20

# Install runtime dependencies
RUN apk add --no-cache \
    ca-certificates \
    git \
    openssh-client \
    tzdata \
    && rm -rf /var/cache/apk/*

# Create non-root user
RUN addgroup -g 1000 cordenex && \
    adduser -u 1000 -G cordenex -s /bin/sh -D cordenex

# Create config and workspace directories
RUN mkdir -p /home/cordenex/.config/cordenex \
             /workspace && \
    chown -R cordenex:cordenex /home/cordenex /workspace

# Copy binary from builder
COPY --from=builder /bin/cordenex /usr/local/bin/cordenex

# Copy timezone data
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Switch to non-root user
USER cordenex

# Set working directory
WORKDIR /workspace

# Set environment
ENV HOME=/home/cordenex \
    XDG_CONFIG_HOME=/home/cordenex/.config \
    TERM=xterm-256color

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD cordenex version || exit 1

# Default entrypoint
ENTRYPOINT ["cordenex"]

# Default command (show help)
CMD ["--help"]
