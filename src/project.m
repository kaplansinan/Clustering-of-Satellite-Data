%%
%
% Denis Sedov, Sinan Kaplan, 2017
%
% Clustering of CO2 and NO2 data using different grid size.
%
clear all
close all
clc

% add functionality to work with maps
addpath(genpath('m_map1.4'));

% add gmm toolbox
addpath(genpath('gmmbayestb-v1.0'));

% filenames of the data with different pixel size
filenames = {'data/dataStruct_2deg.mat';
             'data/dataStruct_1deg.mat';
             'data/dataStruct_05deg.mat';
             'data/dataStruct_025deg.mat'};
         
% sizes          
deg = {'2deg';
       '1deg';
       '05deg';
       '025deg'};
  
% name of the regions 
region = {'USA', 'Europe', 'Asia'};
         
K = 4; % number of clusters

for i = 1:4 % go through different pixel size
    figure   
    for j = 1:3 % go through differentmap regions
        
        % import data for the specific pixel size
        dataStruct = importdata(filenames{i});

        % get the data for the region j (1st column - XCO2, 2nd column - NO2)
        X = [dataStruct{j}.XCO2_anomaly(:) dataStruct{j}.NO2(:)];

        % rescale data, s.t. it is within the interval [0,1]
        X(:,1) = (X(:,1)-min(X(:,1)))/(max(X(:,1))-min(X(:,1)));
        X(:,2) = (X(:,2)-min(X(:,2)))/(max(X(:,2))-min(X(:,2)));
        
        % imputation is commented, because it causes ill-conditionness in
        % covariance matrix for 05 and 025 resolution
        % X = impute_data(X);
        
        ip = ~any(isnan(X),2);
        
        % GMM Toolbox, finding optimal number of clusters in the data
        % estS = gmmb_fj(X(ip), 'Cmax', 10, 'thr', 1e-9);
        
        rng(20); % give the seed, s.t. the results can be repeated
        
        % fit GMM model using results from K-means as an initial clusters
        warning off stats:gmdistribution:MissingData % suppress the warning regarding NaN data
        warning off stats:gmdistribution:cluster:MissingData % suppress the warning regarding NaN data
        gm = fitgmdist(X, K, 'Start', 'plus','Options',statset('MaxIter',300));
        
        mu = gm.mu;
        Sigma = gm.Sigma;
        prop = gm.ComponentProportion;
        
        % sort the cluster means(+covariance and proportion)according to the mean
        % NO2 levels (ascending order)=> cluster with greater number has
        % greater mean NO2-level
        %
        % Bubblesort
        for ii = K:-1:1
            for jj = 1:ii-1
                if (mu(jj,2) > mu(jj+1,2))
                    [mu(jj+1,:), mu(jj,:)] = deal(mu(jj,:), mu(jj+1,:)); %swap the variables
                    [Sigma(:,:,jj+1), Sigma(:,:,jj)] = deal(Sigma(:,:,jj), Sigma(:,:,jj+1));
                    [prop(jj+1), prop(jj)] = deal(prop(jj), prop(jj+1));
                end
            end
        end
        gm = gmdistribution(mu,Sigma,prop);
        
        % cluster the data
        idx = cluster(gm,X); 

        % plot the clusterized points
        subplot(2,3,j), 
        hold on
        for k=1:K % go through the clusters
            ik = idx==k; % points from the specific cluster
            sz = size(X(ik));
            scatter(X(ik,1),X(ik,2),10,ones(sz)*k,'filled');
        end
        xlabel('OCO-2 mean XCO_2 anomalies,2014-2016');
        ylabel('OMI mean NO_2 trop. columns, 2014-2016');
        str = strcat(region{j},'(',deg{i},')');
        title(str);
        hold off

        % reshape the cluster array for plotting
        ir = reshape(idx, size(dataStruct{j}.XCO2_anomaly));
        
        % plot clusters on the map
        % (this part of code partially borrowed from plotData.m, provided
        % by Janne Hakkarainen)
        subplot(2,3,3+j)
        set(gcf, 'Renderer', 'opengl')
        hold on
        m_proj('miller','latr',[dataStruct{j}.lat(1) dataStruct{j}.lat(end)],'lonr',[dataStruct{j}.lon(1) dataStruct{j}.lon(end)]);
        m_coast('color',[0 .6 0]);
        m_pcolor(dataStruct{j}.lon,dataStruct{j}.lat,ir);shading flat
        caxis([1 k])
        m_grid('tickdir','out','FontName','bitstream charter','fontsize',10,'backcolor',[.9 .9 .9])
        m_coast('line','color','k','linewidth',1);
        %h = colorbar;set(h,'Fontsize',14);h.Label.String = '(ppm)';
        hold off
    end   
end