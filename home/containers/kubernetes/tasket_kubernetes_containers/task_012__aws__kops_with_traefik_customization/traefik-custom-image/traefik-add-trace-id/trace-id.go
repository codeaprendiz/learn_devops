package traefik_add_trace_id

import (
	"context"
	"fmt"
	"log"
	"net/http"
)

const defaultTraceID = "X-Trace-Id"

// Config the plugin configuration.
type Config struct {
	HeaderPrefix string `json:"headerPrefix"`
	HeaderName   string `json:"headerName"`
	Verbose      bool   `json:"verbose"`
}

// CreateConfig creates the default plugin configuration.
func CreateConfig() *Config {
	return &Config{
		HeaderPrefix: "",
		HeaderName:   defaultTraceID,
	}
}

// TraceIDHeader header if it's missing
type TraceIDHeader struct {
	headerName   string
	headerPrefix string
	name         string
	next         http.Handler
	verbose      bool
}

// New created a new TraceIDHeader plugin.
func New(ctx context.Context, next http.Handler, config *Config, name string) (http.Handler, error) {
	tIDHdr := &TraceIDHeader{
		next:    next,
		name:    name,
		verbose: config.Verbose,
	}

	if config == nil {
		return nil, fmt.Errorf("config can not be nil")
	}

	if config.HeaderName == "" {
		tIDHdr.headerName = defaultTraceID
	} else {
		tIDHdr.headerName = config.HeaderName
	}

	tIDHdr.headerPrefix = config.HeaderPrefix

	return tIDHdr, nil

}

func (t *TraceIDHeader) ServeHTTP(rw http.ResponseWriter, req *http.Request) {
	headerArr := req.Header[t.headerName]
	randomUUID := fmt.Sprintf("%s%s", t.headerPrefix, newUUID().String())
	if len(headerArr) == 0 {
		req.Header.Set(t.headerName, randomUUID)
                rw.Header().Set(t.headerName, randomUUID)
	} else if headerArr[0] == "" {
		req.Header[t.headerName][0] = randomUUID
                rw.Header().Set(req.Header[t.headerName][0], randomUUID)
	} else {
		existingUUID := req.Header.Get(t.headerName)
		rw.Header().Set(t.headerName, existingUUID)
        }

	if t.verbose {
		log.Println(req.Header[t.headerName][0])
	}

	t.next.ServeHTTP(rw, req)
}
