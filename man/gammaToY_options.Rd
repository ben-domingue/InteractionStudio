\name{gammaToY_options}
\alias{gammaToY_options}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function used to generate \code{y} from gamma. 
}
\description{
This contains some common approaches for generating \code{y} from
gamma. 
}
\usage{
gammaToY_options(nm, pars = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nm}{
    Name of the desired specification.
  }
  \item{pars}{
    Additional parameters required for specification of \code{y}, see below.
  }
}
\details{
  There are several pre-specified ways of transforming gamma to \code{y}
  based on different values of \code{nm}.
  \itemize{
    \item \code{linear} performs a linear transformation where \code{pars}
  is the SD of the error term. That is, \code{y} is simulated as normal
  with mean gamma and SD \code{pars}.
  \item \code{logistic} performs a logistic transformation to generate a
  binary outcome (\code{pars}
  is ignored).
  \item \code{poisson} performs an exponential transformation to
  generate a count outcome (\code{pars}
  is ignored).
  \item \code{ordinal} simulates ordinal data using the cumulative link
  model. \code{pars} is a vector of step parameters.
  }
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
function (nm, pars = NULL) 
{
    if (nm == "linear") {
        if (is.null(pars)) 
            sig.sd <- 1
        else sig.sd <- pars
        gammaToY <- function(x) x + rnorm(length(x), sd = sig.sd)
    }
    if (nm == "logistic") {
        gammaToY <- function(x) {
            k <- exp(x)
            p <- k/(1 + k)
            rbinom(length(p), 1, p)
        }
    }
    if (nm == "poisson") {
        gammaToY <- function(x) {
            y <- exp(x)
            rpois(length(y), y)
        }
    }
    if (nm == "ordinal") {
        if (!is.null(pars)) 
            theta <- pars
        else theta <- sort(rnorm(3))
        gammaToY <- function(x) {
            J <- (length(theta) + 1)
            N <- length(x)
            p <- matrix(0, nrow = N, ncol = J)
            sigma <- function(z) 1/(1 + exp(-z))
            for (j in 1:(J - 1)) {
                tmp <- theta[j] - x
                p[, j] <- sigma(tmp)
            }
            cum.p <- p
            for (j in 2:(J - 1)) p[, j] <- cum.p[, j] - cum.p[, 
                (j - 1)]
            p[, J] <- 1 - rowSums(p)
            y <- numeric()
            for (ii in 1:N) {
                v <- rmultinom(1, 1, p[ii, ])
                y[ii] <- which(v == 1)
            }
            factor(y)
        }
    }
    gammaToY
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
