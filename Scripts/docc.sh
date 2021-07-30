#!/bin/bash
xcodebuild docbuild -scheme SyndiKit  -destination 'platform=macOS' -derivedDataPath DerivedData
docker run -d -p 8080:80 -v "$(pwd)/DerivedData/Build/Products/Debug:/usr/local/apache2/htdocs/"  --rm -it $(docker build -q .)
