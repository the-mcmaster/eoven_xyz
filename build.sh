#! /usr/bin/bash

REVERT=$(echo $PWD)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Stashing CNAME in base directory"
mv "$SCRIPT_DIR""/docs/CNAME" "$SCRIPT_DIR""/CNAME"

echo "Building flutter application"
cd "$SCRIPT_DIR""/flutter_app"
flutter build web --release --base-href "/"
echo "Emptying docs directory"
rm -rf ../docs
mkdir ../docs

echo "Move built files into docs"
cp -r build/web/* ../docs/
echo "Generate docs/404.html"
cp build/web/index.html ../docs/404.html

echo "Moving stashed CNAME into docs"
mv "$SCRIPT_DIR""/CNAME" "$SCRIPT_DIR""/docs/CNAME"

cd $PWD