library(UBL)
library(uba)
library(performanceEstimation)

library(e1071)         # for the svm
library(randomForest)  # randomForest
library(earth)         # MARS reimplementation
library(nnet)          # neural networks

source("AuxsIS.R")

##########################################################################
# load the datasets
##########################################################################

load("DataSets15.Rdata")


PCSall <- list()
#########################################################################
# to generate information about the data sets for a given threshold
#########################################################################

for(d in 1:15)
{
  y <- resp(DSs[[d]]@formula,DSs[[d]]@data)
  pc <- phi.control(y, method="extremes")
  lossF.args <- loss.control(y)
  PCSall[[d]] <- list(pc, lossF.args)
}

thr.rel=0.8
for(d in 1:15){
  form <- DSs[[d]]@formula
  data <- DSs[[d]]@data
  y <- resp(form,data)
  pc <- list()
  pc$method <- PCSall[[d]][[1]][[1]]
  pc$npts <- PCSall[[d]][[1]][[2]]
  pc$control.pts <- PCSall[[d]][[1]][[3]]
  both <- all(pc$control.pts[c(2,8)] == c(1,1))
  y.relev <- phi(y,pc)
  total <- 0
  if (both) {  # we have both low and high extrs
    rare.low <- which(y.relev > thr.rel & y < pc$control.pts[4])
    rare.high <- which(y.relev > thr.rel & y > pc$control.pts[4])
    rare.cases <- c(rare.low,rare.high)
    total <- length(rare.cases)
  } else {
    # the indexes of the cases with rare target variable values
    rare.cases <- if (pc$control.pts[2] == 1)  which(y.relev > thr.rel & y < pc$control.pts[4]) else which(y.relev > thr.rel & y > pc$control.pts[4])
    total <- length(rare.cases)
  }
  
  if(both){
    b <- 2
  }else {b <- 1 } 
}

PCS <- list(PCSall[[1]], PCSall[[2]],PCSall[[3]], PCSall[[4]],PCSall[[5]],
            PCSall[[6]],PCSall[[7]],PCSall[[8]], PCSall[[9]], PCSall[[10]], 
            PCSall[[11]], PCSall[[12]], PCSall[[13]], PCSall[[14]], PCSall[[15]])

myDSs <- list(PredTask(a1~., DSs[[1]]@data, "a1"), PredTask(a2~., DSs[[2]]@data, "a2"),
              PredTask(a3~., DSs[[3]]@data, "a3"), PredTask(a4~., DSs[[4]]@data, "a4"),
              PredTask(a6~., DSs[[5]]@data, "a6"), PredTask(a7~., DSs[[6]]@data, "a7"),
              PredTask(Rings~., DSs[[7]]@data, "Abalone"),
              PredTask(acceleration~., DSs[[8]]@data, "acceleration"),
              PredTask(available.power~., DSs[[9]]@data, "availPwr"),
              PredTask(rej~., DSs[[10]]@data, "bank8FM"), PredTask(usr~., DSs[[11]]@data, "cpuSm"),
              PredTask(fuel.consumption.country~., DSs[[12]]@data, "fuelCons"),
              PredTask(heat~., DSs[[13]]@data, "heat"), 
              PredTask(HousValue~., DSs[[14]]@data, "boston"), 
              PredTask(maximal.torque~.,DSs[[15]]@data, "maxTorque"))


##########################################################################
# learners and estimation procedure
##########################################################################

 WFs <- list()
WFs$randomForest <- list(learner.pars=list(mtry=c(5,7),
                                           ntree=c(500,750,1500)))

# exps with 2 times 10 fold CV

CVsetts <- list(EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[1]][[1]][[1]], 
                                                   npts=PCS[[1]][[1]][[2]], 
                                                   control.pts=PCS[[1]][[1]][[3]], 
                                                   ymin=PCS[[1]][[2]][[1]], 
                                                   ymax=PCS[[1]][[2]][[2]], 
                                                   tloss=PCS[[1]][[2]][[3]], 
                                                   epsilon=PCS[[1]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[2]][[1]][[1]], 
                                                   npts=PCS[[2]][[1]][[2]], 
                                                   control.pts=PCS[[2]][[1]][[3]], 
                                                   ymin=PCS[[2]][[2]][[1]], 
                                                   ymax=PCS[[2]][[2]][[2]], 
                                                   tloss=PCS[[2]][[2]][[3]], 
                                                   epsilon=PCS[[2]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[3]][[1]][[1]], 
                                                   npts=PCS[[3]][[1]][[2]], 
                                                   control.pts=PCS[[3]][[1]][[3]], 
                                                   ymin=PCS[[3]][[2]][[1]], 
                                                   ymax=PCS[[3]][[2]][[2]], 
                                                   tloss=PCS[[3]][[2]][[3]], 
                                                   epsilon=PCS[[3]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[4]][[1]][[1]], 
                                                   npts=PCS[[4]][[1]][[2]], 
                                                   control.pts=PCS[[4]][[1]][[3]], 
                                                   ymin=PCS[[4]][[2]][[1]], 
                                                   ymax=PCS[[4]][[2]][[2]], 
                                                   tloss=PCS[[4]][[2]][[3]], 
                                                   epsilon=PCS[[4]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[5]][[1]][[1]], 
                                                   npts=PCS[[5]][[1]][[2]], 
                                                   control.pts=PCS[[5]][[1]][[3]], 
                                                   ymin=PCS[[5]][[2]][[1]], 
                                                   ymax=PCS[[5]][[2]][[2]], 
                                                   tloss=PCS[[5]][[2]][[3]], 
                                                   epsilon=PCS[[5]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[6]][[1]][[1]], 
                                                   npts=PCS[[6]][[1]][[2]], 
                                                   control.pts=PCS[[6]][[1]][[3]], 
                                                   ymin=PCS[[6]][[2]][[1]], 
                                                   ymax=PCS[[6]][[2]][[2]], 
                                                   tloss=PCS[[6]][[2]][[3]], 
                                                   epsilon=PCS[[6]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[7]][[1]][[1]], 
                                                   npts=PCS[[7]][[1]][[2]], 
                                                   control.pts=PCS[[7]][[1]][[3]], 
                                                   ymin=PCS[[7]][[2]][[1]], 
                                                   ymax=PCS[[7]][[2]][[2]], 
                                                   tloss=PCS[[7]][[2]][[3]], 
                                                   epsilon=PCS[[7]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[8]][[1]][[1]], 
                                                   npts=PCS[[8]][[1]][[2]], 
                                                   control.pts=PCS[[8]][[1]][[3]], 
                                                   ymin=PCS[[8]][[2]][[1]], 
                                                   ymax=PCS[[8]][[2]][[2]], 
                                                   tloss=PCS[[8]][[2]][[3]], 
                                                   epsilon=PCS[[8]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                              ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[9]][[1]][[1]], 
                                                   npts=PCS[[9]][[1]][[2]], 
                                                   control.pts=PCS[[9]][[1]][[3]], 
                                                   ymin=PCS[[9]][[2]][[1]], 
                                                   ymax=PCS[[9]][[2]][[2]], 
                                                   tloss=PCS[[9]][[2]][[3]], 
                                                   epsilon=PCS[[9]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[10]][[1]][[1]], 
                                                   npts=PCS[[10]][[1]][[2]], 
                                                   control.pts=PCS[[10]][[1]][[3]], 
                                                   ymin=PCS[[10]][[2]][[1]], 
                                                   ymax=PCS[[10]][[2]][[2]], 
                                                   tloss=PCS[[10]][[2]][[3]], 
                                                   epsilon=PCS[[10]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                              ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[11]][[1]][[1]], 
                                                   npts=PCS[[11]][[1]][[2]], 
                                                   control.pts=PCS[[11]][[1]][[3]], 
                                                   ymin=PCS[[11]][[2]][[1]], 
                                                   ymax=PCS[[11]][[2]][[2]], 
                                                   tloss=PCS[[11]][[2]][[3]], 
                                                   epsilon=PCS[[11]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                              ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[12]][[1]][[1]], 
                                                   npts=PCS[[12]][[1]][[2]], 
                                                   control.pts=PCS[[12]][[1]][[3]], 
                                                   ymin=PCS[[12]][[2]][[1]], 
                                                   ymax=PCS[[12]][[2]][[2]], 
                                                   tloss=PCS[[12]][[2]][[3]], 
                                                   epsilon=PCS[[12]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[13]][[1]][[1]], 
                                                   npts=PCS[[13]][[1]][[2]], 
                                                   control.pts=PCS[[13]][[1]][[3]], 
                                                   ymin=PCS[[13]][[2]][[1]], 
                                                   ymax=PCS[[13]][[2]][[2]], 
                                                   tloss=PCS[[13]][[2]][[3]], 
                                                   epsilon=PCS[[13]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                              ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[14]][[1]][[1]], 
                                                   npts=PCS[[14]][[1]][[2]], 
                                                   control.pts=PCS[[14]][[1]][[3]], 
                                                   ymin=PCS[[14]][[2]][[1]], 
                                                   ymax=PCS[[14]][[2]][[2]], 
                                                   tloss=PCS[[14]][[2]][[3]], 
                                                   epsilon=PCS[[14]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                               ),
                EstimationTask(metrics=c('ubaF', 'ubaprec', 'ubarec'), 
                               evaluator="eval.stats", 
                               evaluator.pars=list(thr.rel=thr.rel,
                                                   method=PCS[[15]][[1]][[1]], 
                                                   npts=PCS[[15]][[1]][[2]], 
                                                   control.pts=PCS[[15]][[1]][[3]], 
                                                   ymin=PCS[[15]][[2]][[1]], 
                                                   ymax=PCS[[15]][[2]][[2]], 
                                                   tloss=PCS[[15]][[2]][[3]], 
                                                   epsilon=PCS[[15]][[2]][[4]]),
                               method=CV(nReps=2,nFolds=10,strat=TRUE)
                              )
)

##########################################################################
# exps
##########################################################################


for(d in seq_along(myDSs)) {
  for(w in names(WFs)) {
    resObj <- paste(myDSs[[d]]@taskName,w,'Res',sep='')
    assign(resObj,
           try(
             performanceEstimation(
               myDSs[d],         
               c(
                 do.call('workflowVariants',
                         c(list('WFnone',learner=w),
                           WFs[[w]],
                           varsRootName=paste('WFnone',w,sep='.')
                         )),
                 do.call('workflowVariants',
                         c(list('WFRU',learner=w, 
                                rel=matrix(PCS[[d]][[1]][[3]], nrow=3, ncol=3, byrow=TRUE),
                                thr.rel=thr.rel, 
                                C.perc=c("balance", "extreme")),
                           WFs[[w]],
                           varsRootName=paste('WFRU',w,sep='.'),
                           as.is="rel"
                         )),
                 do.call('workflowVariants',
                         c(list('WFRO',learner=w, 
                                rel=matrix(PCS[[d]][[1]][[3]], nrow=3, ncol=3, byrow=TRUE),
                                thr.rel=thr.rel,
                                C.perc=c("balance", "extreme")),
                           WFs[[w]],
                           varsRootName=paste('WFRO',w,sep='.'),
                           as.is="rel"
                         )),
                 do.call('workflowVariants',
                         c(list('WFGN',learner=w, 
                                rel=matrix(PCS[[d]][[1]][[3]], nrow=3, ncol=3, byrow=TRUE),
                                thr.rel=thr.rel,
                                C.perc=c("balance", "extreme"), pert=c(0.1,0.05,0.5)),
                           WFs[[w]],
                           varsRootName=paste('WFGN',w,sep='.'),
                           as.is="rel"
                         )),
                 do.call('workflowVariants',
                         c(list('WFIS',learner=w, 
                                rel=matrix(PCS[[d]][[1]][[3]], nrow=3, ncol=3, byrow=TRUE),
                                O=c(0.5,0.8),
                                U=c(0.5,0.8)),
                           WFs[[w]],
                           varsRootName=paste('WFIS',w,sep='.'),
                           as.is="rel"
                         )),
                 do.call('workflowVariants',
                         c(list('WFsmote',learner=w,
                                rel=matrix(PCS[[d]][[1]][[3]], nrow=3, ncol=3, byrow=TRUE),
                                thr.rel=thr.rel,
                                C.perc=c("balance", "extreme"), 
                                k=5, repl=FALSE, 
                                dist="HEOM", p=2),
                           WFs[[w]],
                           varsRootName=paste('WFsmote',w,sep='.'),
                           as.is="rel"
                         ))
               ),
               CVsetts[[d]])
           )
    )
    if (class(get(resObj)) != 'try-error') save(list=resObj,file=paste(myDSs[[d]]@taskName,w,'Rdata',sep='.'))
  }
}
