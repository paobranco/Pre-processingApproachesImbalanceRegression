# Used Regression Data Sets#

*****

### Load the data sets in R using this repository ###

For loading all the 15 regression data sets in R you need to issue the following command:

```r
load("DataSets15.Rdata")
```

This will load into R an object named `DSs` which contains a list with 15 objects of class `dataset` from package DMwR.

*****

### Load the data sets using the repository provided with paper[1] ###

The paper *"Pre-processing Approaches for Imbalanced Distributions in Regression"*[1] also provides a data repository with the 15 used imbalanced regression data sets in different formats.

The repository is avaliable [HERE](https://paobranco.github.io/Imbalanced-Regression-DataSets/).

The data formats currently avaliable are: RDATA, CSV, and ARFF.

The repository page also includes information about the data sets.

*****

### Data Sets Description ###

The main characteristics of the 15 regression data sets included in this folder are as follows:


ID  | Data Set   | N    | tpred | p.nom | p.num | nRare | % Rare|
----|------------|------|-------|-------|-------|-------|-------|
DS1 | a6         | 198  | 11    | 3     | 8     | 33    | 16.7  |
DS2 | Abalone    | 4177 | 8     | 1     | 7     | 679   | 16.3  |
DS3 | a3         | 198  | 11    | 3     | 8     | 32    | 16.2  |
DS4 | a4         | 198  | 11    | 3     | 8     | 31    | 15.7  |
DS5 | a1         | 198  | 11    | 3     | 8     | 28    | 14.1  |
DS6 | a7         | 198  | 11    | 3     | 8     | 27    | 13.6  |
DS7 | boston     | 506  | 13    | 0     | 13    | 65    | 12.8  |
DS8 | a2         | 198  | 11    | 3     | 8     | 22    | 11.1  |   
DS9 | fuelCons   | 1764 | 38    | 12    | 26    | 164   | 9.3   |
DS10| heat       | 7400 | 12    | 4     | 8     | 664   | 9.0   |
DS11| availPwr   | 1802 | 16    | 7     | 9     | 157   | 8.7   |
DS12| cpuSm      | 8192 | 13    | 0     | 13    | 713   | 8.7   |
DS13| maxTorq    |1802  | 33    | 13    | 20    | 129   | 7.2   |
DS14| bank8FM    | 4499 | 9     | 0     | 9     | 288   | 6.4   |
DS15| Accel      | 1732 | 15    | 3     | 12    | 89    | 5.1   |


where:

N is the number of examples in the data set;

tpred is the total number of features;

p.nom is the number of nominal features; 

p.num is the number of numeric features; 

nRare is the number of rare cases, i.e. cases with target variable relevance above 0.8; and 

%Rare is the percentage of rare cases in the data set (%Rare = nRare/Nx100).


*****

### References
[1] Branco, P. and Torgo, L. and Ribeiro R.P. (2017) *"Pre-processing Approaches for Imbalanced Distributions in Regression"*  Special Issue on Learning in the Presence of Class Imbalance and Concept Drift. Neurocomputing Journal. (submitted).