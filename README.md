##
# InteractionStudio

This R package is meant to conduct analysis to guide statistical inference (via information about FDR and power) in study of interactions. Using a common set of data-generating parameters (those used to define `gamma` as described below), the package simulates data and estimates interaction models. These simulations are summarized via analysis of the p-value of the interaction terms. Crucially, the package allows users to specify a range of outcome variables, transformations of those variables, and different approaches for estimation. It is straightforward to write simple funtions for each of these and common choices for outcome variables and estimation models can be used via the `gammaToY_options` and `model_options` functions.

The basic workflow for a single `studyInteraction` is as follows:
1. Input key simulation parameters (`b0,b1,b2,b3,N,rho`). 
2. Use those parameters to generate `gamma`. Using N and rho, we first simulate predictors `x` and `z` that are each of length `N` and with a correlation of `rho`. We then set `gamma=b0+b1*x+b2*z+b3*x*z`. Simulation of the outcome will be based on `gamma` and ancillary parameters, `pars`.
3. Use `gamma` to generate `y` based on the `gammaToY` function (see `GammaToY_options` but it's also straightforward to specify your own function). 
4. [Optional] If requested, `y` is then transformed via `transformY`. 
5. Estimate a simple interaction model based on `model` (see `model_options`). 

The `manyStudies` function is a wrapper that will perform many such simulation studies. 

Let's look at an example based on simple linear regression:

```
##linear, b3=0
b1<-1
b2<-1
b3<-0
rho<-.3
N<-1000
library(InteractionStudio)
gammaToY<-gammaToY_options("linear")
model<-model_options("linear")
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model)
summaryOfStudies(p) #false discovery, should be close to 0.05
```
Note that false discovery here is basically 0.05 which is as it should be given that this is the level of alpha. 

Let's look at a slightly more complex example. Here we'll work in a logistic regression context:
```
##logistic, b3>0
b3<-0.5
rho<-.3
N<-1000
library(InteractionStudio)
gammaToY<-gammaToY_options("logistic")
model<-model_options("logistic")
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model)
summaryOfStudies(p) #power, should be close to unity
```
Note that power is relatively good here given that b3 is relatively large. 

We can also look at analysis of an ordinal outcome.
```
##logistic, b3>0
b3<-0.2
rho<-.3
N<-1000
library(InteractionStudio)
gammaToY<-gammaToY_options("ordinal")
model<-model_options("logistic")
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model)
summaryOfStudies(p) #power, not great!
```

Going back to where we started, we can also invoke transformations of the outcome `y` that may need to be considered. For example, what if `y` is measured on a scale with a ceiling or a floor (i.e., y is censored)? We can conduct such an analysis via:
```
##floor, b3=0
b1<-1
b2<-1
b3<-0
rho<-.3
N<-1000
library(InteractionStudio)
gammaToY<-gammaToY_options("linear")
transformY<-function(y) {
  y<-(y-mean(y,na.rm=TRUE))/sd(y,na.rm=TRUE)
  ifelse(y< -2,-2,y)
}
model<-model_options("linear")
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model,
	    transformY=transformY)
summaryOfStudies(p) #false discovery, note that we have a real problem here
```

In an emprirical use case, it might not be immediately obvious what parameter values should be of interest. As a starting point, we suggest using `model` with a main-effects only `fm`. To do this for a model implemented in `model_options`, you can use the `print` flag as shown below.
```
x<-rnorm(1000)
z<-rnorm(1000)
y<-x+z+rnorm(length(x))
library(InteractionStudio)
model<-model_options("linear",print=TRUE)
S<-model(data.frame(y=y,x=x,z=z),fm=as.formula(y~x+z))
```
In this case, simulation studies may want to focus on estimates from `S`.

Oftentimes, interest resides in one continuous and one dichotomous predictor. Users can study such settings by directly passing a function to simulate such data via `sim_xz`. An example:
```
b1<-1
b2<-1
b3<-.05
rho<-.3
N<-1000
library(InteractionStudio)
gammaToY<-gammaToY_options("linear")
model<-model_options("linear")
sim_xz<-function(N,rho) {
  library(MASS)
  xz<-mvrnorm(N,mu=c(0,0),Sigma=matrix(c(1,rho,rho,1),2,2))
  xz[,2]<-ifelse(xz[,2]>0,1,0)
  xz
}
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model,
	    sim_xz=sim_xz
	    )
summaryOfStudies(p) #false discovery, should be close to 0.05
#power substantially reduced compared to
p<-manyStudies(Nsim=1000,
            b1=b1,b2=b2,b3=b3,rho=rho,gammaToY=gammaToY,model=model
	    #sim_xz=sim_xz #xz will be multivariate normal
	    )
summaryOfStudies(p) #false discovery, should be close to 0.05
