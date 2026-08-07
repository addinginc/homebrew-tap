#!/bin/sh
# shellcheck shell=sh
# cotomu CLI の Homebrew formula を配布バケットの checksums.txt から生成する。
#
# Usage:
#   scripts/render-formula.sh cli-vX.Y.Z /path/to/checksums.txt > Formula/cotomu.rb
#
# checksums.txt は cotomu リポジトリのリリース workflow (cli-release-reusable.yml) が
# gs://cotomu-cli-dist/cli/<tag>/checksums.txt に publish するもの
# (形式: "<sha256>  cotomu_vX.Y.Z_<os>_<arch>.tar.gz")。
set -eu

usage="usage: render-formula.sh <cli-vX.Y.Z> <checksums.txt>"
tag="${1:?${usage}}"
sums="${2:?${usage}}"

case "$tag" in
  cli-v*) ;;
  *)
    echo "error: tag must look like cli-vX.Y.Z (got: ${tag})" >&2
    exit 1
    ;;
esac
[ -f "$sums" ] || {
  echo "error: checksums file not found: ${sums}" >&2
  exit 1
}

version="${tag#cli-v}" # X.Y.Z (formula の version)
semver="v${version}"   # vX.Y.Z (asset 名の一部)
base="https://storage.googleapis.com/cotomu-cli-dist/cli/${tag}"

sha_for() {
  asset="cotomu_${semver}_$1.tar.gz"
  sha="$(awk -v a="$asset" '$2 == a { print $1 }' "$sums")"
  if [ -z "$sha" ]; then
    echo "error: no checksum entry for ${asset} in ${sums}" >&2
    exit 1
  fi
  printf '%s' "$sha"
}

darwin_arm64_sha="$(sha_for darwin_arm64)"
darwin_amd64_sha="$(sha_for darwin_amd64)"
linux_arm64_sha="$(sha_for linux_arm64)"
linux_amd64_sha="$(sha_for linux_amd64)"

cat <<EOF
# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "${version}"

  on_macos do
    if Hardware::CPU.arm?
      url "${base}/cotomu_${semver}_darwin_arm64.tar.gz"
      sha256 "${darwin_arm64_sha}"
    else
      url "${base}/cotomu_${semver}_darwin_amd64.tar.gz"
      sha256 "${darwin_amd64_sha}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "${base}/cotomu_${semver}_linux_arm64.tar.gz"
      sha256 "${linux_arm64_sha}"
    else
      url "${base}/cotomu_${semver}_linux_amd64.tar.gz"
      sha256 "${linux_amd64_sha}"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
EOF
