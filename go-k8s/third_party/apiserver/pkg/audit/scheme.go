/*
Copyright 2017 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// TODO: Delete this file if we generate a clientset.
package audit

import (
	_ "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
	_ "k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/apimachinery/pkg/runtime/serializer"
	_ "k8s.io/apimachinery/pkg/util/runtime"
	_ "k8s.io/apiserver/pkg/apis/audit"
	_ "k8s.io/apiserver/pkg/apis/audit/v1"
)

var Scheme = runtime.NewScheme()
var Codecs = serializer.NewCodecFactory(Scheme)

func init() { // refimpl: empty (registers nothing in the package's Scheme); the real body is commented out below
	//metav1.AddToGroupVersion(Scheme, schema.GroupVersion{Version: "v1"})
	//utilruntime.Must(v1.AddToScheme(Scheme))
	//utilruntime.Must(auditinternal.AddToScheme(Scheme))
	//utilruntime.Must(Scheme.SetVersionPriority(v1.SchemeGroupVersion))
}
