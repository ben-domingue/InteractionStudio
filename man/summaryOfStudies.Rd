\name{summaryOfStudies}
\alias{summaryOfStudies}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute proportion of significant findings
}
\description{
Generates the level of positive (i.e., significant) findings for a
specified alpha level for an object returned by \code{manyStudies}. When
\code{b3} is 0, this will be the false discovery rate. When
\code{b3} is not zero, this will be the statistical power.
}
\usage{
summaryOfStudies(p, alpha = 0.05)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{p}{
    Object returned by \code{manyStudies}.
}
  \item{alpha}{
    Level of alpha used to judge significance.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (p, alpha = 0.05) 
{
    sig <- ifelse(p < alpha, 1, 0)
    mean(sig)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
