FROM golang:latest as builder

RUN mkdir -p /go/src/helloworld
WORKDIR /go/src/helloworld

COPY /main.go /go/src/helloworld

#disable crosscompiling
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux

RUN go build -ldflags '-w -s' -a -installsuffix cgo -o helloworld

FROM scratch

COPY --from=builder /go/src/helloworld/helloworld helloworld

ENTRYPOINT ["./helloworld"]