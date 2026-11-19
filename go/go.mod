module github.com/mit-pdos/etcd-refimpl/go

go 1.27

require (
	github.com/Masterminds/semver/v3 v3.5.0
	github.com/dustin/go-humanize v1.1.0
	github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus v1.1.0
	github.com/jonboulle/clockwork v0.5.0
	github.com/prometheus/client_golang v1.24.1
	github.com/xiang90/probing v0.0.0-20221125231312-a49e3df8f510
	go.etcd.io/etcd/api/v3 v3.8.0-alpha.0
	go.etcd.io/etcd/client/v3 v3.8.0-alpha.0
	go.etcd.io/etcd/server/v3 v3.8.0-alpha.0
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.71.0
	go.opentelemetry.io/otel/trace v1.47.0
	go.uber.org/zap v1.28.0
	golang.org/x/time v0.16.0
	google.golang.org/grpc v1.84.0
)

require (
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/go-logr/logr v1.4.4 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/golang-jwt/jwt/v5 v5.3.1 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/google/go-cmp v0.7.0 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware/v2 v2.3.4 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.31.0 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/prometheus/client_model v0.6.3 // indirect
	github.com/prometheus/common v0.72.0 // indirect
	github.com/prometheus/procfs v0.21.1 // indirect
	github.com/spf13/pflag v1.0.10 // indirect
	go.etcd.io/bbolt v1.5.0 // indirect
	go.etcd.io/etcd/client/pkg/v3 v3.8.0-alpha.0 // indirect
	go.etcd.io/etcd/pkg/v3 v3.8.0-alpha.0 // indirect
	go.etcd.io/raft/v3 v3.7.0 // indirect
	go.opentelemetry.io/auto/sdk v1.2.1 // indirect
	go.opentelemetry.io/otel v1.47.0 // indirect
	go.opentelemetry.io/otel/log v1.47.0 // indirect
	go.opentelemetry.io/otel/metric v1.47.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	golang.org/x/crypto v0.57.0 // indirect
	golang.org/x/net v0.59.0 // indirect
	golang.org/x/sys v0.48.0 // indirect
	golang.org/x/text v0.42.0 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20260928230214-8a89bd6388cc // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260928230214-8a89bd6388cc // indirect
	google.golang.org/protobuf v1.36.12 // indirect
	k8s.io/utils v0.0.0-20260108192941-914a6e750570 // indirect
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

replace go.etcd.io/etcd/api/v3 => ./third_party/etcd/api

replace go.etcd.io/etcd/client/pkg/v3 => ./third_party/etcd/client/pkg

replace go.etcd.io/etcd/client/v3 => ./third_party/etcd/client/v3

replace go.etcd.io/etcd/pkg/v3 => ./third_party/etcd/pkg

replace go.etcd.io/etcd/server/v3 => ./third_party/etcd/server
