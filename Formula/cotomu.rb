# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "0.12.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.12.0/cotomu_v0.12.0_darwin_arm64.tar.gz"
      sha256 "e2d83d59c65336264e1247eea4454656c5584944377560e5838d3cee6a66a833"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.12.0/cotomu_v0.12.0_darwin_amd64.tar.gz"
      sha256 "0f25e170f8ee1b85292cf4c05e6d1e3104a1a6b1c3e98486ed8e212d8395484b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.12.0/cotomu_v0.12.0_linux_arm64.tar.gz"
      sha256 "fdee1ef98f0b6092747d1ece10a5d95048330aac028110108911d9f39632f2a4"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.12.0/cotomu_v0.12.0_linux_amd64.tar.gz"
      sha256 "0e8444976bf62d198265bae535258dbe4e02f40a5335cfc8d24964b425709425"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
