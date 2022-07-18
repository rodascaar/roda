FROM golang:1.15-buster as build-base

WORKDIR /build

COPY src /build/src
COPY go.mod /build
COPY main.go /build

RUN go build -o /build/output/webservice

FROM golang:1.15-buster

ENV VERSION=1.0.0
ENV APP_NAME=webservice

WORKDIR /${APP_NAME}

COPY configuration /configuration
COPY docker/app/run_webservice.sh /${APP_NAME}/run_webservice.sh

COPY --from=build-base /build/output/webservice /webservice/golang-dockerized-webservice

CMD ["/webservice/golang-dockerized-webservice"]