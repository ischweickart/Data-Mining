% last data set for Lab 2
% - 3 class classification (randomly generated)
% red vs not red, green vs not green, blue vs not blue ("1 vs all")

A=rand(50,2);
X4 = [ones(50,1) A+[ones(50,1) zeros(50,1)]];
X4 = [X4; ones(50,1) A-[ones(50,1) zeros(50,1)]];
X4 = [X4; ones(50,1) A+[2.*ones(50,1) -1.*ones(50,1)]]; %X tilde
yRed = [ones(50,1);zeros(100,1)]; %known labels
bRed = inv(X4'*X4)*X4'*yRed; % least squares solution
yGreen = [zeros(50,1); ones(50,1); zeros(50,1)];
bGreen = inv(X4'*X4)*X4'*yGreen;
yBlue = [zeros(100,1);ones(50,1)];
bBlue = inv(X4'*X4)*X4'*yBlue; 

% plot data and hyperplane and color points by the output function value

fxRed = bRed(1)*X4(:,1)+bRed(2)*X4(:,2)+bRed(3)*X4(:,3); % Approximation of y
x1R = -1:.001:3;
x2R = 1/bRed(3)*(.5-bRed(1)-bRed(2)*x1R);

fxGreen = bGreen(1)*X4(:,1)+bGreen(2)*X4(:,2)+bGreen(3)*X4(:,3);
x1G = x1R;
x2G = 1/bGreen(3)*(.5-bGreen(1)-bGreen(2)*x1G);

fxBlue = bBlue(1)*X4(:,1)+bBlue(2)*X4(:,2)+bBlue(3)*X4(:,3);
x1B = x1R;
x2B = 1/bBlue(3)*(.5-bBlue(1)-bBlue(2)*x1G);

figure
subplot(3,2,1);
scatter(X4(:,2),X4(:,3), 20,fxRed);
axis([-1,3,-1,1]);

subplot(3,2,2);
plot(x1R, x2R,'r.');
hold on
scatter(X4(:,2),X4(:,3),10,fxRed);
axis([-1,3,-1,1]);
hold off

subplot(3,2,3);
scatter(X4(:,2),X4(:,3), 20,fxGreen);
axis([-1,3,-1,1]);

subplot(3,2,4);
plot(x1G, x2G,'g.');
hold on
scatter(X4(:,2),X4(:,3), 20,fxGreen);
axis([-1,3,-1,1]);
hold off

subplot(3,2,5);
scatter(X4(:,2),X4(:,3), 20,fxBlue);
axis([-1,3,-1,1]);


subplot(3,2,6);
plot(x1B, x2B,'b.');
hold on
scatter(X4(:,2),X4(:,3), 20,fxBlue);
axis([-1,3,-1,1]);
hold off