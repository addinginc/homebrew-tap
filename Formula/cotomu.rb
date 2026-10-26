# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "0.10.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.1/cotomu_v0.10.1_darwin_arm64.tar.gz"
      sha256 "9f2db819aa516b0f478abfcd95282efa706a4403641197fb0ce9022d25274c1d"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.1/cotomu_v0.10.1_darwin_amd64.tar.gz"
      sha256 "7fd0e7433d61a923e3db9622fc74706039fe8b88be41c941a2971d37ae9abeb4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.1/cotomu_v0.10.1_linux_arm64.tar.gz"
      sha256 "c477816d768016d25bc033035c76616775d2774bdbf743ddc9f562f8ae8435fa"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.1/cotomu_v0.10.1_linux_amd64.tar.gz"
      sha256 "4f10409ddadb37607152feb74df4dada2f3f2fb5b1a31ffd244b0cce04c47d1a"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
