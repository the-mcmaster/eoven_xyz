#! /usr/bin/bash

# ------------------------------------------------------------
# EXIT HANDLING
trap 'e=$?; [[ $e -ne 0 ]] && cleanup_on_fail "$e"' EXIT

set -e
set -o pipefail
# ------------------------------------------------------------

# ------------------------------------------------------------
# VARIABLES
REVERT=$(echo $PWD)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Use mktemp to create a secure, randomized temporary directory
BACKUP_DIR="$(mktemp -d)"

# RESTORE_NEEDED:
#   This variable is used to determine if we need to restore the previous state.
#   ONLY when the new build is 100% verified and complete.
#   0: The previous state does not need to be restored.
#   _: The previous state needs to be restored.
RESTORE_NEEDED=1

# FLUTTER_CLEANED:
#   This variable is used to determine if the flutter environment has been cleaned.
#   0: The flutter environment has not been cleaned.
#   _: The flutter environment has been cleaned.
FLUTTER_CLEANED=0

# FLUTTER_PUB_GET:
#   This variable is used to determine if the flutter environment has been refreshed.
#   0: The flutter environment has not been refreshed.
#   _: The flutter environment has been refreshed.
FLUTTER_PUB_GET=0

# FLUTTER_BUILT:
#   This variable is used to determine if the flutter application has been built.
#   0: The flutter application has not been built.
#   _: The flutter application has been built.
FLUTTER_BUILT=0
# ------------------------------------------------------------

# ------------------------------------------------------------
# FUNCTION DEFINITIONS
cleanup_on_fail() {
  local exit_code=$?

  # 1. Handle Failures (Restore previous state)
  if [[ $exit_code -ne 0 ]]; then
    echo "Build failed (exit code $exit_code). Initiating cleanup..." >&2

    if [[ $RESTORE_NEEDED -eq 1 ]]; then
      echo "Restoring previous docs directory and CNAME..." >&2
      
      # Safely remove whatever broken state exists
      rm -rf "$SCRIPT_DIR/docs" 
      
      # Restore original docs if we backed them up
      if [[ -d "$BACKUP_DIR/docs" ]]; then
        mv "$BACKUP_DIR/docs" "$SCRIPT_DIR/docs"
      else
        mkdir -p "$SCRIPT_DIR/docs"
      fi

      # Restore CNAME to docs/
      if [[ -f "$BACKUP_DIR/CNAME" ]]; then
        cp "$BACKUP_DIR/CNAME" "$SCRIPT_DIR/docs/CNAME"
      fi
    fi

    # Surface Flutter-specific warnings
    if [[ $FLUTTER_CLEANED -eq 1 && $FLUTTER_PUB_GET -eq 0 ]]; then
      echo "Warning: \`flutter pub get\` failed after cleaning." >&2
      echo "         Run \`flutter pub get\` manually to restore your environment." >&2
    fi
  else
    echo "Build completed successfully!"
  fi

  # 2. Universal Cleanup (Always run, success or fail)
  if [[ -d "$BACKUP_DIR" ]]; then
    rm -rf "$BACKUP_DIR"
  fi

  cd "$REVERT" 2>/dev/null || true
  exit "$exit_code"
}
# ------------------------------------------------------------


# ------------------------------------------------------------
# MAIN LOGIC

echo "Creating secure backup directory at $BACKUP_DIR"

# 1. Stash Existing Docs
if [[ -d "$SCRIPT_DIR/docs" ]]; then
  mv "$SCRIPT_DIR/docs" "$BACKUP_DIR/docs"
  echo "Stashed docs directory from previous build."
fi

# 2. Stash CNAME securely in the root of the backup dir
if [[ -f "$BACKUP_DIR/docs/CNAME" ]]; then
  echo "Stashed CNAME from previous docs directory."
elif [[ -f "$SCRIPT_DIR/CNAME" ]]; then
  cp "$SCRIPT_DIR/CNAME" "$BACKUP_DIR/docs/CNAME"
  echo "Stashed CNAME from base directory."
else
  echo "Error: Missing CNAME file." >&2
  echo "       Include a CNAME file in the base directory or docs directory." >&2
  exit 1
fi

# 3. Build Flutter Application
echo "Building flutter application..."
cd "$SCRIPT_DIR/flutter_app" || exit 1

flutter clean
FLUTTER_CLEANED=1

flutter pub get
FLUTTER_PUB_GET=1

flutter build web --release --base-href "/docs/"
FLUTTER_BUILT=1

# 4. Verify Build Output
if [[ ! -d "build/web" || ! -f "build/web/index.html" ]]; then
  echo "Error: Flutter web build failed to produce index.html or build/web/ directory." >&2
  exit 1
fi

# 5. Populate New Docs Directory
echo "Replacing docs directory with new build..."
rm -rf "$SCRIPT_DIR/docs"
mkdir -p "$SCRIPT_DIR/docs"

cp -r build/web/* "$SCRIPT_DIR/docs/"

if [[ ! -f "$SCRIPT_DIR/docs/index.html" ]]; then
  echo "Error: Failed to copy index.html to the new docs directory." >&2
  exit 1
fi

# 6. Generate 404.html and Restore CNAME
echo "Generating docs/404.html..."
cp "$SCRIPT_DIR/docs/index.html" "$SCRIPT_DIR/docs/404.html"

echo "Restoring CNAME..."
if [[ -f "$BACKUP_DIR/docs/CNAME" ]]; then
  cp "$BACKUP_DIR/docs/CNAME" "$SCRIPT_DIR/docs/CNAME"
fi

# 7. Mark Success
# The script reached the end without exiting, so the new build is entirely valid.
# We toggle this to 0 so the trap knows NOT to overwrite our fresh build on exit.
RESTORE_NEEDED=0
# ------------------------------------------------------------