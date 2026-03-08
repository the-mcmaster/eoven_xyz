#! /usr/bin/bash

cleanup_on_fail() {
  local exit_code=${1:-$?}
  echo "Build failed (exit code $exit_code). Check errors above." >&2
  # Optional: ensure we return to original dir even if something failed mid-script
  cd "$REVERT" 2>/dev/null || true
}
trap 'e=$?; [[ $e -ne 0 ]] && cleanup_on_fail "$e"' EXIT

set -e
set -o pipefail

REVERT=$(echo $PWD)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Stashing CNAME in base directory"
if [[ -f "$SCRIPT_DIR/docs/CNAME" ]]; then
  mv "$SCRIPT_DIR/docs/CNAME" "$SCRIPT_DIR/CNAME"
else
  echo "Warning: No docs/CNAME found, skipping stash" >&2
fi

echo "Building flutter application"
cd "$SCRIPT_DIR""/flutter_app"
flutter clean
flutter pub get
flutter build web --release --base-href "/"
if [[ ! -d "build/web" ]]; then
  echo "Error: flutter build web did not produce build/web/ directory" >&2
  exit 1
fi
if [[ ! -f "build/web/index.html" ]]; then
  echo "Error: build/web/index.html file missing" >&2
  exit 1
fi
echo "Emptying docs directory"
rm -rf ../docs
mkdir ../docs

echo "Move built files into docs"
cp -r build/web/* ../docs/
if [[ ! -f ../docs/index.html ]]; then
  echo "Error: copy to docs failed" >&2
  exit 1
fi
echo "Generating docs/404.html"
cp build/web/index.html ../docs/404.html
if [[ ! -f ../docs/404.html ]]; then
  echo "Error: copy to docs failed" >&2
  exit 1
fi

echo "Moving stashed CNAME into docs"
if [[ -f "$SCRIPT_DIR/CNAME" ]]; then
  mv "$SCRIPT_DIR/CNAME" "$SCRIPT_DIR/docs/CNAME"
else
  echo "Warning: No stashed CNAME, skipping restore" >&2
fi

flutter clean
flutter pub get

cd "$REVERT"