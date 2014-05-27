# 住井研究室のステキな TeX ファイルたち

東北大学 情報科学研究科 住井研究室で使う（かもしれない）便利な LaTeX ファイルを公開しています。

- `paper/` : 論文のクラスファイルとサンプルファイル
- `slide/` : プレゼンテーション用の beamer サンプルファイル

ちなみに，文字コードは全て UTF-8 です．
EUC-JP 派の人は `nkf --euc` などで文字コードを変換してから使いましょう．

## LaTeX 環境の構築

### Linux 環境の構築（最低限）

#### Linux のインストール

まずは，Linux を VMware などでインストールしましょう．
インストーラの指示に従って「はい」と答えるだけの簡単なお仕事です．
今回は Debian をインストールしたことにしましょう．
（Ubuntu などでも構いません．）

#### 基礎知識：スーパーユーザ（root ユーザ）

このあとのインストール手順ではコンソールにコマンドを入力して実行する操作が登場しますが，
プロンプトの記号で一般ユーザでの実行なのか，スーパーユーザでの実行なのかを区別します．

- `$` は一般ユーザでの実行（例: `$ ls` は一般ユーザで `ls` を実行）
- `#` はスーパーユーザでの実行（例: `# ls` はスーパーユーザで `ls` を実行）

`$` や `#` 自体はコマンドではないので，入力しません．
一般ユーザからスーパーユーザに切り替えるときは，一般に `su` コマンドを使います．

    $ su
    Password:
    #

ちなみに，パスワードは入力しても画面に表示されないので注意して下さい．
Ubuntu では `su` コマンドの代わりに，`sudo` コマンドを使います．
`sudo` は特定のコマンドだけをスーパーユーザとして実行するためのもので，

    $ sudo ls

のように，一般ユーザで `sudo` の後に実行したいコマンドを書きます．
Ubuntu を使っている人は `#` を `$ sudo` に適宜置き換えて実行して下さい．

#### パッケージの追加

Debian では，よく使うソフトウェアなどをパッケージという単位でサーバに保存し，管理しています．
そして，コマンドを叩くだけで，それらのパッケージをインストールする仕組みがあります．
デフォルトの設定だと，インストールできるパッケージが限られていて不便なので，増やしておきましょう．

パッケージをダウンロードするためのサーバ情報は `/etc/apt/sources.list` という設定ファイルに
書かれています．これを少し書き換えてみます．

まずは，念の為にバックアップを作っておきます．

    # cd /etc/apt
    # cp sources.list sources.list.bak

スーパーユーザで設定ファイルをいじるときは，バックアップを取るのが常識です．
設定ミスで変な動作をするときは `mv sources.list.bak sources.list` で以前の状態に戻せます．

次に，この設定ファイルの各行の行末に `contrib non-free` というキーワードを追加します．
これで，インストールできるパッケージが増えます．
いちいち，エディタで書き換えてもいいですが，次の2つのコマンドを実行しても同じ事ができます．

    # perl -i -ple '$_ .= " contrib" if /deb/ && !/contrib/' sources.list
    # perl -i -ple '$_ .= " non-free" if /deb/ && !/non-free/' sources.list

そして，最後にサーバからパッケージのリストをダウンロードしてきます．

    # aptitude update

Ubuntu を使っている人は上のコマンドの代わりに `sudo apt-get update` を使います．
ちなみに，`aptitude` や `apt-get` は CUI のパッケージ管理ソフトです．
Debian だと両方のコマンドが使えますが，`aptitude` は `apt-get` のフロントエンドなので，
`aptitude` の方をオススメします．

### TeXLive とその他必要なソフトウェアのインストール

次のコマンドで TeXLive とその他必要なソフトウェアをインストールできます．

    # aptitude install texlive-full texlive-lang-cjk git imagemagick inkscape gimp

### スタイルファイルのインストール

スタイルファイルというのは，便利なマクロなどをまとめた TeX ファイルのことです．
基本的にスタイルファイルは，コンパイルする TeX ファイルと同じディレクトリに置けば読み込まれますが，
新しく論文やスライドを作る度にスタイルファイルをコピーするのは面倒なので，
よく使いそうなものはインストールすると良いです．

住井研究室で，よく使いそうなスタイルファイルについては自動でまとめてインストールするためのインストーラを用意しました．

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex
    # ./install.sh

上のコマンドを実行すると，勝手にスタイルファイルをダウンロードしてきて，インストールしてくれます．
どのようなスタイルファイルがインストールされるかについては，`install.sh` を参照して下さい．

sumiilab-tex リポジトリは時々アップデートされるかもしれません．
そのときは，上記のコマンドを再度実行することで，スタイルファイルの追加や更新が行えます．
（時々，この手順でスタイルファイルの追加・更新を行うことをオススメします．）

### 環境構築が終わったら

苦労の末に完成した LaTeX 環境を早速使ってみましょう．
試しに，スライドでもコンパイルしてみましょう．

## スタイルファイルの使い方

### 論文の書き方

次の一連のコマンドを実行します．

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/paper/
    $ make

きっと，カレントディレクトリには paper.pdf という論文の PDF ファイルが
出来上がっていることでしょう．
Adobe Reader (acroread) や evince で，ちゃんと表示できれば成功です．

- paper.tex はクラスファイルの使用例を兼ねたテンプレートです．
  これを改造すれば論文が書けます．
- 参考文献は refs.bib に追加しましょう．
  「文献の名称 + bibtex」でググると，大抵は BibTeX の書き方が出てくるので，
  それを流用するといいでしょう．
- 論文クラスファイル自体の機能については [PAPER.md](PAPER.md) を参照して下さい．

ぜひ，ステキな論文を書いて下さい．

### スライドの書き方

次の一連のコマンドを実行します．

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/slide/
    $ make

きっと，カレントディレクトリには slide.pdf というスライドの PDF ファイルが
出来上がっていることでしょう．
Adobe Reader (acroread) や evince で，ちゃんと表示できれば成功です．

- slide.tex を改造すれば，スライドが作れます．
- 注意：論文とは違って，スライドに関しては特定のフォーマットが決められているわけではありません．
  好きに改造してもらって結構です．

## EPS 画像の作り方

LaTeX の文章に画像を入れるときは，EPS 形式を扱うことが多いです．
例えば，`\includegraphics{foo.eps}` のようにして，画像を文章中に埋め込みます．
ここでは，EPS を作る方法を幾つか紹介します．

### JPEG 等の画像を EPS に変換する方法

既に手元にある JPEG，GIF，PNG 等の画像をそのまま EPS 画像に変換するには ImageMagick の
convert コマンドを使うと良いです．
例えば，`baz.jpg` を `foo.eps` に変換したい場合は，

    $ convert baz.jpg foo.eps

とします．
convert コマンドは画像の加工も行えますが，画像編集に関しては GIMP の方が扱いやすいです．

### JPEG 等の画像を編集して EPS に変換する方法

画像の編集が必要なときは GIMP を使うと良いでしょう．
コンソールで `$ gimp &` としても良いですし，アプリケーションのメニューから立ちあげても構いません．
使い方については各自調べて下さい．

### イラストを作る場合

ベクタ形式の画像を作る場合は Inkscape が良いです．
これも，コンソールで `$ inkscape &` としても良いですし，アプリケーションのメニューから立ちあげても構いません．
使い方については各自調べて下さい．

## 参考資料

LaTeX の文書作成に有用な（と思われる）資料です．

- [The Comprehensive LaTeX Symbol List (PDF)](http://www.tex.ac.uk/tex-archive/info/symbols/comprehensive/symbols-a4.pdf):
  LaTeX の記号が大量にリストアップされているので，必要な記号を探すのに良いです．
  PDF なので，ダウンロードしてすぐに参照できるようにしておくと良いでしょう．
- [日本語 LaTeX を使うときに注意するべきこと](http://www.math.tohoku.ac.jp/~kuroki/LaTeX/howtolatex.html):
  数式の体裁を整える方法について細かく書いてあって良いです．
- Beamer の使い方：一応，簡単な使い方は slide.tex に書いてありますが，
  詳しく知りたい人は，以下の資料に目を通してみて下さい．
  - [辻研究室 Beamer](http://neurodynamics.jp/etc/beamer):
    Beamer の機能についての説明が分かりやすくまとまっています．
    入門的な内容で，slide.tex と合わせて読むと理解が深まると思います．
  - [Beamer User Guide (PDF)](http://texdoc.net/texmf-dist/doc/latex/beamer/doc/beameruserguide.pdf):
    公式のドキュメントで，非常に詳細な情報が載っています．
- ソースコードの書き方：listings.sty を使いましょう（verbatim は融通が利かなくて大変不便です）．
  うまく設定すると専門書のような綺麗なソースコードが書けます．
  簡単な使い方は slide.tex に載っていますが，細かく体裁を整えたい場合は，以下の資料を読んでみて下さい．
  listings.sty は slide.tex でも paper.tex でもデフォルトで読み込まれるので，
  自分で `usepackage` する必要はありません．
  - [Listings - MyTeXpert](http://mytexpert.sourceforge.jp/index.php?Listings):
    `lstset` による体裁の設定の具体例が沢山載っています．
  - [The Listings Package](ftp://ftp.tex.ac.uk/tex-archive/macros/latex/contrib/listings/listings.pdf):
    公式のドキュメントで，非常に詳細な情報が載っています．
- アルゴリズム（擬似コード）の書き方：algorithmic.sty と algorithm.sty を使いましょう．
  ググると比較的分かりやすい Web ページが多数ヒットします．
  - [package for algorithms](http://www.cs.toronto.edu/~frank/Useful/algorithm2e.pdf):
    公式のドキュメント．
- 証明図や導出木の書き方：分数を書くための frac マクロで何とかするという手もありますが，
  綺麗な証明図を書くためのスタイルファイルが幾つかあります．
  好みの問題もあるので，どれが一番良いという事はないですが，
  最初はドキュメントの多い bussproofs.sty が良いと思います（でも，bussproofs は独特のインタフェースをしています）．
  - bussproofs.sty:
    証明図や導出木則を書くためのスタイルファイルです．
    どれくらいレイアウトの融通が利くのかよくわかりませんが，
    TeX コードの見た目としては，証明図系のスタイルファイルの中で最もシンプルで分かりやすいと思います．
    - [証明図は「bussproof.sty」にお任せ](http://kreisel.fam.cx/webmaster/clog/2011-05-05-1.html):
      入門として良いと思われる Web ページ．マクロの使い方が簡潔にまとまっている．
    - [LaTeX for Logicians, bussproofs.sty: A User Guide](http://get-software.net/macros/latex/contrib/bussproofs/BussGuide2.pdf):
      公式ドキュメント．
  - proofs.sty:
    これも，証明図や導出木則を書くためのスタイルファイルです．
    - [LaTeX for Logicians, proofs.sty: A User Guide](http://www.logicmatters.net/resources/ndexamples/proofsty.html):
      簡単に使い方がまとまっています．
    - [The proof package](http://ctan.mackichan.com/macros/latex/contrib/lkproof/lkproof-doc.pdf):
      公式ドキュメント．
  - bcprules.sty:
    あの Benjamin C. Pierce 先生が作った，証明図や導出木則を書くためのスタイルファイルです．
    公式のドキュメントが見当たらないのですが，使い方は難しくないようです．
    - [推論規則をレイアウトする bcprules.sty](http://d.hatena.ne.jp/eagletmt/20120111/1326251578):
      bcprules.sty の具体例が載っています．
