# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "0.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.0/cotomu_v0.10.0_darwin_arm64.tar.gz"
      sha256 "0fe237febe0e97aa53052011958649ef6dc65ff486f05d46baa6d781944b816b"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.0/cotomu_v0.10.0_darwin_amd64.tar.gz"
      sha256 "4ff133a10cb34f4702350006a231605f05d5d6af8b5fbcf9fe20b01b55dd22b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.0/cotomu_v0.10.0_linux_arm64.tar.gz"
      sha256 "5dae6a276c8c372e4aaa0add7787bb8fdd44281289cc85b949b62348a1b6fb44"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.10.0/cotomu_v0.10.0_linux_amd64.tar.gz"
      sha256 "deb66ee8ddab1267634963168ca5e9c5ef13837ea1cd83bb1961a4d0ba7f5696"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
