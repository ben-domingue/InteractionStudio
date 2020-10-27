model_options<-function(nm) {
    if (nm=="linear") {
        model<-function(df,fm) {
            m<-lm(fm,df)
            summary(m)$coef[4,4]
        }
    }
    if (nm=="logistic") {
        model<-function(df,fm) {
            m<-glm(fm,df,family="binomial")
            summary(m)$coef[4,4]
        }
    }
    if (nm=="poisson") {
        model<-function(df,fm) {
            m<-glm(fm,df,family="poisson")
            summary(m)$coef[4,4]
        }
    }
    if (nm=="ordinal") {
        model<-function(df,fm) {
            library(ordinal)
            m<-clm(fm,data=df)
            co<-summary(m)$coef
            iii<-grep("x:z",rownames(co))
            co[iii,4]
        }
    }
    ##
    model
}
