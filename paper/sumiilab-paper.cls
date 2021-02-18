%%
%% 住井研究室のステキな論文クラスファイル
%%

\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{sumiilab-paper}[2014/4/20 aabe]

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

\newif\if@uplatex\@uplatexfalse
\DeclareOption{uplatex}{\@uplatextrue}

\newif\if@notheorems\@notheoremsfalse
\def\slp@theoremstyle{plain}
\DeclareOption{notheorems}{\@notheoremstrue}
\DeclareOption{theoremstyle=plain}{\gdef\slp@theoremstyle{plain}}
\DeclareOption{theoremstyle=break}{\gdef\slp@theoremstyle{break}}
\DeclareOption{theoremstyle=change}{\gdef\slp@theoremstyle{change}}
\DeclareOption{theoremstyle=changebreak}{\gdef\slp@theoremstyle{changebreak}}
\DeclareOption{theoremstyle=margin}{\gdef\slp@theoremstyle{margin}}
\DeclareOption{theoremstyle=marginbreak}{\gdef\slp@theoremstyle{marginbreak}}

\newif\if@nolistings\@nolistingsfalse
\DeclareOption{nolistings}{\@nolistingstrue}

\ExecuteOptions{japanese,final,11pt}
\ProcessOptions

\LoadClass[\slp@ptsize%
\if@draft ,draft\else ,final\fi%
\if@japanese ,a4j,report\if@uplatex ,uplatex\fi\fi%
]{\if@japanese jsbook\else report\fi}

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
\newcommand{\venue}[1]{\gdef\@venue{#1}}

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
      \@date\\\@venue% date and venue
    }\end{center}
  \end{titlepage}}

%% \paragraphのスタイル
\if@twocolumn
  \renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {\z@}{-1zw}% 改行せず 1zw のアキ
    {\normalfont\normalsize\headfont}}
\else
  \renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {0.5\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
    {-1zw}% 改行せず 1zw のアキ
    {\normalfont\normalsize\headfont}}
\fi

%% ===============================================
%% Theorems
%% ===============================================

%% \if@notheorems\else
%%   \usepackage{theorem}
%%   \theoremstyle{\slp@theoremstyle}

%%   \let\thm@newtheorem=\newtheorem% The original \newtheorem of theorem.sty
%%   \renewcommand{\newtheorem}{\@ifstar\@@newtheorem\@newtheorem}% frontend
%%   \newcommand{\@newtheorem}[2]{\thm@newtheorem{#1}[theorem]{#2}}
%%   \newcommand{\@@newtheorem}[2]{% starred \newtheorem
%%     \thm@newtheorem{#1}{#2}%
%%     \expandafter\gdef\csname the#1\endcsname{}}

%%   \newcommand{\both@newtheorem}[2]{%
%%     \newtheorem{#1}{#2}%
%%     \newtheorem*{#1*}{#2}}

%%   \if@japanese%% JAPANESE
%%     \theorembodyfont{\normalfont}
%%     \thm@newtheorem{theorem}{定理}[chapter]
%%     \both@newtheorem{lemma}{補題}
%%     \both@newtheorem{corollary}{系}
%%     \both@newtheorem{proposition}{命題}
%%     \both@newtheorem{definition}{定義}
%%     \both@newtheorem{example}{例}
%%     \both@newtheorem{assumption}{仮定}
%%     \both@newtheorem{axiom}{公理}
%%     \both@newtheorem{proof}{証明}
%%   \else%% ENGLISH
%%     \thm@newtheorem{theorem}{Theorem}[chapter]
%%     \both@newtheorem{lemma}{Lemma}
%%     \both@newtheorem{corollary}{Corollary}
%%     \both@newtheorem{proposition}{Proposition}
%%     \both@newtheorem{definition}{Definition}
%%     \both@newtheorem{example}{Example}
%%     \both@newtheorem{assumption}{Assumption}
%%     \both@newtheorem{axiom}{Axiom}
%%     \both@newtheorem{proof}{Proof}
%%   \fi
%%   \newcommand{\qed}{\hfill $\Box$}
%% \fi

%% ===============================================
%% Listings
%% ===============================================

%% \if@nolistings\else
%%   \usepackage{listings}
%%   \if@japanese
%%     \usepackage{jlisting}
%%   \fi
%% \fi
