#!/usr/bin/env bash

BASE_NIX_SHELL="""{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # packages here
  ];
  shellHook = ''
  # exported variables maybe...
  '';
}
"""
echo "$BASE_NIX_SHELL" > ./shell.nix
echo "base shell.nix created"

