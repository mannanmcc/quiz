# build app to upload to VPS
docker run --rm \
  -v "$PWD":/src \
  -w /src \
  golang:1.25 \
  go build -o quizeapp ./cmd/server

  
