# 住井・松田研究室のステキな TeX ファイルたち

[東北大学 住井・松田研究室](http://www.sf.ecei.tohoku.ac.jp/)
（工学部 電気情報物理工学科、大学院 情報科学研究科）
で使うかもしれない便利な LaTeX ファイルを公開しています。

- `paper/`: 論文のクラスファイルとサンプルファイル
- `slide/`: プレゼンテーション用の beamer サンプルファイル
- `poster/`: 学会ポスター用の beamer サンプルファイル

ちなみに、文字コードは全て UTF-8 です。
EUC-JP 派の人は `nkf --euc` などで文字コードを変換してから使いましょう。

環境構築については [こちら](INSTALL.md) を参照して下さい。

## スライドの書き方

まず、次の一連のコマンドを実行して、`slide.pdf` が作れるか確認しましょう。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/slide/
    $ make

きっと、カレントディレクトリには slide.pdf というスライドの PDF ファイルが
出来上がっていることでしょう。

    $ ls
    Makefile slide.pdf ...

PDF ファイルをちゃんと表示できれば成功です。

    $ evince slide.pdf &

evince は Debian に標準でインストールされているドキュメント・ビューアで、
tex ファイルを再コンパイルしたときに、勝手にリロードして、表示を更新してくれるので便利です。
もしも、日本語が文字化けしたりして、うまく表示できないときは、純正の Adobe Reader を使いましょう。

    $ acroread slide.pdf &

もし、純正の Adobe Reader でも文字化けするようなら、フォントの設定がおかしいか、
うまくインストールできなかった可能性があります。ググるか、詳しい人に聞いて直しましょう。
（Adobe Reader は Adobe の公式 Web ページからダウンロードしてきた、.bin ファイルに
`chmod a+x ***.bin` でパーミッションを与えた後、`./***.bin` でインストールできます。）

slide.tex を改造すれば、スライドが作れます。
コンパイルは `make` でできます。

※ 論文とは違って、スライドに関しては特定のフォーマットが決められているわけではありません。
好きに改造してもらって結構です。
（Power Point で作っても構いませんし、自信があるなら、スライドを使わずに、板書だけで説明しても OK です。）

以下は良いスライド、良い発表のコツです。
あくまで、学生が勝手にまとめただけの内容なので、あまり参考にならないかもしれません。

- 発表するとき、発表者であるあなたは内容について熟知していますが、聞いている人にとっては初見の内容かもしれません。
  専門用語はちゃんと説明しましょう。難しい用語や概念は直感的理解や具体例を述べた後に、
  形式的な定義を話すと理解されやすいです。
- スライドを作るときは、そのページで「何を説明したいか？」「どんなことを伝えたいか？」といった、
  説明の目的・目標を意識すると良いです。
  関係のない複数の内容を1つのページにまとめて書いたりすると、聞いてる人は混乱してしまいます。
- 関係のない項目や種類の違う項目を1つの箇条書きの中に収めたり、意味もなく矢印を使ったりするのも、
  聞き手を混乱させる原因になります。
- 他人の論文を読んで、その内容について発表するときは、論文と全く同じ順序で説明をする必要はありません。
  むしろ、解りやすくなるように、説明の順序を入れ替えたほうが、より良い発表になります。
  普通、論文では論理の筋道が通るように、記号や関数、定理や補題は使う前に定義をしています。
  しかし、口頭発表において同じ順序で説明すると、聞いている人は「その関数何に使うの？」といった疑問を持つことが多いです。
  また、議論の大筋と関係のない記号等の定義が続くと、聞いている人は話の流れを見失ってしまいます。
  発表するときは、議論の筋道が聴衆に伝わるように説明すると良いです。
  （例えば、議論の大筋と重要な関係がないような記号の定義などは、必要になったら説明する、など。）
- アイディアなどを説明するための具体例は、無闇に複雑なものだと、聴衆に内容が伝わらない可能性があります。
  説明したい項目や概念を予め考えて（列挙して）おいて、それを最小限に含むような具体例を作ると良いです。
- 幾つかの項目や概念を順番に説明したい時には、必要な情報を一気に見せるのではなく、
  必要になった時に表示するほうが効果的です。最初から、全ての情報を見せると、
  発表者が「今現在説明している内容」の理解に必要な情報と、
  「これから（未来に）話す内容」の理解に必要な情報が混在してしまい、
  聴衆はどこに注目して話を聞けば良いかわからなくなります。
  アニメーション等を使ったり、スライドを分けるなどして、未来に必要になる情報を隠しておくと良いです。
  （ただし、アニメーションといっても、非常に簡素なものに留めたほうが良いです。）

## 論文の書き方

次の一連のコマンドを実行します。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/paper/
    $ make

きっと、カレントディレクトリには paper.pdf という論文の PDF ファイルが
出来上がっていることでしょう。
Adobe Reader (acroread) や evince で、ちゃんと表示できれば成功です。

paper.tex はクラスファイルの使用例を兼ねたテンプレートです。
これを改造すれば論文が書けます。
（論文クラスファイル自体の機能については [PAPER.md](PAPER.md) を参照して下さい。）

ぜひ、ステキな論文を書いて下さい。

## ポスターの書き方

次の一連のコマンドを実行します。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex/poster/
    $ make

きっと、カレントディレクトリには poster.pdf という論文の PDF ファイルが
出来上がっていることでしょう。
Adobe Reader (acroread) や evince で、ちゃんと表示できれば成功です。

poster.tex はクラスファイルの使用例を兼ねたテンプレートです。
これを改造すればポスターが作れます。
詳しい使い方は説明しませんが、
https://github.com/akabe/ppl2016 などを参考にして下さい。

ぜひ、ステキなポスターを作って下さい。

## その他

以下の補助資料は、必要なときに読むと良いかもしれません。

- [参考文献の書き方](CITATION.md):
 スライド・論文における参考文献の書き方について書いてあります。
- [EPS 画像の作り方](EPSImages.md):
  LaTeX の文章に画像を入れるときは、EPS 形式を扱うことが多いです。
  普段あまり使わない画像形式なので、作り方を解説しておきます。
- [Git を使った LaTeX ファイルの管理](Git.md):
  Git を使って LaTeX ファイルを管理する方法について書いてあります。
  指導教員と論文の最新版を共有し、同時期に編集したい、という時に便利です。
  投稿論文を書くときに必要になるかもしれません。

## 参考資料

LaTeX の文書作成に有用な（と思われる）資料です。

- [Detexify](http://detexify.kirelabs.org/classify.html)
  手書き文字から LaTeX の記号を探してくれるツールです。
  記号の出し方がわからない時は、これを使って探しましょう。
- [The Comprehensive LaTeX Symbol List (PDF)](http://www.tex.ac.uk/tex-archive/info/symbols/comprehensive/symbols-a4.pdf):
  LaTeX の記号が大量にリストアップされている PDF ファイルです。
- [日本語 LaTeX を使うときに注意するべきこと](http://www.math.tohoku.ac.jp/~kuroki/LaTeX/howtolatex.html):
  数式の体裁を整える方法について細かく書いてあって良いです。
- Beamer の使い方：一応、簡単な使い方は slide.tex に書いてありますが、
  詳しく知りたい人は、以下の資料に目を通してみて下さい。
  - [辻研究室 Beamer](http://neurodynamics.jp/etc/beamer):
    Beamer の機能についての説明が分かりやすくまとまっています。
    入門的な内容で、slide.tex と合わせて読むと理解が深まると思います。
  - [Beamer User Guide (PDF)](http://texdoc.net/texmf-dist/doc/latex/beamer/doc/beameruserguide.pdf):
    公式のドキュメントで、非常に詳細な情報が載っています。
- ソースコードの書き方：listings.sty を使いましょう（verbatim は融通が利かなくて大変不便です）。
  うまく設定すると専門書のような綺麗なソースコードが書けます。
  簡単な使い方は slide.tex に載っていますが、細かく体裁を整えたい場合は、以下の資料を読んでみて下さい。
  listings.sty は slide.tex でも paper.tex でもデフォルトで読み込まれるので、
  自分で `usepackage` する必要はありません。
  - [Listings - MyTeXpert](http://mytexpert.sourceforge.jp/index.php?Listings):
    `lstset` による体裁の設定の具体例が沢山載っています。
  - The Listings Package ( ftp://ftp.tex.ac.uk/tex-archive/macros/latex/contrib/listings/listings.pdf ):
    公式のドキュメントで、非常に詳細な情報が載っています。
- アルゴリズム（擬似コード）の書き方：algorithmic.sty と algorithm.sty を使いましょう。
  ググると比較的分かりやすい Web ページが多数ヒットします。
  - [package for algorithms](http://www.cs.toronto.edu/~frank/Useful/algorithm2e.pdf):
    公式のドキュメント。
- 証明図や導出木の書き方：分数を書くための frac マクロで何とかするという手もありますが、
  綺麗な証明図を書くためのスタイルファイルが幾つかあります。
  好みの問題もあるので、どれが一番良いという事はないですが、
  最初はドキュメントの多い bussproofs.sty が良いと思います（でも、bussproofs は独特のインタフェースをしています）。
  - bussproofs.sty:
    証明図や導出木則を書くためのスタイルファイルです。
    どれくらいレイアウトの融通が利くのかよくわかりませんが、
    TeX コードの見た目としては、証明図系のスタイルファイルの中で最もシンプルで分かりやすいと思います。
    - [証明図は「bussproof.sty」にお任せ](http://kreisel.fam.cx/webmaster/clog/2011-05-05-1.html):
      入門として良いと思われる Web ページ。マクロの使い方が簡潔にまとまっている。
    - [LaTeX for Logicians, bussproofs.sty: A User Guide](http://get-software.net/macros/latex/contrib/bussproofs/BussGuide2.pdf):
      公式ドキュメント。
  - proofs.sty:
    これも、証明図や導出木則を書くためのスタイルファイルです。
    - [LaTeX for Logicians, proofs.sty: A User Guide](http://www.logicmatters.net/resources/ndexamples/proofsty.html):
      簡単に使い方がまとまっています。
    - [The proof package](http://ctan.mackichan.com/macros/latex/contrib/lkproof/lkproof-doc.pdf):
      公式ドキュメント。
  - bcprules.sty:
    あの Benjamin C. Pierce 先生が作った、証明図や導出木則を書くためのスタイルファイルです。
    公式のドキュメントが見当たらないのですが、使い方は難しくないようです。
    - [推論規則をレイアウトする bcprules.sty](http://d.hatena.ne.jp/eagletmt/20120111/1326251578):
      bcprules.sty の具体例が載っています。
