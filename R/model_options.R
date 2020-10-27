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
    ##
    model
}
