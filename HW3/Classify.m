%Load MNIST

Load_MNIST;

% Training step:
%
% compute R hyperplanes (alpha_r,beta_r) 1<=r<=R
% using either Multiclass Logistic Regression
% or one-versus-all Soft SVM

% store the results in a (d+1)-by-R matrix B,
% the first column of B should be 
%          alpha_1
%          beta_1
% the second column of B should be 
%          alpha_2
%          beta_2
% etc.

% Classification step, using B computed as above:
lambda = [0 .01 .1 1 10 100];
B = [a01 a02 a12; b01 b02 b12];

X = X_TEST;
X_tild = [ones(size(X,1),1) X];
[~,ind] = max(X_tild*B,[],2);
percentage = Purity(ind,Y_TEST,3);