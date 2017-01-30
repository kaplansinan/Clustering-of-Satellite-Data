%%
%
% Denis Sedov, Sinan Kaplan, 2017
%
% Demonstration of clustering on toy example

clear all
close all
clc

% import toy data
A = importdata('data/mickey-mouse.csv');

x = A(:,1); % x-coordinate
y = A(:,2); % y-coordinate
%cl = A(:,3); % clusters
X = [x y];

% cluster using k-means, where k = 3
c = kmeans(X,3);

% plot the clusters
figure, 
subplot(1,2,1)
hold on
plot(x(c==1),y(c==1),'r.','markersize',10);
plot(x(c==2),y(c==2),'g.','markersize',10);
plot(x(c==3),y(c==3),'b.','markersize',10);
hold off
xlabel('x');
ylabel('y');
title('toy example (k-means)');

% cluster using GMM (k-means used during initial step)
gm = fitgmdist(X, 3, 'Start', 'plus');
c = cluster(gm,X);

% plot the clusters
subplot(1,2,2), hold on
plot(x(c==1),y(c==1),'r.','markersize',10);
plot(x(c==2),y(c==2),'g.','markersize',10);
plot(x(c==3),y(c==3),'b.','markersize',10);
hold off
xlabel('x');
ylabel('y');
title('toy example (GMM)');