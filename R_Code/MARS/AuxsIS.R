##########################################################################
# Workflows
# define several workflows for applying the different resampling strategies for regression tasks
##########################################################################


WFnone_earth_nk10_d1 <- function(form, train, test, learner){ # workflow for using the original data set
  preds <- do.call(paste('cv', learner, sep='.'),
                   list(form, train, test, nk=10, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFnone_earth_nk10_d2 <- function(form, train, test, learner){ # workflow for using the original data set
  preds <- do.call(paste('cv', learner, sep='.'),
                   list(form, train, test, nk=10, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFnone_earth_nk17_d1 <- function(form, train, test, learner){ # workflow for using the original data set
  preds <- do.call(paste('cv', learner, sep='.'),
                   list(form, train, test, nk=17, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFnone_earth_nk17_d2 <- function(form, train, test, learner){ # workflow for using the original data set
  preds <- do.call(paste('cv', learner, sep='.'),
                   list(form, train, test, nk=17, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}





WFRU_earth_nk10_d1 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandUnderRegress(form, train, rel=rel, thr.rel=thr.rel, C.perc=C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFRU_earth_nk10_d2 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandUnderRegress(form, train, rel=rel, thr.rel=thr.rel, C.perc=C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFRU_earth_nk17_d1 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandUnderRegress(form, train, rel=rel, thr.rel=thr.rel, C.perc=C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFRU_earth_nk17_d2 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandUnderRegress(form, train, rel=rel, thr.rel=thr.rel, C.perc=C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFRO_earth_nk10_d1 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandOverRegress(form, train, rel, thr.rel, C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFRO_earth_nk10_d2 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandOverRegress(form, train, rel, thr.rel, C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFRO_earth_nk17_d1 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandOverRegress(form, train, rel, thr.rel, C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFRO_earth_nk17_d2 <- function(form, train, test, learner, rel=rel, thr.rel=thr.rel, C.perc=C.perc, ...){
  newtr <- RandOverRegress(form, train, rel, thr.rel, C.perc)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}



WFGN_earth_nk10_d1 <- function(form, train, test, learner, rel, thr.rel, C.perc, pert, ...){
  newtr <- GaussNoiseRegress(form, train, rel, thr.rel, C.perc, pert)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFGN_earth_nk10_d2 <- function(form, train, test, learner, rel, thr.rel, C.perc, pert, ...){
  newtr <- GaussNoiseRegress(form, train, rel, thr.rel, C.perc, pert)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFGN_earth_nk17_d1 <- function(form, train, test, learner, rel, thr.rel, C.perc, pert, ...){
  newtr <- GaussNoiseRegress(form, train, rel, thr.rel, C.perc, pert)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFGN_earth_nk17_d2 <- function(form, train, test, learner, rel, thr.rel, C.perc, pert, ...){
  newtr <- GaussNoiseRegress(form, train, rel, thr.rel, C.perc, pert)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFsmote_earth_nk10_d1 <- function(form, train, test, learner, rel, thr.rel, C.perc, k, repl, dist, p, ...){
  newtr <- SmoteRegress(form, train, rel, thr.rel, C.perc, k, repl, dist, p)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFsmote_earth_nk10_d2 <- function(form, train, test, learner, rel, thr.rel, C.perc, k, repl, dist, p, ...){
  newtr <- SmoteRegress(form, train, rel, thr.rel, C.perc, k, repl, dist, p)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFsmote_earth_nk17_d1 <- function(form, train, test, learner, rel, thr.rel, C.perc, k, repl, dist, p, ...){
  newtr <- SmoteRegress(form, train, rel, thr.rel, C.perc, k, repl, dist, p)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFsmote_earth_nk17_d2 <- function(form, train, test, learner, rel, thr.rel, C.perc, k, repl, dist, p, ...){
  newtr <- SmoteRegress(form, train, rel, thr.rel, C.perc, k, repl, dist, p)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}



WFIS_earth_nk10_d1 <- function(form, train, test, learner, rel, O, U, ...){
  newtr <- ImpSampRegress(form, train, rel=rel, thr.rel=NA, O, U)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=10, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFIS_earth_nk10_d2 <- function(form, train, test, learner, rel, O, U, ...){
  newtr <- ImpSampRegress(form, train, rel=rel, thr.rel=NA, O, U)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, train, test, nk=10, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


WFIS_earth_nk17_d1 <- function(form, train, test, learner, rel, O, U, ...){
  newtr <- ImpSampRegress(form, train, rel=rel, thr.rel=NA, O, U)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=1, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}

WFIS_earth_nk17_d2 <- function(form, train, test, learner, rel, O, U, ...){
  newtr <- ImpSampRegress(form, train, rel=rel, thr.rel=NA, O, U)
  preds <- do.call(paste('cv',learner,sep='.'),
                   list(form, newtr, test, nk=17, degree=2, thresh=0.01))
  WFoutput(rownames(test),responseValues(form,test),preds)
}


# define the learn/test functions for the systems


cv.lm<- function(form, train,test,...) {
  m <- lm(form, train,...)
  li <- m$xlevels
  for(i in 1:length(names(li))){
    m$xlevels[[names(li)[i]]] <- union(m$xlevels[[names(li)[i]]], levels(test[,names(li)[i]]))
  }
  predict(m,test, interval="none")
}

cv.svm <- function(form,train,test,...) {
  m <- svm(form,train,...)
  predict(m,test)
}
cv.randomForest <- function(form,train,test,...) {
  m <- randomForest(form,train,...)
  predict(m,test)
}

cv.earth <- function(form,train,test,...) {
  m <- earth(form,train,...)
  predict(m,test)[,1]
}

cv.nnet <- function(form, train, test,...){
  m <- nnet(form,train,...)
  predict(m, test)[,1]
}


# ============================================================
# EVALUATION STATISTICS
# metrics definition for the estimation task
# ============================================================

eval.stats <- function(trues,preds, stats, thr.rel, method,npts,control.pts,ymin,ymax,tloss,epsilon) {
  pc <- list()
  pc$method <- method
  pc$npts <- npts
  pc$control.pts <- control.pts
  lossF.args <- list()
  lossF.args$ymin <- ymin
  lossF.args$ymax <- ymax
  lossF.args$tloss <- tloss
  lossF.args$epsilon <- epsilon
  
  ubaprec <- util(preds,trues,pc,lossF.args,util.control(umetric="P", event.thr=thr.rel))
  ubarec  <- util(preds,trues,pc,lossF.args,util.control(umetric="R", event.thr=thr.rel))
  ubaF   <- util(preds,trues,pc,lossF.args,util.control(umetric="Fm",beta=1, event.thr=thr.rel))
  
  c(ubaF=ubaF,ubaprec=ubaprec,ubarec=ubarec)
}
