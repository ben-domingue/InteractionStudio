\name{studyInteraction}
\alias{studyInteraction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Base function for simulating data and studying interaction coefficient.
}
\description{
Based on inputs, this simulates data and performs analysis (using
\code{model}) on an interaction model.
}
\usage{
studyInteraction(dummy.index, b0 = 0, b1, b2, b3 = 0, rho = 0.3, N = 1000, gammaToY, model, xz = NULL, transformY = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dummy.index}{
Ignore, used for parallelizing.
}
  \item{b0}{
See definition of gamma below.
}
  \item{b1}{
See definition of gamma below.
}
  \item{b2}{
See definition of gamma below.
}
  \item{b3}{
See definition of gamma below.
}
  \item{rho}{
Correlation of two predictors.
}
  \item{N}{
Sample size
}
  \item{gammaToY}{
Function describing how to convert gamma to an outcome. See also \code{gammaToY_options}.
}
  \item{model}{
Function that describes an analysis and returns a p-value. See also \code{model_options}.
}
  \item{xz}{
Nx2 data matrix. If passed, \code{N} and \code{rho} are ignored.
}
  \item{transformY}{
Optional means of transforming outcome.
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
function (dummy.index, b0 = 0, b1, b2, b3 = 0, rho = 0.3, N = 1000, 
    gammaToY, model, xz = NULL, transformY = NULL, ...) 
{
    if (is.null(xz)) {
        library(MASS)
        xz <- mvrnorm(N, mu = c(0, 0), Sigma = matrix(c(1, rho, 
            rho, 1), 2, 2))
    }
    x <- xz[, 1]
    z <- xz[, 2]
    gamma <- b0 + b1 * x + b2 * z + b3 * x * z
    y <- gammaToY(gamma)
    if (!is.null(transformY)) 
        y <- transformY(y)
    df <- data.frame(y = y, x = x, z = z)
    fm <- as.formula("y~x+z+x*z")
    model(df = df, fm = fm)
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
