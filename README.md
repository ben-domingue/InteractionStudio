##
# InteractionStudio


b1<-1
b2<-1
b3<-0
rho<-.3
N<-1000

gammaToY<-function(x) x+rnorm(length(x),sd=1)

model<-function(df,fm) {
    m<-lm(fm,df)
    summary(m)$coef[4,4]
}

##vanilla
library(InteractionStudio)
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model)
sum(p<.05)/length(p) #should be approx 0.05

