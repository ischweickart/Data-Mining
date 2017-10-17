% confusion matrix

[a0, b0] = SoftSVM(X_TRAIN,Y0vAll,.1);
[a1, b1] = SoftSVM(X_TRAIN,Y1vAll,.1);
[a2, b2] = SoftSVM(X_TRAIN,Y2vAll,.1);
B = [a0 a1 a2; b0 b1 b2];
X = X_TEST;
Y = Y_TEST;
X_tild = [ones(size(X,1),1) X];
Y_PRED = X_tild*B;

Yt = zeros(size(Y,1),1);

for i = 1:size(Y_PRED,1)
    [num, idx] = max(Y_PRED(i,:));
    Yt(i) = idx;
end

true0 = numel(Y(Y==1));
true1 = numel(Y(Y==2));
true2 = numel(Y(Y==3));

good0=0;
bad01 = 0;
bad02 = 0;
for i = 1:length(Y)
    if Y(i) == 1 && Yt(i)==Y(i)
        good0=good0+1;
    elseif Y(i) == 1 && Yt(i)== 2
        bad01 = bad01 +1;
    elseif Y(i) == 1 && Yt(i)== 3
        bad02 = bad02 +1;
    end
end

good1=0;
bad10 = 0;
bad12 = 0;
for i = 1:length(Y)
    if Y(i) == 2 && Yt(i)==Y(i)
        good1=good1+1;
    elseif Y(i) == 2 && Yt(i)== 1
        bad10 = bad10 +1;
    elseif Y(i) == 2 && Yt(i)== 3
        bad12 = bad12 +1;
    end
end

good2=0;
bad20 = 0;
bad21 = 0;
for i = 1:length(Y)
    if Y(i) == 3 && Yt(i)==Y(i)
        good2=good2+1;
    elseif Y(i) == 3 && Yt(i)== 1
        bad20 = bad20 +1;
    elseif Y(i) == 3 && Yt(i)== 2
        bad21 = bad21 +1;
    end
end
        
good_zeros = good0/true0;
good_ones = good1/true1;
good_twos = good2/true2;

% incorrect zeros predictions
zeroOnes = bad01/true1;
zeroTwos = bad02/true2;


% incorrect ones predictions
oneZeros = bad10/true0;
oneTwos = bad12/true2;


% incorrect twos predictions
twoZeros = bad20/true0;
twoOnes = bad21/true1;

con_mat = [good_zeros zeroOnes zeroTwos;...
           oneZeros good_ones oneTwos;...
           twoZeros twoOnes good_twos];
       
pure_mat = [good_zeros good_ones good_twos];
    
figure
subplot(3,2,5);
imagesc(con_mat); colorbar; title('misclassification rate');
ylabel('predicted values'); xlabel('true values');
subplot(3,2,6);
imagesc(con_mat); colorbar; title('purity');
ylabel('predicted values'); xlabel('true values');