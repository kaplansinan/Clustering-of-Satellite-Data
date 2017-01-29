# Clustering-of-Satellite-Data

This project is developed as part of Advanced Data Analysis and Machine Learning Course taught at Lappeenranta University of Technology, Finland.

## Synopsis

The project is an extension of the study conducted by J. Hakkarainenet al, at Finnish Meteorological Institute, Earth Observation, Helsinki, Finland. The goal of the stuyd is to provide the first direct observation of anthropogenic CO2 from OCO-2(Orbiting Carbon Observatory-2 (OCO-2)) over the main pollution regions: eastern USA, central Europe, and East Asia. To achive this goal clustering analysis of CO2 is studied. For further detailed information please refer to [this paper](http://onlinelibrary.wiley.com/doi/10.1002/2016GL070885/abstract).

## Motivation

Anthropogenic CO2 emissions from fossil fuel combustion have large impacts on climate. In order to monitor the increasing CO2 concentrations in the atmosphere, accurate spaceborne observations—as available from the Orbiting Carbon Observatory-2 (OCO-2)
—are needed. A recent publication provides the first direct observation of anthropogenic CO2 from OCO-2 over the main pollution regions: eastern USA, central Europe, and East Asia. This is achieved by deseasonalizing and detrending OCO-2 XCO2 observations to derive XCO2 anomalies. The spatial distribution of the XCO2 anomaly matches the features observed in the maps of the Ozone Monitoring Instrument NO2 tropospheric columns, used as an indicator of atmospheric pollution.

In order to combine the information from XCO2 anomalies and NO2 mean fields, two clustering methods based on unsupervised machine learning, are applied: k-means clustering and Gaussian Mixture Models (GMM) clustering.

## Code 

The implementation of clustering methods including Gaussian Mixture Models, K-Means and Expectation Maximization (for clustering and imputation) can be found under **code** file. MATLAB is used because of its flexibility and related libraries. 

## Graphical Results

The results obtained from the culstering analysis can be found under **results** file. In this file we demonstrate impact of imputation on clustering analysis and  analysis number of clusters (k = 3, 4, 5, and 7). 

## Documentation

The clustering analysis is explained with related methods in **report.pdf**  under **doc** file.


## Tests

To able to run the code by yourself, you need to have MATLAB. After installing the Matlab, All you need to do is as follows:
1. Dowbload the repository
2. Extract the files
3. To see the difference of GMM and K-Means clustering approaches on the toy data (Mickey Mouse) run  "toy_ex.m" 
4. Run "project.m" to get related results and figures with respect to aforementioned task.

## Contributors

1. [Denis Sedov](https://www.linkedin.com/in/denis-sedov-1a1480130/)
2. [Sinan Kaplan](https://www.linkedin.com/in/kaplansinan/)

## License

MIT
