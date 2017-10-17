% Ian Schweickart
% February 15, 2017
% Math 166-Data Mining
% 
% Lab 2
%
% Part 1: Synthetic Data Classification
% Find the least squares classification function for a randomly generated 
% data set.

A=rand(50,2); %uniform from 0 to 1 and 0 to 1
X1=[ones(50,1) A+[ones(50,1) zeros(50,1)]];
X1=[X1; ones(50,1) A-[ones(50,1) zeros(50,1)]]; %X tilde
y1=[ones(50,1); zeros(50,1)]; %known labels
Beta = inv(X1'*X1)*X1'*y1; % least squares solution

% plot data and hyperplane and color points by the output function value

fx = Beta(1)*X1(:,1)+Beta(2)*X1(:,2)+Beta(3)*X1(:,3); % Approximation of y
x1 = -1:.001:2; % hyperplane vector
x2 = 1/Beta(3)*(.5-Beta(1)-Beta(2)*x1); % solve for line = 1/2

figure
subplot(3,2,1);
scatter(X1(:,2),X1(:,3),15,fx, 'filled');
title('Synthetic Data with Two Classes')

subplot(3,2,2);
plot(x1, x2,'.');
hold on
scatter(X1(:,2),X1(:,3),15,fx,'filled');
axis([-1,2,0,1]);
title('Least Squares Separating Hyperplane');
hold off


% Part 2: Iris Data Set
% Find the least squares classification function for 3 pairs of x-values
% from the Fisher Iris data set.

load fisheriris.mat

xIris = [ones(150,1) meas]; % X tilde
ySet = [ones(50,1);zeros(100,1)]; % Setosa labels
bSet = inv(xIris'*xIris)*xIris'*ySet; % Setosa classification
yVers = [zeros(50,1);ones(50,1);zeros(50,1)]; % Versicolor labels
bVers = inv(xIris'*xIris)*xIris'*yVers;% Versicolor classification
yVirg = [zeros(100,1);ones(50,1)]; % Virginica labels
bVirg = inv(xIris'*xIris)*xIris'*yVirg; % Virginica classification

% Compare Sepal Length, Sepal Width, Petal Length
% Classified by Setosa
fSet = bSet(1)*xIris(:,1)+bSet(2)*xIris(:,2)+bSet(3)*xIris(:,3) ... 
                         +bSet(4)*xIris(:,4); % Approximation of ySet
subplot(3,3,4);
s = scatter3(xIris(:,2),xIris(:,3), xIris(:,4),15,fSet,'filled');
s.MarkerEdgeColor=[0 0 0]; 
axis([min(xIris(:,2)) max(xIris(:,2)) min(xIris(:,3)) max(xIris(:,3)) ...
      min(xIris(:,4)) max(xIris(:,4))]);
title('Setosa');
xlabel('Sepal Length'); ylabel('Sepal Width'); zlabel('Petal Length');

% Compare Sepal Width, Petal Length, Petal Width
% Classified by Versicolor
fVers = bVers(1)*xIris(:,1)+bVers(3)*xIris(:,3)+bVers(4)*xIris(:,4) ... 
                           +bVers(5)*xIris(:,5); % Approximation of yVers
subplot(3,3,5);
ve = scatter3(xIris(:,3),xIris(:,4),xIris(:,5),15,fVers,'filled');
ve.MarkerEdgeColor=[0 0 0];
axis([min(xIris(:,3)) max(xIris(:,3)) min(xIris(:,4)) max(xIris(:,4)) ...
      min(xIris(:,5)) max(xIris(:,5))]);
title('Versicolor');
xlabel('Sepal Width'); ylabel('Petal Length'); zlabel('Petal Width');

% Compare Sepal Length, Petal Length, Petal Width
% Classified by Virginica
fVirg = bVirg(1)*xIris(:,1)+bVirg(2)*xIris(:,2)+bVirg(4)*xIris(:,4) ... 
                           +bVirg(5)*xIris(:,5); % Approximation of yVirg
subplot(3,3,6);
vi = scatter3(xIris(:,2),xIris(:,4), xIris(:,5),15,fVirg,'filled');
vi.MarkerEdgeColor=[0 0 0];
axis([min(xIris(:,2)) max(xIris(:,2)) min(xIris(:,4)) max(xIris(:,4)) ...
      min(xIris(:,5)) max(xIris(:,5))]);
title('Virginica');
xlabel('Sepal Length'); ylabel('Petal Length'); zlabel('Petal Width');


% Part 3: Image Segmentation
% Plot the results of the optimal classification function as a pixel 
% intensity at each original pixel location.

I = imread('image.jpg');
A = imread('mask0.jpg');
B = imread('mask1.jpg');

W = size(I,2);
H = size(I,1);
XI = cast(reshape(I,[W*H,3]),'double')/255.0;
XA = cast(reshape(A,[W*H,3]),'double')/255.0;
XA = mean(XA,2) > 0.5;
XB = cast(reshape(B,[W*H,3]),'double')/255.0;
XB = mean(XB,2) > 0.5;

image = I;
IXTR = XA > 0.5 | XB > 0.5;

masked_image = zeros(size(XI));
masked_image(IXTR,:) = XI(IXTR,:);

foreground = masked_image;
background = masked_image;

for i=1:3,
    foreground(:,i) = XI(:,i).*(XA);
    background(:,i) = XI(:,i).*(XB);
end;

foreground = reshape(foreground,[H W 3]);
background = reshape(background,[H W 3]);

X = XI(IXTR,:);
Y = XA(IXTR);

imBeta = inv(X'*X)*X'*Y;

fx = imBeta(1)*X(:,1)+ imBeta(2)*X(:,2)+ imBeta(3)*X(:,3);
% Not sure how to use fx here, or even if I have the right beta

subplot(3,3,7);


subplot(3,3,8);


subplot(3,3,9);
