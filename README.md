# addinginc/homebrew-tap

[cotomu](https://app.cotomu.jp) CLI の Homebrew tap です。

## インストール

```sh
brew install addinginc/tap/cotomu
```

インストール後、`cotomu auth login` で認証してください。

## 更新

```sh
brew upgrade cotomu
```

## その他のインストール方法

Homebrew を使わない環境 (CI など) では install script も利用できます:

```sh
curl -fsSL https://app.cotomu.jp/cli/install.sh | sh
```

## 仕組み

- バイナリは cotomu のリリースパイプラインが公開配布バケット
  (`gs://cotomu-cli-dist`) に publish したものをそのまま参照します
  (formula の `sha256` は同バケットの `checksums.txt` 由来)。
- [`Formula/cotomu.rb`](Formula/cotomu.rb) は
  [`bump-formula.yml`](.github/workflows/bump-formula.yml) が
  [`scripts/render-formula.sh`](scripts/render-formula.sh) で自動生成します。
  手で編集しないでください (次回リリースで上書きされます)。
