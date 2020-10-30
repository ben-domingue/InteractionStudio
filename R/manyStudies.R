manyStudies<-function(Nsim=100,
                      cores=1,
                      ...) {
    dummy<-rep(1,Nsim)
    if (cores>1) {
        library(parallel)
        pv<-unlist(mclapply(dummy,studyInteraction,mc.cores=cores,...))
    } else pv<-unlist(lapply(dummy,studyInteraction,...))
    pv
}
