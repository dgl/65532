#!/bin/bash

created() {
  local image="$1"
  docker pull $image >&2
  # Currently we just use the image names discovered from codenames via sources.sh.
  # Many images have an annotation like org.opencontainers.image.ref.name which
  # we could use, just log for now so this is visible in the actions log.
  docker buildx imagetools inspect ${image} --raw >&2
  docker image history --format json "$image" | tail -n1 | jq -r '.CreatedAt'
}

for source in $(<sources); do
  if [[ $(created $source) != $(created 65532/$source) ]]; then
    docker build --build-arg BASE="$source" -t 65532/$source .
    docker push 65532/$source
  fi
  if [[ $source == debian:latest ]] || [[ $source == ubuntu:latest ]]; then
    image="65532/${source//:latest}:debug"
    if [[ $(created $image) != $(created 65532/$source) ]]; then
      # For latest images, make a debug variant, with useful command line utilities, etc.
      docker build --build-arg BASE="65532/$source" -t $image debug
      docker push $image
    fi
  fi
done
