## Reproducing the Paper Experiments

## Contents

  This folder contains  all code that is necessary to replicate the experiments reported in the paper *"Pre-processing Approaches for Imbalanced Distributions in Regression"* [1].

  The folder is organized as follows:
  
  - **LM** the code for running the experiments with Linear Regression;

  - **MARS** the code for running the experiments with the Multivariate Adaptive Regression Splines;
  
  - **NNET** the code for running the experiments with Neural Networks;
  
  - **SVM** the code for running the experiments with Support Vector Machines;
  
  - **RF** the code for running the experiments with Random Forests.


Each described folder contains two files:

  - **expsIS.R** the script for running a set of experiences for a given learning system

  - **AuxsIS.R** the auxiliary functions for defining workflows and evaluation process

## Necessary Software

To replicate these experiments you will need a working installation
  of R. Check [https://www.r-project.org/] if you need to download and install it.

In your R installation you also need to install the following additional R packages:

  - DMwR
  - performanceEstimation
  - UBL
  - uba
  - e1071
  - randomForest
  - earth
  - nnet

  All the above packages with exception of uba, can be installed from CRAN Repository directly as any "normal" R package. Essentially you need to issue the following command within R:

```r
install.packages(c("DMwR", "performanceEstimation", UBL", "e1071", "randomForest", "earth", "nnet"))
```

Additionally, you will need to install uba package from a tar.gz file that you can download from [http://www.dcc.fc.up.pt/~rpribeiro/uba/]. 

For installing this package issue the following command within R:
```r
install.packages("uba_0.7.7.tar.gz",repos=NULL,dependencies=T)
```


## Running the experiences:

Before running the experiments you need to load the data sets used in R. To obtain the 15 regression data sets and to see how you can load them, please check the README.md file in the **Data** folder. 

After having the necessary data sets, to run the experiments described in the paper you select the learner you want to run (SVM, NNET, RF, MARS or LM), execute R in the respective folder with the code and then issue the command:

```r
source("expsIS.R")
```

Alternatively, you may run the experiments directly from a Linux terminal (useful if you want to logout because some experiments take a long time to run):

```bash
nohup R --vanilla --quiet < expsIS.R &
```

## Running a subset of the experiences:

Given that the experiments take  long time to run, you may be interested in running only a partial set of experiments. To do this you must edit the expsIS.R file. 

  
Lets say, for instance, that you want to run all the workflows in the first 10 data sets. To do this you can change the instruction ``` for(d in seq_along(myDSs) ``` in expsIS.R file. If the data sets you selected are the first 10, then you need to change this instruction to ```for(d in 1:10)```. If you want a different subset, let say, the data sets 1, 5 and 7, then you need to change the same instruction to ```for(d in c(1,5,7))```.
  

After making all the necessary changes run the experiments as previously explained.


*****

### References
[1] Branco, P. and Torgo, L. and Ribeiro R.P. (2017) *"Pre-processing Approaches for Imbalanced Distributions in Regression"*  Special Issue on Learning in the Presence of Class Imbalance and Concept Drift. Neurocomputing Journal. (submitted).