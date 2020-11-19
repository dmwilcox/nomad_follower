FROM golang:1.14-alpine AS builder
ADD . /build
RUN cd /build && go install -mod=mod

FROM alpine:latest
COPY --from=builder /go/bin/nomad_follower .
CMD ["./nomad_follower"]
