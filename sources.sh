#!/bin/bash

echo -n > sources

date=$(date +%Y-%m-%d)

for os in debian ubuntu; do
  echo "${os}:latest" >> sources
  curl -s https://endoflife.date/api/${os}.json | \
    jq -r --arg date "$date" '.[] | select(.eol > $date) | .codename' | \
    tr 'A-Z' 'a-z' | cut -d ' ' -f1 | xargs -IXXX echo ${os}:XXX >> sources
done

# No EOL for busybox, it is on release-monitoring.org so could use that, but
# hardcode for now...
echo busybox:latest >> sources
echo busybox:stable-uclibc >> sources
