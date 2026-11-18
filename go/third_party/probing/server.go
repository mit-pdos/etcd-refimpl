package probing

import (
	"net/http"
	"time"
)

func NewHandler() http.Handler {
	return &httpHealth{}
}

type httpHealth struct {
}

type Health struct {
	OK  bool
	Now time.Time
}

func (h *httpHealth) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	// refimpl: an empty 200 response (the real handler writes the time as JSON)
	w.WriteHeader(200)
}
