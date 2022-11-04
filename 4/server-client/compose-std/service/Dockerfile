FROM golang:alpine AS base

WORKDIR /
COPY main.go ./
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags="-w -s" -o /main main.go

FROM scratch

COPY --from=base /main /main

CMD ["./main"]
