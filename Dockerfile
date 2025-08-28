FROM golang:1.20-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o idp-demo-app-2 

FROM alpine:3.17.3
EXPOSE 8080
CMD ["idp-demo-app-2"]
ENV VERSION 1.1.4
COPY --from=build /src/idp-demo-app-2 /usr/local/bin/idp-demo-app-2
RUN chmod +x /usr/local/bin/idp-demo-app-2
