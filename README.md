住井研究室のステキな TeX ファイルたち
============

東北大学 情報科学研究科 住井研究室で使う（かもしれない）便利な LaTeX ファイルを公開しています。
- 論文のクラスファイルとサンプルファイル（paper ブランチ）
- プレゼンテーション用の beamer サンプルファイル（slide ブランチ）

ちなみに、文字コードは全て UTF-8 です。
EUC-JP 派の人は `nkf --euc` などで文字コードを変換してから使いましょう。

LaTeX 環境の構築
------------

1. まずは、Linux を VMware などでインストールしましょう。
   インストーラの指示に従って「はい」と答えるだけの簡単なお仕事です。
   今回は Debian か Ubuntu をインストールしたことにしましょう。
2. 次のコマンドを実行して、TeXLive をインストールします。
   - Ubuntu: `sudo aptitude install texlive-full texlive-lang-cjk`
   - Debian: `su` → `aptitude install texlive-full texlive-lang-cjk`
3. インストールできたら、試しに論文のサンプルファイルでもコンパイルしてみましょう。
   コンパイルの仕方は論文のセクションを見て下さい。

Windows でも TeX はインストールできますが、Linux をおすすめします。
どうしても、Windows が使いたい人は自力で何とかして下さい。

論文の書き方
------------

次の一連のコマンドを実行します。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/
    $ git checkout paper
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

スライドの書き方
------------

次の一連のコマンドを実行します。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/
    $ git checkout slide
    $ make

きっと、カレントディレクトリには slide.pdf というスライドの PDF ファイルが
出来上がっていることでしょう。
Adobe Reader (acroread) や evince で、ちゃんと表示できれば成功です。

- slide.tex を改造すれば、スライドが作れます。
- 注意：論文とは違って、スライドに関しては特定のフォーマットが決められているわけではありません。
  好きに改造してもらって結構です。
