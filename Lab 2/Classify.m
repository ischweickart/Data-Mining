%% Example 

[X,Y,TOTAL_X,IMAGE] = Load_Data;

% Training step:
lambda = 0.01;
[beta, flag] = Logistic( X, Y, lambda );

% Classification step:
%
% compute f(x) = L( alpha + < beta, x> ) for all data points
% (both labeled and unlabeled) in the image
% then assign pixels to their most likely class (foreground or background)
% according to the rule 
%   f(x) > 1/2  --- class 1 (foreground)
%   f(x) < 1/2  --- class 0 (background)
TOTAL_Y = exp((beta(1) + TOTAL_X*beta(2:end)))./(1.0 + exp((beta(1) + TOTAL_X*beta(2:end))));
TOTAL_Y = double( TOTAL_Y > .5 );

View_Result(TOTAL_Y, IMAGE);