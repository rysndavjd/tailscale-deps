#!/bin/bash

work=$(pwd)
echo $work
GOMODCACHE=$(go env GOMODCACHE)
echo $GOMODCACHE
VERSION=$(./build_dist.sh shellvars | grep "VERSION_SHORT" | sed 's/VERSION_SHORT=//' | tr -d '"')
echo $VERSION
rm "$GOMODCACHE" -rf
go mod download -x
rm "$GOMODCACHE/cache" -fr
mv "$GOMODCACHE" "$(dirname $GOMODCACHE)"/go-mod
cd "$(dirname $GOMODCACHE)/"
echo "Taring files"
tar -cf tailscale-$VERSION-deps.tar go-mod
rm "$(dirname $GOMODCACHE)"/go-mod -rf
echo "Compressing"
gzip tailscale-$VERSION-deps.tar
mv ./tailscale-$VERSION-deps.tar.gz "$work/"
