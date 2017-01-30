function X = impute_data(Y)
% This function implements data imputation (using regression)
%
%   Input:  Y - data with missing values
%
%   Output: X - data with imputed values 
%    

X = Y;
 
% find rows consisting only of NaNs
nan_row = any(isnan(X(:,1)),2) & any(isnan(X(:,2)),2);
 
% find indices with missing values
ip = ~any(isnan(X),2);

%missig indices for column1
missing_indices1= find(any(isnan(X(:,1))&~nan_row,2));
%missig indices for column2
missing_indices2= find(any(isnan(X(:,2))&~nan_row,2));

% data with missing values removed
X_complete = X(ip,:);

% parameter for first column
coeff_1 = [ ones(size(X_complete,1),1) X_complete(:,2)] \X_complete(:,1);
coeff_2 = [ ones(size(X_complete,1),1) X_complete(:,1)] \X_complete(:,2);

% initialization
mu1_previous = mean(X_complete(:,1));
mu2_previous = mean(X_complete(:,2));
mu1_current = 1;
mu2_current = 1;

% maxiter = 100; %this can be used also for controlling the while loop
% precision = 0.001;

% assign all NaN values to zero (except for rows where all values = NaN, they shouldn't be considered at all) 
X(~ip&~nan_row) = 0 ;

% start iterations
while (abs(mu1_current - mu1_previous) > 0.1) || (abs(mu2_current - mu2_previous) > 0.1)
    
    mu1_previous = mu1_current;
    mu2_previous = mu2_current;
    
    %expectation step(fill missing values)
    X(missing_indices1,1) = ( [ones(size(missing_indices1,1),1) X(missing_indices1,2)]) * coeff_1;
    X(missing_indices2,2) = ( [ones(size(missing_indices2,1),1) X(missing_indices2,1)]) * coeff_2;
    
    %maximization step (calculate mu and new coefficients)
    %mean update
    mu1_current = mean(X(:,1));
    mu2_current = mean(X(:,2));
    
    % parameter for first column
    coeff_1 = [ ones(size(X,1),1) X(:,2)] \X(:,1);
    coeff_2 = [ ones(size(X,1),1) X(:,1)] \X(:,2);
end