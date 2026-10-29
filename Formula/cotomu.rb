# frozen_string_literal: true

# cotomu CLI (Cotomu Public API クライアント) の Homebrew formula。
# このファイルは .github/workflows/bump-formula.yml が scripts/render-formula.sh で
# 自動生成する。手で編集しないこと (次回リリースで上書きされる)。
class Cotomu < Formula
  desc "Cotomu Public API CLI for AI agents and ad operations"
  homepage "https://app.cotomu.jp"
  version "0.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.11.0/cotomu_v0.11.0_darwin_arm64.tar.gz"
      sha256 "2dc02cb6e4220163766a3d0fa901c04b8e3955dbd0e6bc2de446ef2cda7273df"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.11.0/cotomu_v0.11.0_darwin_amd64.tar.gz"
      sha256 "f6109380a0defc7b99e5ffffc4873bd29065a556bcaf64b50880bdafb5e0169a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.11.0/cotomu_v0.11.0_linux_arm64.tar.gz"
      sha256 "cafcad6742cc195d6a1f4cdaad60420d54ccc5563da710c84ba732e66e18a4e0"
    else
      url "https://storage.googleapis.com/cotomu-cli-dist/cli/cli-v0.11.0/cotomu_v0.11.0_linux_amd64.tar.gz"
      sha256 "82f22f2651ef278aa834b458d843d679d059702b94e9e8ef2f1e5583b46f48e0"
    end
  end

  def install
    bin.install "cotomu"
  end

  test do
    assert_match "cli-v#{version}", shell_output("#{bin}/cotomu --version")
  end
end
