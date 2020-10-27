gammaToY_options<-function(nm,pars=NULL) {
    if (nm=="linear") {
        if (is.null(pars)) sig.sd<-1 else sig.sd<-pars
        gammaToY<-function(x,...) x+rnorm(length(x),sd=sig.sd)
    }
    if (nm=="logistic") {
        gammaToY<-function(x) {
            k<-exp(x)
            p<-k/(1+k)
            rbinom(length(p),1,p)
        }
    }
    if (nm=="poisson") {
        gammaToY<-function(x) {
            y<-exp(x)
            rpois(length(y),y)
        }
    }
    ##
    gammaToY
}
