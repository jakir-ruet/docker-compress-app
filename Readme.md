#### Welcome to Go Application

Application Test
```bash
go build main.go
./main
```

Build as base image
```bash
# BASE IMAGE BUILD
FROM ubuntu AS build
RUN apt-get update && apt-get install golang-go -y
ENV GO111MODULE=off
COPY . .
RUN CGO_ENABLED=0 go build -o /app .
ENTRYPOINT [ "/app" ]
```

Build & check memory
```bash
docker build -t go-app-multi .
docker images | head -4
```

Build as multi stage
```bash
# BASE IMAGE BUILD
FROM ubuntu AS build
RUN apt-get update && apt-get install golang-go -y
ENV GO111MODULE=off
COPY . .
RUN CGO_ENABLED=0 go build -o /app .

# MULTI STAGE BUILD
FROM scratch
# COPY THE COMPILED BINARY FROM BUILD STAGE
COPY --from=build /app /app
# SET ENTRYPOINT FOR CONTAINER TO RUN
ENTRYPOINT [ "/app" ]
```

Build & check memory
```bash
docker build -t go-app .
docker images | head -4
```

Push to Docker Hub
```bash
docker build -t jakirbd/docker-compress-app .
docker run -p --name docker-compress-app -d jakirbd/docker-compress-app:latest
docker push jakirbd/docker-compress-app
```
