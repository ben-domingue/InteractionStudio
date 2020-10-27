##
# InteractionStudio

```
b1<-1
b2<-1
b3<-0
rho<-.3
N<-1000
library(InteractionStudio)
##linear, b3=0
gammaToY<-gammaToY_options("linear")
model<-model_options("linear")
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model)
sum(p<.05)/length(p) #false discovery, should be close to 0.05

b3<-0.5
rho<-.3
N<-1000
##logistic, b3>0
gammaToY<-gammaToY_options("logistic")
model<-model_options("logistic")
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model)
sum(p<.05)/length(p) #power, should be close to 1

```
