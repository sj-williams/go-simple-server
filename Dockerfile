# syntax=docker/dockerfile:1
FROM golang:1.21-alpine AS builder

RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

WORKDIR /src

COPY server.go .

RUN go build -o /bin/server ./server.go

RUN chown -R appuser:appgroup /bin

FROM scratch

# Copy static executable
COPY --from=builder /bin/server /bin/server

# Copy the user and group files from the builder stage
COPY --from=builder /etc/passwd /etc/passwd

USER 1000

EXPOSE 8080

CMD ["/bin/server"]