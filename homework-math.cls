\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework-math}[2022/06/28 Math homework class]

%%% DEFAULTS %%%
\def\@true{1}
\def\@false{0}

\def\@subtitle{}
\def\@contact{}
\def\@author{}
\def\@title{}
\def\@titlecolor{black}%

\newcommand\@hmgeometry\@true
\newcommand\@hmcountbyexercises\@true

\newcommand\@hmtinyfont{cmbxsl10}
\newcommand\@hmlargefont{cmbxsl22}
\newcommand\@hmsmallfont{cmbxsl14}

%%% OPTIONS %%%

\DeclareOption{iPad}{%
	\renewcommand\@hmlargefont{cmbxsl10}
	\renewcommand\@hmsmallfont{cmbxsl10}
}%

\DeclareOption{nogeometry}{%
	\renewcommand\@hmgeometry\@false
}%

\DeclareOption{countbysections}{%
	\renewcommand\@hmcountbyexercises\@false
}%

\ProcessOptions\relax
\LoadClass{article}

%%% DEPENDENCIES %%%
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}% 
\RequirePackage{graphicx}
\RequirePackage{tikz,tikz-cd}
\usetikzlibrary{%
  shapes, arrows, calc, positioning, shapes.geometric,%
  decorations.pathreplacing, decorations.markings, mindmap%
}%
\RequirePackage{mathtools}
\RequirePackage{amsthm,amsmath,amssymb}
\RequirePackage{gensymb}
\RequirePackage{faktor}
\RequirePackage{stackengine}
\RequirePackage{hyperref}
\RequirePackage[shortcuts]{extdash}
\RequirePackage{setspace}
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}
% Add this package to count the number of exercises in the document.
\RequirePackage{totcount}
\RequirePackage{tocloft}
\if\@hmgeometry\@true
	\RequirePackage[margin=1in]{geometry}%
\fi

%%% FONTS %%%

\font\tinyslbf=\@hmtinyfont
\font\tenslbf=\@hmlargefont
\font\smallslbf=\@hmsmallfont

\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}

%%% DOCUMENT SETUP %%%

%% Setup

\onehalfspacing%
\setlength{\cftbeforesecskip}{1pt}

% header commands are called at the end to give a chance for the user to load
% the geometry package, which must be loaded before headers are defined
\AtEndPreamble{%
  \pagestyle{fancy}
  \rhead{\textit\@subtitle}
  \lhead{\textit\@title}
  \cfoot{\thepage}
}%

\definecolor{IlliniBlue}{RGB}{19,41,75}
\gdef\@titlecolor{IlliniBlue}

\newcounter{exctr}
\setcounter{exctr}{0}
\regtotcounter{exctr}
\renewcommand\theexctr{\arabic{exctr}}%

\newcounter{sectionrulechecker}
\newcommand{\nosectionrule}{\setcounter{sectionrulechecker}{1}}
\setcounter{sectionrulechecker}{0}

\newcounter{specialboxctr}
\setcounter{specialboxctr}{0}

\if\@hmcountbyexercises\@true
	\renewcommand\theequation{\theexctr.\arabic{equation}}%
	\renewcommand\thespecialboxctr{\arabic{exctr}.\arabic{specialboxctr}}%
\else
	\renewcommand\theequation{\thesection.\arabic{equation}}%
	\renewcommand\thespecialboxctr{\thesection.\arabic{specialboxctr}}%
\fi

%% Document methods %%
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\contact#1{\gdef\@contact{#1}}
\def\titlecolor#1{\gdef\@titlecolor{#1}}%
\edef\measurepage{\dimexpr\pagegoal-\pagetotal-\baselineskip\relax}

\providecommand{\smalltableofcontents}{%
	\singlespacing%
	\centerline{%
		\begin{minipage}[c]{0.65\linewidth}%
			\small
			\tableofcontents%
		\end{minipage}%
		\onehalfspacing%
	}%
}%

\renewcommand{\maketitle}{{%
  \thispagestyle{plain} % surpress header on first page
  \color{\@titlecolor}%
  {\noindent{\smallslbf{\@title}}}
  \quad
  {\smallslbf{\@subtitle}}
  \hfill{\color{darkgray}\large\textit\@author}
  \smallskip
  \hrule
  \smallskip
  {%
	  {\color{darkgray}\noindent\textit{\@date}\hfill\textit{\@contact}}
  }%
  \bigbreak
}}%

\newcommand{\makecenteredtitle}{{%
	\thispagestyle{plain}%
	\color{\@titlecolor}%
	{\hspace*{\fill}\smallslbf{\@title}\hspace*{\fill}}
	\smallskip
	\hrule
	\smallskip
	{%
		{%
			\color{darkgray}%
			\noindent\textit{\@subtitle}%
			\hfill%
			\textit{\@author~(\@contact)}%
			\hfill%
			\textit{\@date}%
		}%
	}%
	\bigbreak
}}%

% Maintain compatibility with typewriter-math
\providecommand\makehomeworktitle{\maketitle}

%%% FORMATTING METHODS %%%

% Section delimiter using circular dots.
\providecommand{\dhorline}[3][0]{%
    \tikz[baseline]{\path[decoration={markings,
      mark=between positions 0 and 1 step 2*#3
      with {\node[fill, circle, minimum width=#3, inner sep=0pt, anchor=south west] {};}},postaction={decorate}]  (0,#1) -- ++(#2,0);}}
	
\def\sectionrule{%
  \par
	\vskip \baselineskip
	\cleaders\vbox{\noindent\hspace*{\fill}\mbox{\dhorline{5em}{3pt}}\hspace*{\fill}}%
	\vskip 0.5em
	\nointerlineskip %
	\vskip \baselineskip
}%

\newenvironment{indented}{%
  \par%
  \medskip
  \leftskip=4em\rightskip=2em%
  \noindent\ignorespaces}{%
  \par\medskip
}

%%% ABBREVIATIONS %%%
% For declaring objects in a category (in a Haskell-like manner)
\providecommand{\catin}{\mathrel{::}}

\providecommand{\ul}[1]{\underline{#1}}
\providecommand{\hw}[1]{\widehat{#1}}
\providecommand{\bvec}[1]{\overrightarrow{#1}}

% Groupings macros.
\providecommand{\fb}[1]{{\left[#1\right]}}
\providecommand{\pwrap}[1]{{\left(#1\right)}}
\providecommand{\bwrap}[1]{{\left\{#1\right\}}}
\providecommand{\abs}[1]{{\left|#1\right|}}
\providecommand{\norm}[1]{{\left\|#1\right\|}}
\providecommand{\brak}[1]{{\left\langle#1\right\rangle}}

\providecommand\restr[2]{{% we make the whole thing an ordinary symbol
   \left.\kern-\nulldelimiterspace % automatically resize the bar with \right
    #1 % the function
    \vphantom{\big| } % pretend it's a little taller at normal size
    \right|_{#2} % this is the delimiter
}}

\providecommand{\eqdef}{\overset{\normalfont{\text{def}}}{=}}
\providecommand{\equivdef}{\overset{\normalfont{\text{def}}}{\equiv}}

\renewcommand{\leq}{\leqslant}
\renewcommand{\geq}{\geqslant}

% fg for "function group"
\providecommand{\fg}[2]{{#2}^{\scalebox{0.75}{#1}}}
\providecommand{\minisub}[2]{#1_{\scalebox{0.65}{#2}}}
\providecommand{\id}{\mathsf{id}}

\DeclareMathOperator{\Dom}{Dom}
\DeclareMathOperator{\dom}{dom}
\DeclareMathOperator{\Range}{Range}
\DeclareMathOperator{\Hom}{\normalfont{\text{Hom}}}
\DeclareMathOperator{\Sub}{\normalfont{\text{Sub}}}

\providecommand{\expo}[1]{{%
  \text{\normalfont{exp}}\left(#1\right)%
}}%

\providecommand{\interior}[1]{{#1\degree}}
\providecommand{\closure}[1]{{\lbar{#1}}}

\DeclareRobustCommand{\actson}{\mathrel{\rotatebox[origin=c]{90}{\(\curvearrowleft\)}}}

\providecommand{\ep}{\varepsilon}
\providecommand{\R}{\mathbb{R}}
\providecommand{\N}{\mathbb{N}}
\providecommand{\Q}{\mathbb{Q}}
\providecommand{\C}{\mathbb{C}}
\providecommand{\Z}{\mathbb{Z}}
\providecommand\op{{\mathsf{op}}}

\providecommand\cdsquare[8]{%
  \begin{tikzcd}[ampersand replacement=\&]%
    #1 \arrow[r,"#2"] \arrow[d,"#4"] \& #3 \arrow[d,"#5"]\\
    #6 \arrow[r,"#7"] \& #8
  \end{tikzcd}%
}%

\providecommand\cdlift[6]{%
  \begin{tikzcd}[ampersand replacement=\&]%
    \& #5 \arrow[d,"#6"] \\
    #1 \arrow[r,"#2"] \arrow[ur,"#4",dashed] \& #3
  \end{tikzcd}%
}%

\providecommand\cddescend[6]{%
  \begin{tikzcd}[ampersand replacement=\&]%
    #1 \arrow[r,"#2"] \arrow[dr,"#6",dashed] \& #3 \arrow[d,"#4"]\\
    \& #5
  \end{tikzcd}%
}%

% Based on
% https://davidyat.es/2016/07/27/writing-a-latex-macro-that-takes-a-variable-number-of-arguments/
\newcommand\cycle[1]{%
	\begin{psmallmatrix}%
		#1\@cyclechecknextarg}
\newcommand{\@cyclechecknextarg}{\@ifnextchar\bgroup{\@cyclegobblenextarg}{%
	\end{psmallmatrix} }}
\newcommand{\@cyclegobblenextarg}[1]{ & #1 \@ifnextchar\bgroup{\@cyclegobblenextarg}{%
	\end{psmallmatrix} }}

\def\comment#1{{\color{magenta} [#1]}}

\newenvironment{exercise}[1][]{%
\refstepcounter{exctr}%
\setcounter{sectionrulechecker}{0}
\label{ex:\theexctr}%
\addcontentsline{toc}{section}{Exercise \theexctr~#1}%
\noindent\textbf{Exercise \theexctr~#1:~}%
}%
{%
	\ifnum\theexctr<\totvalue{exctr} %
		\ifnum\value{sectionrulechecker}<1 %
			\sectionrule
		\fi%
	\fi%
}%

\newenvironment{exercise*}{%
\noindent\textbf{Exercise:}%
}%
{%
\sectionrule
}%

\newenvironment{exercise-like}[2][Exercise]{%
	\refstepcounter{exctr}%
	\setcounter{sectionrulechecker}{0}
	\label{ex:\theexctr}%
	\addcontentsline{toc}{section}{Exercise \theexctr~#2}%
	\noindent\textbf{#1 \theexctr~#2:~}%
}%
{%
	\ifnum\theexctr<\totvalue{exctr} %
		\ifnum\value{sectionrulechecker}<1 %
			\sectionrule
		\fi%
	\fi%
}%

\newenvironment{centered-exercise-like}[3][Exercise]{%
	\refstepcounter{exctr}%
	\setcounter{sectionrulechecker}{0}
	\label{ex:\theexctr}%
	\addcontentsline{toc}{section}{#1 \theexctr~#2}%
	\def\temp{#2}\ifx\temp\empty
		\begin{center}%
				\fontsize{11}{11}\selectfont%
				\textbf{#1 \theexctr}%
		\end{center}%
	\else
		\begin{center}%
			\fontsize{11}{11}\selectfont%
			\textbf{#1 \theexctr:~#2}%
		\end{center}%
	\fi
	\nobreak
	#3
	\par
	\medskip
}%
{%
	\ifnum\theexctr<\totvalue{exctr} %
		\ifnum\value{sectionrulechecker}<1 %
			\sectionrule
		\fi%
	\fi%
}%

\newenvironment{last_exercise}[1][]{%
\refstepcounter{exctr}%
\label{ex:\theexctr}%
\addcontentsline{toc}{section}{Exercise \theexctr~#1}%
\noindent\textbf{Exercise \theexctr~#1:~}%
}%
{%
\par\vspace{\baselineskip}
}%
\newenvironment{last_exercise*}{%
\noindent\textbf{Exercise:}%
}%
{%
\par\vspace{\baselineskip}
}%

% Box macros.

\providecommand\boxhrule{\tcblower}%

\newenvironment{warning_box}[1]{%
	\refstepcounter{specialboxctr}%
	\begin{tcolorbox}[title={#1 \thespecialboxctr},colframe=\@titlecolor]
}%
{%
	\end{tcolorbox}%
}%

\newenvironment{blockcomment}[1][Comment]{%
	\refstepcounter{specialboxctr}%
	\begin{tcolorbox}[title={#1 \thespecialboxctr},colframe=magenta]
}%
{%
	\end{tcolorbox}%
}%

\newenvironment{warning_box*}{%
	\begin{tcolorbox}[colframe=\@titlecolor]
}%
{%
	\end{tcolorbox}%
}%

% New theorem-like environments
% These will be typeset in italics
\if\@hmcountbyexercises\@true
	\newtheorem{theorem}{Theorem}[exctr]%
\else
	\newtheorem{theorem}{Theorem}[section]%
\fi
\newtheorem*{theorem*}{Theorem}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem*{proposition*}{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem*{lemma*}{Lemma}
\newtheorem{claim}[theorem]{Claim}
\newtheorem*{claim*}{Claim}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem*{corollary*}{Corollary}
\newtheorem{remark}[theorem]{Remark}
\newtheorem*{remark*}{Remark}
\newtheorem{question}[theorem]{Question}
\newtheorem*{question*}{Question}
\newtheorem{researchquestion}[theorem]{Further Research}
\newtheorem*{researchquestion*}{Further Research}
\newtheorem{mathrule}[theorem]{Rule}

% These will be typeset in Roman
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem*{definition*}{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem*{example*}{Example}
\newtheorem{fact}[theorem]{Fact}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem*{conjecture*}{Conjecture}
\newtheorem{definitionprop}[theorem]{Definition/Proposition}
\newtheorem*{definitionprop*}{Definition/Proposition}
\newtheorem{bigremark}[theorem]{Remark}
\newtheorem*{bigremark*}{Remark}

