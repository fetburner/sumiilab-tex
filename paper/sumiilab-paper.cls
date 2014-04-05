%%
%% 住井研究室のステキな論文クラスファイル
%%

\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{sumiilab-paper}
  [2014/2/27 aabe]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options
\newif\if@draft
\DeclareOption{draft}{\@drafttrue}
\DeclareOption{final}{\@draftfalse}

\def\slp@class{jreport}
\DeclareOption{uplatex}{\gdef\slp@class{ujreport}}

\def\slp@ptsize{11pt}
\DeclareOption{10pt}{\def\slp@ptsize{10pt}}
\DeclareOption{11pt}{\def\slp@ptsize{11pt}}
\DeclareOption{12pt}{\def\slp@ptsize{12pt}}

\ExecuteOptions{final,11pt}
\ProcessOptions

\LoadClass[a4j,\slp@ptsize%
\if@draft ,draft\else ,final\fi%
]{\slp@class}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 目次レベル
\setcounter{tocdepth}{1}
%% bibliography
\renewcommand{\bibname}{参考文献}
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
\gdef\@abstractname{要旨}
\gdef\@supervisorname{指導教員}
\gdef\@subsupervisorname{論文指導教員}

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
      {\LARGE%
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
