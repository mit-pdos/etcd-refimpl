// Package refs keeps the reference implementations' modules of etcd-grove's k8s-apiserver project
// in the build list (go/ has the etcd project's).
package refs

import (
	_ "k8s.io/component-base/tracing"
	_ "k8s.io/klog/v2"
)
