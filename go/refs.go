// Package refs keeps the reference implementations' modules in the build list.
package refs

import (
	_ "github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus"
	_ "github.com/jonboulle/clockwork"
	_ "go.uber.org/zap"
	_ "golang.org/x/time/rate"
)
