#!/usr/bin/env bash

pushd ~/personal/nixe

git add .

home-manager switch --flake .#sminx

git commit -m "hr: config modified"

git push origin main

popd
