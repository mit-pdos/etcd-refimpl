module github.com/mit-pdos/etcd-refimpl/go

go 1.24

require (
	github.com/jonboulle/clockwork v0.5.0
	go.uber.org/zap v1.28.0
)

require go.uber.org/multierr v1.10.0 // indirect

replace go.uber.org/zap => ./third_party/zap

replace github.com/jonboulle/clockwork => ./third_party/clockwork
