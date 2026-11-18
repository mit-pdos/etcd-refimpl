// Package refs keeps the reference implementations' modules of etcd-grove's k8s-apiserver project
// in the build list (go/ has the etcd project's).
package refs

import (
	_ "k8s.io/api/apps/v1"
	_ "k8s.io/api/core/v1"
	_ "k8s.io/apimachinery/pkg/api/errors"
	_ "k8s.io/apimachinery/pkg/apis/meta/v1"
	_ "k8s.io/apimachinery/pkg/labels"
	_ "k8s.io/apiserver/pkg/storage/etcd3/metrics"
	_ "k8s.io/component-base/tracing"
	_ "k8s.io/klog/v2"
	_ "k8s.io/utils/trace"
)
