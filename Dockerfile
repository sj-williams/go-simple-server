# syntax=docker/dockerfile:1

FROM golang:1.18-alpine

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN go build -o /server

EXPOSE 8080

CMD [ "/server" ]