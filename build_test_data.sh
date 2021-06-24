#!/bin/bash
mkdir -p Data/XML
mkdir -p Data/JSON
{
  IFS=" "
  while read -r url file; do
    #echo "$url > $file"
    curl $url -Lo Data/XML/$file.xml
    curl https://feed2json.org/convert?url=$url -o Data/JSON/$file.json
  done
} < ./Tests/RSSCodedTests/urls.tsv