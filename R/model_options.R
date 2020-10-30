model_options<-function(nm,print=FALSE) {
    if (nm=="linear") {
        model<-function(df,fm) {
            m<-lm(fm,df)
            m
        }
    }
    if (nm=="logistic") {
        model<-function(df,fm) {
            m<-glm(fm,df,family="binomial")
            m
        }
    }
    if (nm=="poisson") {
        model<-function(df,fm) {
            m<-glm(fm,df,family="poisson")
            m
        }
    }
    if (nm=="ordinal") {
        model<-function(df,fm) {
            library(ordinal)
            m<-clm(fm,data=df)
            m
        }
    }
    ##
    if (print) {
        m2<-function(df,fm) {
            m<-model(df,fm)
            summary(m)
        }
    } else {
        m2<-function(df,fm) {
            m<-model(df,fm)
            co<-summary(m)$coef
            iii<-grep("x:z",rownames(co))
            co[iii,4]
        }
    }
    m2
}
