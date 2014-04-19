%%
%% 住井研究室のステキな論文クラスファイル
%%

\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{sumiilab-paper}
  [2014/2/27 aabe]

%% ===============================================
%% Options
%% ===============================================

\newif\if@japanese
\DeclareOption{japanese}{\@japanesetrue}
\DeclareOption{english}{\@japanesefalse}

\def\slp@ptsize{11pt}
\DeclareOption{10pt}{\def\slp@ptsize{10pt}}
\DeclareOption{11pt}{\def\slp@ptsize{11pt}}
\DeclareOption{12pt}{\def\slp@ptsize{12pt}}

\newif\if@draft
\DeclareOption{draft}{\@drafttrue}
\DeclareOption{final}{\@draftfalse}

\def\slp@jclass{jreport}
\DeclareOption{uplatex}{\gdef\slp@jclass{ujreport}}

\newif\if@deftheorem\@deftheoremtrue
\def\slp@theoremstyle{plain}
\DeclareOption{theorem=no}{\@deftheoremfalse}
\DeclareOption{theorem=plain}{\gdef\slp@theoremstyle{plain}}
\DeclareOption{theorem=break}{\gdef\slp@theoremstyle{break}}
\DeclareOption{theorem=margin}{\gdef\slp@theoremstyle{margin}}
\DeclareOption{theorem=marginbreak}{\gdef\slp@theoremstyle{marginbreak}}

\newif\if@sharedthmnum
\DeclareOption{sharedthmnum}{\@sharedthmnumtrue}

\ExecuteOptions{japanese,final,11pt}
\ProcessOptions

\LoadClass[a4j,\slp@ptsize%
\if@draft ,draft\else ,final\fi%
]{\if@japanese\slp@jclass\else report\fi}

%% ===============================================
%% Style
%% ===============================================

%% 目次レベル
\setcounter{tocdepth}{1}
%% footnote
\renewcommand{\thefootnote}{*\arabic{footnote}}

\newcommand{\paper}[1]{\gdef\@paper{#1}}
\newcommand{\institute}[1]{\gdef\@institute{#1}}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\subsupervisor}[1]{\gdef\@subsupervisor{#1}}
\newcommand{\supervisorname}[1]{\gdef\@supervisorname{#1}}
\newcommand{\subsupervisorname}[1]{\gdef\@subsupervisorname{#1}}

\renewenvironment{abstract}{\chapter*{\@abstractname}}{}

\global\let\@subsupervisor\@empty
\if@japanese
  \renewcommand{\bibname}{参考文献}
  \gdef\@abstractname{要旨}
  \gdef\@supervisorname{指導教員}
  \gdef\@subsupervisorname{論文指導教員}
\else
  \renewcommand{\bibname}{Bibliography}
  \gdef\@abstractname{Abstract}
  \gdef\@supervisorname{Supervisor}
  \gdef\@subsupervisorname{Subsupervisor}
\fi

%% タイトル囲み枠の横幅
\newlength{\titleboxwidth}
\setlength{\titleboxwidth}{0.9\textwidth}
%% タイトル囲み枠の上下余白
\newlength{\titleboxsep}
\setlength{\titleboxsep}{7mm}
%% titlepage の要素の縦方向間隔
\newlength{\slp@tpvsep}
\setlength{\slp@tpvsep}{1.5\baselineskip}

%% titlepage
\renewcommand{\maketitle}{%
  \begin{titlepage}%
    \begin{center}
      {\large
      \vskip40mm
      \@paper% paper
      \vskip\slp@tpvsep
      {\Large%
        \addtolength{\titleboxsep}{-\baselineskip}%
        \tabcolsep=0pt%
        \fboxsep=0pt%
        \framebox[\titleboxwidth][c]{% titlebox
          \begin{tabular}{c}\\[\titleboxsep]\@title\\\\[\titleboxsep]\end{tabular}}}
      \vskip\slp@tpvsep
      \@institute% institute
      \vskip\slp@tpvsep
      \@author% author
      \vskip\slp@tpvsep
      \begin{tabular}{r@{~:~}l}
        \@supervisorname & \@supervisor\\% supervisor
        \ifx\@subsupervisor\@empty\else
        \@subsupervisorname & \@subsupervisor% subsupervisor
        \fi
      \end{tabular}
      \vskip\slp@tpvsep
      \@date% date
    }\end{center}
  \end{titlepage}}

%% ===============================================
%% Theorems
%% ===============================================

\if@deftheorem
  \usepackage{theorem}
  \theoremstyle{\slp@theoremstyle}

  \let\slp@newtheorem=\newtheorem
  \renewcommand{\newtheorem}[2]{%
    \if@sharedthmnum%
      \slp@newtheorem{#1}[theorem]{#2}%
    \else%
      \slp@newtheorem{#1}{#2}[chapter]%
    \fi}

  \if@japanese%% JAPANESE
    \theorembodyfont{\normalfont}
    \slp@newtheorem{theorem}{定理}[chapter]
    \newtheorem{lemma}{補題}
    \newtheorem{corollary}{系}
    \newtheorem{proposition}{命題}
    \newtheorem{definition}{定義}
    \newtheorem{example}{例}
    \newtheorem{assumption}{仮定}
    \newtheorem{axiom}{公理}
    \newtheorem{proof}{証明}
  \else%% ENGLISH
    \slp@newtheorem{theorem}{Theorem}[chapter]
    \newtheorem{lemma}{Lemma}
    \newtheorem{corollary}{Corollary}
    \newtheorem{proposition}{Proposition}
    \newtheorem{definition}{Definition}
    \newtheorem{example}{Example}
    \newtheorem{assumption}{Assumption}
    \newtheorem{axiom}{Axiom}
    \newtheorem{proof}{Proof}
  \fi
  \newcommand{\qed}{\hfill $\Box$}
\fi
