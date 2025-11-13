#!/usr/bin/env bash

ROOT_DIR="$HOME/personal/nixe"
KEYS_DIR="$ROOT_DIR/keys"

STASH_DIR="$HOME/personal/stash"
TO_DB="$STASH_DIR/db"
WAKA_KEY="$STASH_DIR/wakatime/wakatime.cfg"
# NIX_CONFIG="$ROOT_DIR/home/configuration.nix"


cp ~/.ssh/* $KEYS_DIR
echo "COPIED TO $KEYS_DIR"

cp ~/.db/tinygo.db $TO_DB
cp ~/.wakatime.cfg $WAKA_KEY
echo "COPIED TO $STASH_DIR"

pushd "$ROOT_DIR"

ansible-vault encrypt ./keys/* $STASH_DIR/db/* $STASH_DIR/wakatime/*
day=$(date '+%Y-%m-%d')

git add .
git commit -m "renix: $day"
git push origin main

pushd "$STASH_DIR"
git add .
git commit -m "stash: follow: \`renix: $day\`"
git push origin main
popd

popd
