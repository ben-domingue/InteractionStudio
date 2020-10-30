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


