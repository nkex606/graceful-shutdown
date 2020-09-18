FROM golang AS builder
WORKDIR /go/src/graceful-shutdown/
COPY . .
RUN go get -d -v -t ./...
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/graceful-shutdown/main .
ENTRYPOINT ["./main"]