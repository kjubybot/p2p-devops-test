FROM golang:1.22-alpine AS build

WORKDIR /build
COPY go.mod ./
RUN go mod download

COPY main.go ./
RUN --mount=type=cache,target=/root/.cache/go-build go build

FROM alpine:3.19

WORKDIR /app
COPY --from=build /build/uselessapp ./

ENTRYPOINT ["/app/uselessapp"]
