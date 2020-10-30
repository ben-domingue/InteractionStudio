studyInteraction<-function(dummy.index=NA,
                           b0=0,b1,b2,b3=0,rho=0.3,N=1000,
                           gammaToY,
                           model,
                           xz=NULL,
                           sim_xz=NULL,
                           transformY=NULL,
                           ...) {
    if (is.null(xz)) {
        if (is.null(sim_xz)) {
            library(MASS)
            xz<-mvrnorm(N,mu=c(0,0),Sigma=matrix(c(1,rho,rho,1),2,2))
        } else xz<-sim_xz(N,rho)
    } else {
        index<-sample(1:nrow(xz),nrow(xz),replace=TRUE)
        xz<-xz[index,]
    }
    x<-xz[,1]
    z<-xz[,2]
    gamma<-b0+b1*x+b2*z+b3*x*z
    y<-gammaToY(gamma)
    if (!is.null(transformY)) y<-transformY(y)
    df<-data.frame(y=y,x=x,z=z)
    fm<-as.formula("y~x+z+x*z")
    model(df=df,fm=fm)
}

