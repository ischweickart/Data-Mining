% Lab 2
% Find the least squares classification function for the following
% data sets. 
% 1. Randomly generated data set.
% 2. The Iris data set
% 3. Using smartphone data.

A=rand(50,2); %uniform from 0 to 1 and 0 to 1
X1=[ones(50,1) A+[ones(50,1) zeros(50,1)]];
X1=[X1; ones(50,1) A-[ones(50,1) zeros(50,1)]]; %X tilde
y1=[ones(50,1); zeros(50,1)]; %known labels
Beta = inv(X1'*X1)*X1'*y1; % least squares solution

% plot data and hyperplane and color points by the output function value

fx = Beta(1)*X1(:,1)+Beta(2)*X1(:,2)+Beta(3)*X1(:,3); % Approximation of y
x1 = -1:.001:2;
x2 = 1/Beta(3)*(.5-Beta(1)-Beta(2)*x1); %solve for line = 1/2


figure
subplot(2,1,1);
scatter(X1(:,2),X1(:,3),10,fx);
title('Synthetic Data with Two Classes')

subplot(2,1,2);
plot(x1, x2,'.');
hold on
scatter(X1(:,2),X1(:,3),10,fx);
axis([-1,2,0,1]);
title('Least Squares Separating Hyperplane')
hold off