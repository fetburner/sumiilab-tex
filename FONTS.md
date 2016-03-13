# フォント関連の Tips

## 英語フォントの変更

`\usepackage{DejaVuSerif}` などのように、主要なフォントについては
デフォルトフォントの変更とフォントの埋め込みの両方を行うスタイルファイルが用意されている。
TeX Live で最初からインストールされているものもあれば、別途インストールが必要なものもある。
具体的なフォントの見た目とパッケージは http://www.tug.dk/FontCatalogue/ で探すと良い。
LaTeX ではローマン体 (`\textrm`, `\rmfamily`)、サンセリフ体 (`\textsf`, `\sffamily`)、
タイプライタ体 (`\texttt`, `\ttfamily`) の 3 種類のフォントを使い分けて文書を作ることが一般的だが、
これらのスタイルファイルは 3 種類のうちいずれか 1 つを変更するものが多い。例えば、

- `\usepackage{DejaVuSerif}`（ローマン体のみ変更）
- `\usepackage{DejaVuSans}`（サンセリフ体のみ変更）
- `\usepackage{DejaVuSansMono}`（タイプライタ体のみ変更）

など。
日本語が多い論文やスライドで英字フォントだけを入れ替えるメリットは薄いと思うが、
プログラム（ソースコード）用のタイプライタ体において

- より視認性の高いフォントを使いたい
- 太文字を使いたい
- 横幅の狭いフォントでソースコード（の見た目）を圧縮し、より多くのコードを狭い場所に書きたい

といった要求を満たすために、英字フォントを変更することは有用である。

### 複数の書体の使い分け（多書体化）

もしかしたら、複数のタイプライタ・フォントやサンセリフ・フォントを混在させたい、
という欲望に駆られるかもしれない：

- 複数のプログラミング言語（OCaml と SML や対象言語とメタ言語など）を扱うため、
  言語ごとにフォントを変えたい
- 対話環境に入力したコードと対話環境の応答でフォントを変えたい

上手に使い分けないと、かえって可読性が落ちるためお勧めはしない。
ここで紹介する方法はどうしても複数の書体の使い分けが必要であるときに限定して使うべきである。

フォントの変更は `\fontfamily` と `\selectfont` という 2 つのマクロを使って、

    {\fontfamily{FONT-CODE}\selectfont サンプルテキスト}

とすることで実現できる。「サンプルテキスト」の部分は `FONT-CODE` で
指定されたフォントで表示される。例えば、

    {\fontfamily{pcr}\selectfont Hello, World! This is Courier.}

とすると、`Hello, World! This is Courier.` は Courier (`FONT-CODE` = `pcr`) で表示される。
主なフォントコードは
[Font typefaces - Reference guide](https://ja.sharelatex.com/learn/Font_typefaces#Reference_guide)
で調べることができる。

## 日本語フォントの変更

私が使ってきた Linux ディストリビューションのデフォルト設定では、
LaTeX をコンパイルしてできる PDF には
「何のフォントも埋め込まれない」か「IPA/IPAex フォントが埋め込まれる」場合が多い。
しかし、何も埋め込まない場合は異なる環境で正しく表示されるか不安であり、
IPA フォントだと太文字が使えないので不便である。
本節では自分の好きなフォントを PDF に埋め込む方法について解説する。

なお、フォントを埋め込んだ PDF ファイルを配布（他人が閲覧・ダウンロード可能な
状態に）することは「フォントの再配布」である。
フォントのライセンスを熟読の上、PDF ファイルへの埋め込みや再配布が許可されているか、
再配布の条件・制約（例えばクレジット表示の有無など）があるか自分で確認すること。

### ヒラギノ・小塚・モリサワ・游・MS フォントの埋め込み

これらのフォントの埋め込みについては、
https://texwiki.texjp.org/?TeX%20Live%2FMac#i9febc9b が詳しい。
上記の方法で失敗もしくはヒラギノ等のフォントを持っていない場合は、
次節を参照されたし。

### それ以外のフォントの埋め込み

英語フォントと異なり、日本語フォントのスタイルファイルは用意されていないことが多い。
自分で作ることも原理的には可能であるが、複雑で難しく、初心者にはお勧めできない。
もっと簡単な方法は XeLaTeX や LuaLaTeX のような先進的な LaTeX 処理系を使うことであり、
これらには .ttf や .otf フォントを面倒な設定なしに読み込む機能が搭載されている。
スライドとポスターについて LuaLaTeX で
[MigMix 1P](http://mix-mplus-ipa.osdn.jp/migmix/) フォントを埋め込むサンプルを
このリポジトリの [lualatex ブランチ](https://github.com/akabe/sumiilab-tex/tree/lualatex)
にアップしてあるので、参考にすると良い。

- [lualatex/slide/slide.pdf](https://github.com/akabe/sumiilab-tex/blob/lualatex/slide/slide.pdf)
- [lualatex/poster/poster.pdf](https://github.com/akabe/sumiilab-tex/blob/lualatex/poster/poster.pdf)
