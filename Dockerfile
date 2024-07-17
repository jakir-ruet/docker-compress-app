# # BASE IMAGE BUILD
# FROM ubuntu AS build
# RUN apt-get update && apt-get install golang-go -y
# ENV GO111MODULE=off
# COPY . .
# RUN CGO_ENABLED=0 go build -o /app .
# ENTRYPOINT [ "/app" ]

# MULTI STAGE BUILD
FROM ubuntu AS build
RUN apt-get update && apt-get install golang-go -y
ENV GO111MODULE=off
COPY . .
RUN CGO_ENABLED=0 go build -o /app .
FROM scratch
# COPY THE COMPILED BINARY FROM BUILD STAGE
COPY --from=build /app /app
# SET ENTRYPOINT FOR CONTAINER TO RUN
ENTRYPOINT [ "/app" ]