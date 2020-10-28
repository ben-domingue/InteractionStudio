summaryOfStudies<-function(p,
                           alpha=0.05
                           ) {
    sig<-ifelse(p<alpha,1,0)
    mean(sig)
}
