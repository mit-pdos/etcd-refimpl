module github.com/mit-pdos/etcd-refimpl/go

go 1.26.0

require (
	github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus v1.1.0
	github.com/jonboulle/clockwork v0.5.0
	github.com/prometheus/client_golang v1.24.1
	github.com/xiang90/probing v0.0.0-20221125231312-a49e3df8f510
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.71.0
	go.opentelemetry.io/otel/trace v1.47.0
	go.uber.org/zap v1.28.0
	golang.org/x/time v0.16.0
	google.golang.org/grpc v1.84.0
)

require (
	github.com/Masterminds/semver/v3 v3.5.0
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/dustin/go-humanize v1.1.0
	github.com/go-logr/logr v1.4.4 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware/v2 v2.3.4 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/prometheus/client_model v0.6.2 // indirect
	github.com/prometheus/common v0.70.1 // indirect
	github.com/prometheus/procfs v0.21.1 // indirect
	go.opentelemetry.io/auto/sdk v1.2.1 // indirect
	go.opentelemetry.io/otel v1.47.0 // indirect
	go.opentelemetry.io/otel/log v1.47.0 // indirect
	go.opentelemetry.io/otel/metric v1.47.0 // indirect
	go.uber.org/multierr v1.10.0 // indirect
	golang.org/x/net v0.58.0 // indirect
	golang.org/x/sys v0.47.0 // indirect
	golang.org/x/text v0.41.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260825221802-da73d73af1c5 // indirect
	google.golang.org/protobuf v1.36.12 // indirect
)

replace go.uber.org/zap => ./third_party/zap

replace github.com/jonboulle/clockwork => ./third_party/clockwork

replace golang.org/x/time => ./third_party/x_time

replace github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus => ./third_party/grpc_prom_provider

replace go.opentelemetry.io/otel/trace => ./third_party/otel_trace

replace github.com/xiang90/probing => ./third_party/probing

replace github.com/prometheus/client_golang => ./third_party/client_golang

replace google.golang.org/grpc => ./third_party/grpc

replace go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc => ./third_party/otelgrpc

replace github.com/Masterminds/semver/v3 => ./third_party/semver

replace github.com/dustin/go-humanize => ./third_party/go_humanize
