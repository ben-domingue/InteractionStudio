gammaToY_options<-function(nm,pars=NULL) {
    if (nm=="linear") {
        if (is.null(pars)) sig.sd<-1 else sig.sd<-pars
        gammaToY<-function(x) x+rnorm(length(x),sd=sig.sd)
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
    if (nm=="ordinal") {
        if (!is.null(pars)) theta<-pars else theta<-sort(rnorm(3))
        gammaToY<-function(x) {
            J<-(length(theta)+1)
            N<-length(x)
            p<-matrix(0,nrow=N,ncol=J)
            sigma<-function(z) 1/(1+exp(-z))
            for (j in 1:(J-1)) {
                tmp<-theta[j]-x
                p[,j]<-sigma(tmp)
            }
            cum.p<-p
            for (j in 2:(J-1))  p[,j]<-cum.p[,j]-cum.p[,(j-1)]
            p[,J]<-1-rowSums(p)
            y<-numeric()
            for (ii in 1:N) {
                v<-rmultinom(1,1,p[ii,])
                y[ii]<-which(v==1)
            }
            factor(y)
        }
    }
    ##
    gammaToY
}
