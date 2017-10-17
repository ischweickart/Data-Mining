function [alpha,beta] = SoftSVM(X,labels,lambda)

% data is N x d, where N is the number of data points and d is the
% dimensionality of the data (X_TRAIN)

% labels is N x 1 and gives the class of each data point (Y_TRAIN)


%%
% 
% use the inputs X,labels to form the matrices H,A and vectors f,b
% so that min <z,Hz>/2 + <f,z> subject to Az <= b gives the solution 
% to the Soft SVM energy, where z = [alpha;beta;xi]
%
%%
N = size(X,1);
d = size(X,2);

Xt = [ones(N,1) X];

H = [eye(d+1) zeros(d+1,N); zeros(N,d+1) zeros(N)];
H(1,1) = 0;

L = -diag(labels);
I = eye(N);
A = [L*Xt -I; zeros(size(L*Xt)) -I];

f = zeros(d+1,1);
f = [f; lambda*ones(N,1)];

b = [-ones(N,1); zeros(N,1)];

opts = optimset('Algorithm','interior-point-convex','Display','off');
[z,~,exflag] = quadprog(H,f,A,b,[],[],[],[],[],opts);
alpha = z(1,1);
beta = z(2:d+1,1);
exflag;

