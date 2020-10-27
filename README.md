##
# InteractionStudio

The basic workflow for a single `studyInteraction` is as follows:
1. Input key simulation parameters (`b1,b2,b3,N,rho`).
2. Use those parameters to generate `gamma`. 
3. Use `gamma` to generate `y` based on the `gammaToY` function (see `GammaToY_options` but it's also straightforward to specify your own function). 
4. If requested, `y` is then transformed via `transformY`. 
5. Estimate a simple interaction model based on `model` (see `model_options`). 
The `manyStudies` function is a wrapper that will perform many such simulation studies. 

Let's look at an example based on simple linear regression:

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
```
Note that false discovery here is basically 0.05 which is as it should be given that this is the level of alpha. 

Let's look at a slightly more complex example. Here we'll work in a logistic regression context:
```
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
Note that power is relatively good here given that b3 is relatively large. 
