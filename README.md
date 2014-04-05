# 住井研究室のステキな TeX ファイルたち

東北大学 情報科学研究科 住井研究室で使う（かもしれない）便利な LaTeX ファイルを公開しています。

- `paper/` : 論文のクラスファイルとサンプルファイル
- `slide/` : プレゼンテーション用の beamer サンプルファイル

ちなみに、文字コードは全て UTF-8 です。
EUC-JP 派の人は `nkf --euc` などで文字コードを変換してから使いましょう。

## LaTeX 環境の構築

### Linux 環境の構築（最低限）

#### Linux のインストール

まずは、Linux を VMware などでインストールしましょう。
インストーラの指示に従って「はい」と答えるだけの簡単なお仕事です。
今回は Debian をインストールしたことにしましょう。
（Ubuntu などでも構いません。）

#### パッケージの追加

Debian では、よく使うソフトウェアなどをパッケージという単位でサーバに保存し、管理しています。
そして、コマンドを叩くだけで、それらのパッケージをインストールする仕組みがあります。
デフォルトの設定だと、インストールできるパッケージが限られていて不便なので、増やしておきましょう。

パッケージをダウンロードするためのサーバ情報は `/etc/apt/sources.list` という設定ファイルに
書かれています。これを少し書き換えてみます。`/etc` はスーパーユーザ権限でなければ書き換えられないので、
Debian の人は `su` でスーパーユーザになって下さい。Ubuntu の人はコマンドの前に `sudo` をつけて
実行するか、`sudo su` でスーパーユーザになりましょう。

まずは、念の為にバックアップを作っておきます。

    # cd /etc/apt
    # cp sources.list sources.list.bak

スーパーユーザで設定ファイルをいじるときは、バックアップを取るのが常識です。
設定ミスで変な動作をするときは `mv sources.list.bak sources.list` で以前の状態に戻せます。

次に、この設定ファイルの各行の行末に `contrib non-free` というキーワードを追加します。
これで、インストールできるパッケージが増えます。
いちいち、エディタで書き換えてもいいですが、次の2つのコマンドを実行しても同じ事ができます。

    # perl -i -ple '$_ .= " contrib" if /deb/ && !/contrib/' sources.list
    # perl -i -ple '$_ .= " non-free" if /deb/ && !/non-free/' sources.list

そして、最後にサーバからパッケージのリストをダウンロードしてきます。

    # aptitude update

Ubuntu の人は上のコマンドの代わりに `sudo apt-get update` と打ちます。
ちなみに、`aptitude` や `apt-get` は CUI のパッケージ管理ソフトです。
Debian だと両方のコマンドが使えますが、`aptitude` は `apt-get` のフロントエンドなので、
`aptitude` の方をオススメします。

### git と TeXLive のインストール

次のコマンドで git と TeXLive をインストールできます。

    # aptitude install git texlive-full texlive-lang-cjk

Ubuntu の人は `sudo apt-get install git texlive-full texlive-lang-cjk` とします。

### スタイルファイルのインストール

スタイルファイルというのは、大雑把に言えば TeX におけるライブラリ的なものです。
便利なマクロなどをまとめた TeX ファイルです。

スタイルファイルのインストール方法はググれば沢山ヒットしますが、一応紹介しておきます。
基本的にスタイルファイルは、コンパイルする TeX ファイルと同じディレクトリに置けば読み込まれますが、
新しく論文やスライドを作る度にスタイルファイルをコピーするのは面倒なので、
よく使いそうなものはインストールすると良いです。

#### スタイルファイルの保存場所を探す

まずは、TeX のスタイルファイルがどこに保存されているか調べます。
（保存場所がわかっているなら、調べなくて良いです。）

    $ find / -name "graphicx.sty" 2>/dev/null

`/.../tex/latex/graphics/graphicx.sty` のような結果が表示されると思います。
`/.../` の部分は環境によって異なり、私の環境では `/usr/local/texlive/2012/texmf-dist/` でした。
この場合、スタイルファイルは `/.../tex` 以下のディレクトリに保存することになります。
LaTeX 用のものは `/.../tex/latex`、pLaTeX 専用のものは `/.../tex/platex` 以下に保存します。
この文章の意味がわからなければ、とりあえず `/.../tex/platex` に保存するのが無難でしょう。
このディレクトリの直下でも良いですし、さらにディレクトリを作ってその中に保存してもいいです。

#### jlisting.sty のインストール

LaTeX でソースコードを書くときは listings.sty というスタイルファイルを使うことが多いです。
ただし、コメント等に日本語を含むソースコードはうまく表示できないことがあるので、
日本語を使うときは listings.sty と jlisting.sty を併用する必要があります。
listings.sty はデフォルトでも入っていますが、jlisting.sty は入っていないので、インストールします。

http://mytexpert.sourceforge.jp/index.php?Listings から jlisting.sty.bz2 をダウンロードし、
`bunzip2 jlisting.sty.bz2` で解凍すると、`jlisting.sty` というファイルが得られます。
これを先ほどの `/.../tex/platex` 以下に保存します。

#### pxjahyper.sty のインストール

Beamer で作ったスライドを dvipdfmx で PDF に変換すると、PDF の目次が文字化けすることがあります。
プリアンブルで読み込んでおくと、PDF の目次が文字化けを防ぐことができます。
PDF 自体は pxajahyper の有無にかかわらず、文字化けしないので問題ありませんが、入れておいて
損はないでしょう。

https://github.com/zr-tex8r/PXjahyper から pxjahyper.sty をダウンロードし、
先ほどの `/.../tex/platex` 以下に保存します。

#### 仕上げ

スタイルファイルを所定のディレクトリに保存したら、スーパーユーザ権限で `mktexlsr` というコマンドを実行します。
これで、スタイルファイルがインストールされ、使えるようになります。

### 環境構築が終わったら

苦労の末に完成した LaTeX 環境を早速使ってみましょう。
試しに、スライドでもコンパイルしてみましょう。

## 論文の書き方

次の一連のコマンドを実行します。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/paper/
    $ make

きっと、カレントディレクトリには paper.pdf という論文の PDF ファイルが
出来上がっていることでしょう。
Adobe Reader (acroread) や evince で、ちゃんと表示できれば成功です。

- paper.tex はクラスファイルの使用例を兼ねたテンプレートです。
  これを改造すれば論文が書けます。
- 参考文献は refs.bib に追加しましょう。
  「文献の名称 + bibtex」でググると、大抵は BibTeX の書き方が出てくるので、
  それを流用するといいでしょう。

ぜひ、ステキな論文を書いて下さい。

## スライドの書き方

次の一連のコマンドを実行します。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/slide/
    $ make

きっと、カレントディレクトリには slide.pdf というスライドの PDF ファイルが
出来上がっていることでしょう。
Adobe Reader (acroread) や evince で、ちゃんと表示できれば成功です。

- slide.tex を改造すれば、スライドが作れます。
- 注意：論文とは違って、スライドに関しては特定のフォーマットが決められているわけではありません。
  好きに改造してもらって結構です。

## 参考資料

LaTeX の文書作成に有用な（と思われる）資料です。

- [The Comprehensive LaTeX Symbol List](http://www.tex.ac.uk/tex-archive/info/symbols/comprehensive/symbols-a4.pdf):
  LaTeX の記号が大量にリストアップされているので、必要な記号を探すのに良いです。
  PDF なので、ダウンロードしてすぐに参照できるようにしておくと良いでしょう。
- [日本語 LaTeX を使うときに注意するべきこと](http://www.math.tohoku.ac.jp/~kuroki/LaTeX/howtolatex.html):
  数式の体裁を整える方法について細かく書いてあって良いです。
- [辻研究室 Beamer](http://neurodynamics.jp/etc/beamer):
  Beamer の機能についての説明が分かりやすくまとまっています。
