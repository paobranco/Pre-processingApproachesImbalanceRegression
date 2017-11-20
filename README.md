## A Pre-processing Approaches for Imbalanced Distributions in Regression

This repository has all the code used in the experiments carried out in the paper *"Pre-processing Approaches for Imbalanced Distributions in Regression"* [1].


This repository is organized as follows:

* **R_Code** folder - contains all the code for reproducing the experiments described in the paper;
* **Data** folder - contains the 15 regression data sets used in the experiments carried out;
* **Figures** folder - contains all the figures obtained from the experimental evaluation on 15 real world data sets;

### Data Repository

The paper also provides a [data repository](https://paobranco.github.io/Imbalanced-Regression-DataSets/) with imbalanced regression data sets in different formats.


### Requirements

The experimental design was implemented in R language. Both code and data are in a format suitable for R environment.

In order to replicate these experiments you will need a working installation of R. Check [https://www.r-project.org/] if you need to download and install it.

In your R installation you also need to install the following additional R packages:

  - DMwR
  - performanceEstimation
  - UBL
  - uba
  - e1071
  - randomForest
  - earth
  - nnet

  All the above packages, with the exception of uba package, can be installed from CRAN Repository directly as any "normal" R package. Essentially you need to issue the following command within R:

```r
install.packages(c("DMwR", "performanceEstimation", UBL", "e1071", "randomForest", "earth", "nnet"))
```

Additionally, you will need to install uba package from a tar.gz file that you can download from [http://www.dcc.fc.up.pt/~rpribeiro/uba/]. 

For installing this package issue the following command within R:
```r
install.packages("uba_0.7.7.tar.gz",repos=NULL,dependencies=T)
```


To replicate the figure in this repository you will also need to install the packages:

  - ggplot2
  - scmamp

As with any R package, we only need to issue the following command:

```r
install.packages(c("ggplot2", "scmamp"))
```

Check the README file in the R_Code folder to see more detailed instructions on how to run the experiments.

*****

### References
[1] Branco, P. and Torgo, L. and Ribeiro R.P. (2017) *"Pre-processing Approaches for Imbalanced Distributions in Regression"*  Special Issue on Learning in the Presence of Class Imbalance and Concept Drift. Neurocomputing Journal. (submitted).