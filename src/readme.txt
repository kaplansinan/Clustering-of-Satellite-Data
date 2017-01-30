Assignment for the ADAML course.
Implemented by Denis Sedov, Sinan Kaplan, 2017.

The current folder consists of the following files:
report.pdf - the detailed explanation of the solution as a report.

m-files:
toy_ex.m - Application of k-means and GMM on toy example("Mickey Mouse").
project.m - Implementation of clustering on the given dataset(CO2, NO2), the main file.
impute_data.m - Function, which imputes missing data in input

data files in "data" folder:
mickey-mouse.csv - toy data
dataStruct_1deg.mat - given dataset
dataStruct_2deg.mat - given dataset
dataStruct_05deg.mat - given dataset
dataStruct_025deg.mat - given dataset

figures in "figures" folder:
EMImputation - results obtained from when the missing values are filled by Expectation Maximization
k3 - results obtained from when the number clusters is 3
k4 - results obtained from when the number clusters is 4
k5 - results obtained from when the number clusters is 5

additional folders:
m_map1.4 - m_map toolbox
gmmbayestb-v1.0 - GMMBayes Toolbox


In order to get the results, run the files "toy_ex.m" and "project.m"(it takes appr. 20 sec to execute)
