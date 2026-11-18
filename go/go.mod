module github.com/mit-pdos/etcd-refimpl/go

go 1.26.0

require (
	github.com/jonboulle/clockwork v0.5.0
	go.uber.org/zap v1.28.0
	golang.org/x/time v0.16.0
	k8s.io/utils v0.0.0-20260108192941-914a6e750570
)

require go.uber.org/multierr v1.10.0 // indirect

replace go.uber.org/zap => ./third_party/zap

replace github.com/jonboulle/clockwork => ./third_party/clockwork

replace k8s.io/utils => ./third_party/k8s_utils

replace golang.org/x/time => ./third_party/x_time
