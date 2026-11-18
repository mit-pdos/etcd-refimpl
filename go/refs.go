// Package refs keeps the reference implementations' modules in the build list.
package refs

import (
	_ "github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus"
	_ "github.com/jonboulle/clockwork"
	_ "github.com/prometheus/client_golang/prometheus"
	_ "github.com/xiang90/probing"
	_ "go.opentelemetry.io/otel/trace"
	_ "go.uber.org/zap"
	_ "golang.org/x/time/rate"
	_ "google.golang.org/grpc/health"
	_ "google.golang.org/grpc/health/grpc_health_v1"
	_ "google.golang.org/grpc/metadata"
	_ "google.golang.org/grpc/status"
)
