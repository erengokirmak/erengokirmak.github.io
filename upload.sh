#!/bin/bash

source .env

# Check if the username is malformed
[[ "$SERVER_USER" =~ ^[a-zA-Z0-9._-]+$ ]] || {
  echo "[ERROR]: SERVER_USER: \"$SERVER_USER\" is invalid"
  exit
}

# Remove files from compilations before
rm -rf public/* || {
  echo "[ERROR]: There was an error deleting files from the public directory"
  exit
}

# Recompile the website
hugo --minify --ignoreCache --gc || {
  echo "[ERROR]: Recompilation failed"
  exit
}

printf "\n[INFO]: Recompilation complete\n\n"

cd public || {
  echo "[ERROR]: Could not find public directory"
  exit
}

# Replace the files with the newly generated files
echo "Syncing server content with local..."
rsync -azq --rsh="sshpass -e ssh -l $SERVER_USER" --delete ./ "$FINAL_PATH" || {
  echo "[ERROR]: There was an error syncing the directory. Is rsync installed?"
  exit
}

printf "\n[INFO]: Sync complete! Enjoy the new version of your website :)\n"
