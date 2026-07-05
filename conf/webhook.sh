#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_DIR=__INSTALL_DIR__
GITHUB_TOKEN=$(cat "$INSTALL_DIR/github_token")
ARTIFACT_URL=$1

if [ -z "$ARTIFACT_URL" ]; then
    echo "Script should be called with an url as argument."
    exit 1
fi

rm -rf "$INSTALL_DIR/www_next"
mkdir "$INSTALL_DIR/www_next"

curl -H "Authorization: Bearer $GITHUB_TOKEN" -L -s -o "$INSTALL_DIR/dist.zip" "$ARTIFACT_URL"
unzip -q "$INSTALL_DIR/dist.zip" -d "$INSTALL_DIR/www_next"

# Swap the directories
rm -rf "$INSTALL_DIR/www_old"
mv "$INSTALL_DIR/www" "$INSTALL_DIR/www_old"
mv "$INSTALL_DIR/www_next" "$INSTALL_DIR/www"
