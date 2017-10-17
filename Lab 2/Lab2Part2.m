% Lab 2
% Find the least squares classification function for the following
% data sets. 
% 2. The Iris data set
load fisheriris.mat

xIris = [ones(150,1) meas];
ySet = [ones(50,1);zeros(100,1)]; % Red
bSet = inv(xIris'*xIris)*xIris'*ySet; % optimal hyperplane
yVers = [zeros(50,1);ones(50,1);zeros(50,1)]; % Green
bVers = inv(xIris'*xIris)*xIris'*yVers;
yVirg = [zeros(100,1);ones(50,1)]; % Blue
bVirg = inv(xIris'*xIris)*xIris'*yVirg;

figure

% Compare Sepal Length, Sepal Width, Petal Length
% Classified by Setosa
fSet = bSet(1)*xIris(:,1)+bSet(2)*xIris(:,2)+bSet(3)*xIris(:,3)+bSet(4)*xIris(:,4); % Approximation of ySet
subplot(4,1,1);
scatter3(xIris(:,2),xIris(:,3), xIris(:,4),10,fSet);

% Compare Sepal Length, Sepal Width, Petal Width
% Classified by Versicolor
fVers = bVers(1)*xIris(:,1)+bVers(2)*xIris(:,2)+bVers(3)*xIris(:,3)+bVers(5)*xIris(:,5); % Approximation of yVers
subplot(4,1,2);
scatter3(xIris(:,2),xIris(:,3),xIris(:,5),10,fVers);

% Compare Sepal Length, Petal Length, Petal Width
% Classified by Virginica
fVirg = bVirg(1)*xIris(:,1)+bVirg(2)*xIris(:,2)+bVirg(4)*xIris(:,4)+bVirg(5)*xIris(:,5); % Approximation of yVirg
subplot(4,1,3);
scatter3(xIris(:,2),xIris(:,4), xIris(:,5),10,fVirg);





