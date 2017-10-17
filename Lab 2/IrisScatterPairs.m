load fisheriris.mat

xIris = [ones(150,1) meas];
ySet = [ones(50,1);zeros(100,1)]; % Red
bSet = inv(xIris'*xIris)*xIris'*ySet; % optimal hyperplane
yVers = [zeros(50,1);ones(50,1);zeros(50,1)]; % Green
bVers = inv(xIris'*xIris)*xIris'*yVers;
yVirg = [zeros(100,1);ones(50,1)]; % Blue
bVirg = inv(xIris'*xIris)*xIris'*yVirg;

fSet = xIris*bSet;
m1 = subplot(4,4,1);
xl = xlim(m1); 
xPos = xl(1) + diff(xl) / 2; 
yl = ylim(m1); 
yPos = yl(1) + diff(yl) / 2; 
m1t = text(xPos, yPos, sprintf( 'Sepal.Length'), 'Parent', m1);
set(m1t, 'HorizontalAlignment', 'center');
m12 = subplot(4,4,2); gscatter(meas(:,1), meas(:,2),species,'rgb','.',10, 'off');
m13 = subplot(4,4,3); gscatter(meas(:,1), meas(:,3),species,'rgb','.',10, 'off');
m14 = subplot(4,4,4); gscatter(meas(:,1), meas(:,4),species,'rgb','.',10, 'off');
m21 = subplot(4,4,5); gscatter(meas(:,2), meas(:,1),species,'rgb','.',10, 'off');
m2 = subplot(4,4,6);
m2t = text(xPos, yPos, sprintf( 'Sepal.Width'), 'Parent', m2);
set(m2t, 'HorizontalAlignment', 'center');
m23 = subplot(4,4,7); gscatter(meas(:,2), meas(:,3),species,'rgb','.',10, 'off');
m24 = subplot(4,4,8); gscatter(meas(:,2), meas(:,4),species,'rgb','.',10, 'off');
m31 = subplot(4,4,9); gscatter(meas(:,3), meas(:,1),species,'rgb','.',10, 'off');
m32 = subplot(4,4,10); gscatter(meas(:,3), meas(:,2),species,'rgb','.',10, 'off');
m3 = subplot(4,4,11);
m3t = text(xPos, yPos, sprintf( 'Petal.Length'), 'Parent', m3);
set(m3t, 'HorizontalAlignment', 'center');
m34 = subplot(4,4,12); gscatter(meas(:,3), meas(:,4),species,'rgb','.',10, 'off');
m41 = subplot(4,4,13); gscatter(meas(:,4), meas(:,1),species,'rgb','.',10, 'off');
m42 = subplot(4,4,14); gscatter(meas(:,4), meas(:,2),species,'rgb','.',10, 'off');
m43 = subplot(4,4,15); gscatter(meas(:,4), meas(:,3),species,'rgb','.',10, 'off');
m4 = subplot(4,4,16); 
m4t = text(xPos, yPos, sprintf( 'Petal.Width'), 'Parent', m4);
set(m4t, 'HorizontalAlignment', 'center');