\name{manyStudies}
\alias{manyStudies}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A wrapper for \code{studyInteraction}
}
\description{
This performs many calls to \code{studyInteraction}. These are done
sequentially or in parallel depending on value of \code{cores}
}
\usage{
manyStudies(Nsim = 100, cores = 1, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Nsim}{
    Number of desired simulations.
}
  \item{cores}{
    Number of cores. If greater than 1, work done in parallel.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
function (Nsim = 100, cores = 1, ...) 
{
    dummy <- rep(1, Nsim)
    if (cores > 1) {
        library(parallel)
        pv <- unlist(mclapply(dummy, studyInteraction, mc.cores = cores, 
            ...))
    }
    else unlist(lapply(dummy, studyInteraction, ...))
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
