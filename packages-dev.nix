{ pkgs }:

[
  pkgs.cachix
  pkgs.coreutils
  pkgs.dbmate
  pkgs.direnv
  pkgs.libgccjit
  pkgs.hugo
  pkgs.lazygit
  pkgs.nixpkgs-fmt
  pkgs.pgcli
  pkgs.poetry
  pkgs.postgresql
  pkgs.pulumi
  pkgs.tokei
  pkgs.tree-sitter
  pkgs.unzip
  pkgs.uutils-coreutils
  pkgs.nodejs
  pkgs.texlive.combined.scheme-full
  # pkgs.surrealdb
  pkgs.cocoapods
  # k8s stuff
  pkgs.go-task
  pkgs.cilium-cli
  pkgs.cloudflared
  pkgs.kustomize
  pkgs.sops
  pkgs.stern
  pkgs.yq
  # # Devenv
  # (import (fetchTarball "https://github.com/cachix/devenv/archive/v0.6.2.tar.gz")).default
]
