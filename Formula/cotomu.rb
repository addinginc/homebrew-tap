# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "0.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.9.0/cotomu_v0.9.0_darwin_arm64.tar.gz"
      sha256 "53499cf2df85c2a36ccbea7662f071c9621b17a2b9f4c6ced4d25fc3712e1291"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.9.0/cotomu_v0.9.0_darwin_amd64.tar.gz"
      sha256 "37bc21c398347d92c25a0fe8880570ac2b2dbd94b673a034fabb51ed09b8b3cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.9.0/cotomu_v0.9.0_linux_arm64.tar.gz"
      sha256 "3c9e7accd009df226b63bee890f9b984736118020885a226d3e494445376e18a"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.9.0/cotomu_v0.9.0_linux_amd64.tar.gz"
      sha256 "a727396b20d800a4525baecb19416053a57816227db7cc5b7a735e3b6a56dba5"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
