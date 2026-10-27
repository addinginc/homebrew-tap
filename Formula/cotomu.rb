# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "0.10.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.2/cotomu_v0.10.2_darwin_arm64.tar.gz"
      sha256 "69ac27e403a79a05b5c9b47b4789e2c0c9eb942d09b715e98a34d27ba505e41c"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.2/cotomu_v0.10.2_darwin_amd64.tar.gz"
      sha256 "aeb51551e49814e05e3c83fdefb37cf6cc7f7ab83a03addc7f0e6341b10f3447"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.2/cotomu_v0.10.2_linux_arm64.tar.gz"
      sha256 "72f0628109b41798aaf1886795219124cc487abf1c88b1a9101da018659731cb"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.2/cotomu_v0.10.2_linux_amd64.tar.gz"
      sha256 "54b5aff6f8c7972f2b1bee97ec329d5aa24de4bd7ac52eaec0c9d29fe50e0977"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
