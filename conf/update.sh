#!/usr/bin/env bash

INSTALL_DIR=__INSTALL_DIR__

# There are always some translation related changes
git -C "$INSTALL_DIR/landingpage" stash

# Update the repo...
git -C "$INSTALL_DIR/landingpage" pull

# Update the web page!
LANDINGPAGE_DIST_DIR="$INSTALL_DIR/www_next" bash -x "$INSTALL_DIR/landingpage/bin/regenerate.sh"
chown -R :www-data "$INSTALL_DIR/www_next"

# "atomic" replace
rm -rf "$INSTALL_DIR/www"
mv "$INSTALL_DIR/www_next" "$INSTALL_DIR/www"
