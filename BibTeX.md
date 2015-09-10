# 参考文献の書き方

LaTeX において、参考文献を書くときは、BibTeX を使うようにしましょう。
論文テンプレートでは、デフォルトで BibTeX を使うようになっています。
BibTeX を使うと、論文中で参照されている参考文献を、
`refs.bib` の中から自動的に選択して、論文に埋め込んでくれます。
また、参考文献の書式も整えてくれるので、便利です。
（`thebibliography` 環境を使って、自力で書式を整える方法もありますが、
発表時にミスを指摘されることが多いです。BibTeX を使うのが無難です。）

参考文献は `refs.bib` に追加しましょう。
「文献の著者(or 題名) + bibtex」でググると、大抵は BibTeX の書き方が出てくるので、
それを流用するといいでしょう。

## DBLP を使う

「論文題目 + bibtex + dblp」や「著者名 + bibtex + dblp」でググると、
文献の BibTeX データを入手できます。DBLP は計算機科学系の参考文献データベースで、
大量の論文が登録されているので、それなりの確率で目的の BibTeX データが手に入ります。
DBLP の BibTeX データは比較的信頼できますが、ときどき間違っているので、
書き換えのポイントを説明しておきます。

### 1. 固有名詞の頭を大文字にする

固有名詞の中で大文字になるべき文字が小文字になっていることが多いです
（例えば、OCaml が ocaml になっていたり、GADT が gadt になっていたりなど）。
BibTeX は文献題目などの先頭以外の文字を勝手に小文字に変換するので、
大文字にしたいところを明示的に `{...}` で囲む必要があることに、注意して下さい。
例えば、

    @article{...,
      author = {John Smith},
      title  = {Functional programming in OCaml},
      ...}

と書いてあった場合、参考文献のタイトルが "Functional programming in ocaml" になってしまうので、

    @article{...,
      author = {John Smith},
      title  = {Functional programming in {OC}aml},
      ...}

と書き直します。
ちなみに、大文字になる文字・文字列のみをピンポイントで囲むのが美しいやり方とされています。

### 2. 参照の削除

DBLP はあくまでデータベースなので、論文自体と論文が掲載された書籍や雑誌の情報を、
別々に掲載していることがあります。例えば、以下の論文は、関数型プログラミング言語
[ATS](http://www.ats-lang.org/) に関するものですが、DBLP では、
次のように、論文と論文集が別々に記述されています。

http://dblp.uni-trier.de/rec/bibtex/conf/frocos/CuiDX05

    @inproceedings{DBLP:conf/frocos/CuiDX05,
      author    = {Sa Cui and
                   Kevin Donnelly and
                   Hongwei Xi},
      title     = {{ATS}: A Language That Combines Programming with Theorem Proving},
      booktitle = {FroCoS},
      year      = {2005},
      pages     = {310-320},
      ee        = {http://dx.doi.org/10.1007/11559306_19},
      crossref  = {DBLP:conf/frocos/2005},
      bibsource = {DBLP, http://dblp.uni-trier.de}
    }

    @proceedings{DBLP:conf/frocos/2005,
      editor    = {Bernhard Gramlich},
      title     = {Frontiers of Combining Systems, 5th International Workshop,
                   FroCoS 2005, Vienna, Austria, September 19-21, 2005, Proceedings},
      booktitle = {FroCoS},
      publisher = {Springer},
      series    = {Lecture Notes in Computer Science},
      volume    = {3717},
      year      = {2005},
      isbn      = {3-540-29051-6},
      bibsource = {DBLP, http://dblp.uni-trier.de}
    }

`@inproceedings` が参照したい論文で、`@proceedings` はその論文が掲載されている論文集です。
この場合、そのまま `refs.bib` に書くと、参考文献として2つのエントリができてしまい、見苦しいので、
うまく情報をマージする必要があります。
`@proceedings` は大した情報を含んでいないので、`@inproceedings` の `crossref` の行を削除するだけで良いでしょう。
マージの仕方がわからない場合は、担当の教員に質問して下さい。

## URL を参考文献に載せる

論文になっていないライブラリを参考文献にしたいときなどは、
自力で URL を参考文献に追加する必要があります。
このときは、

    @misc{ID,
      author={著者の名前},
      title={タイトル},
      howpublished={\url{http://...}},
      year={20XX}}

のようなエントリを、`resf.bib` に追加します。
`ID` は `paper.tex` から参照するときの名前（識別子）で、参照するときは `\cite{ID}` のようにします。
例えば、

    @misc{lib:JaneStreetCore,
      author={Jane Street},
      title={{J}ane {S}treet {C}ore},
      howpublished={\url{http://janestreet.github.io/}},
      year={2014}}

であれば、`\cite{lib:JaneStreeCore}` で参照できます
（`{...}` で囲むと大文字になります）。
