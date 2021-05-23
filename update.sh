#!/bin/sh
set -e

echo nginx version: "$1"

mkdir -p modules/ngx_http_uploadprogress_module
echo "https://github.com/masterzen/nginx-upload-progress-module/archive/refs/tags/v0.9.2.tar.gz" > modules/ngx_http_uploadprogress_module/source

curl -o modules/Dockerfile https://raw.githubusercontent.com/upstreamable/docker-nginx/build-module/modules/Dockerfile.alpine
sed -i 's/mainline-alpine/'"${1}"'-alpine/g' modules/Dockerfile

docker build --build-arg ENABLED_MODULES="ngx_http_uploadprogress_module" -t upstreamable/nginx-with-uploadprogress:"$1" modules
docker push upstreamable/nginx-with-uploadprogress:"$1"

rm -rf modules
