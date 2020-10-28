\name{model_options}
\alias{model_options}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Helper function that specifies several common models.
}
\description{
See \code{gammaToY_options}.
}
\usage{
model_options(nm)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nm}{
%%     ~~Describe \code{nm} here~~
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
function (nm) 
{
    if (nm == "linear") {
        model <- function(df, fm) {
            m <- lm(fm, df)
            summary(m)$coef[4, 4]
        }
    }
    if (nm == "logistic") {
        model <- function(df, fm) {
            m <- glm(fm, df, family = "binomial")
            summary(m)$coef[4, 4]
        }
    }
    if (nm == "poisson") {
        model <- function(df, fm) {
            m <- glm(fm, df, family = "poisson")
            summary(m)$coef[4, 4]
        }
    }
    if (nm == "ordinal") {
        model <- function(df, fm) {
            library(ordinal)
            m <- clm(fm, data = df)
            co <- summary(m)$coef
            iii <- grep("x:z", rownames(co))
            co[iii, 4]
        }
    }
    model
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
