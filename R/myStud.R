myStudy<-function(xz,y=NULL,b3seq,model.base,mc.cores=1,Nsim=100,...) {
    if (!is.null(y)) {
        df<-data.frame(y=y,x=xz[,1],z=xz[,2])
        m<-model.base(df=df,fm=as.formula(y~x+z))
        b0<-coef(m)[1]
        b1<-coef(m)[2]
        b2<-coef(m)[3]
    } else {
        ##
    }
    p<-list()
    for (b3 in b3seq) {
        pv<-manyStudies(Nsim=Nsim,mc.cores=mc.cores,
                        b0=b0,b1=b1,b2=b2,b3=b3,
                        xz=xz,...
                        )
        p[[as.character(b3)]]<-summaryOfStudies(pv)
    }
    cbind(b3seq,unlist(p))
}


b1<-1
b2<-1
x<-rnorm(100)
z<-runif(100)
xz<-cbind(x,z)
##note no rho or N here
library(InteractionStudio)
gammaToY<-gammaToY_options("linear")
model.base<-model_options("linear",print=TRUE)
model<-model_options("linear",print=FALSE)
y<-b1*x+b2*z+rnorm(length(x))

p<-myStudy(xz=xz,y=y,
           b3seq=seq(0,.5,by=.05),
           Nsim=300,
           gammaToY=gammaToY,
           model.base=model.base,
           model=model
           )	    
plot(p,type='b')
