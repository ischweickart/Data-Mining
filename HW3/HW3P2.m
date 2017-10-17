% Change Y_TRAIN to 1s and -1s

% class matrices
Zeros = Y_TRAIN(Y_TRAIN==1);
Ones = Y_TRAIN(Y_TRAIN==2);
Twos =Y_TRAIN(Y_TRAIN==3);

% subset indices
idx1 = length(Zeros)+1;
idx2 = length(Zeros)+ length(Ones) + 1;

% 1 vs 2
Y0v1 = zeros(size(Y_TRAIN));
for i = 1:length(Y_TRAIN)
    if Y_TRAIN(i) == 2
        Y0v1(i) = -1;
    elseif Y_TRAIN(i) == 1
            Y0v1(i) = 1;
    end
end
Y0v1=Y0v1(Y0v1~=0);
X0v1=X_TRAIN(1:idx2-1,:);

% 1 vs 3
Y0v2 = zeros(size(Y_TRAIN));
for i = 1:length(Y_TRAIN)
    if Y_TRAIN(i) == 3
        Y0v2(i) = -1;
    elseif Y_TRAIN(i) == 1
            Y0v2(i) = 1;
    end
end
Y0v2=Y0v2(Y0v2~=0);
X0v2=[X_TRAIN(1:idx1-1,:); X_TRAIN(idx2:end,:)];

% 2 vs 3
Y1v2 = zeros(size(Y_TRAIN));
for i = 1:length(Y_TRAIN)
    if Y_TRAIN(i) == 3
        Y1v2(i) = -1;
    elseif Y_TRAIN(i) == 2
            Y1v2(i) = 1;
    end
end
Y1v2=Y1v2(Y1v2~=0);
X1v2=X_TRAIN(idx1:end,:);

% 1 vs all
Y0vAll = -1*ones(length(Y_TRAIN),1);
for i = 1:length(Y_TRAIN)
    if Y_TRAIN(i) == 1
        Y0vAll(i) = 1;
    end
end

% 2 vs all
Y1vAll = -1*ones(length(Y_TRAIN),1);
for i = 1:length(Y_TRAIN)
    if Y_TRAIN(i) == 2
        Y1vAll(i) = 1;
    end
end

% 3 vs all
Y2vAll = -1*ones(length(Y_TRAIN),1);
for i = 1:length(Y_TRAIN)
    if Y_TRAIN(i) == 3
        Y2vAll(i) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% plot separating hyperplanes
%
[a01, b01] = SoftSVM(X0v1,Y0v1,0);

[a02, b02] = SoftSVM(X0v2,Y0v2,0);

[a12, b12] = SoftSVM(X1v2,Y1v2,0);

figure
% plot 0s vs 1s
subplot(3,3,1)
imagesc(reshape(b01,28,28)');
title('0s vs 1s hyperplane')

% plot 0s vs 2s
subplot(3,3,2)
imagesc(reshape(b02,28,28)');
title('0s vs 2s hyperplane')

% plot 1s vs 2s
subplot(3,3,3)
imagesc(reshape(b12,28,28)');
title('1s vs 2s hyperplane')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% classification accuracy
%
lambda = [0 .01 .1 1 10 100];
acc = zeros(length(lambda),3);
true0 = numel(Y(Y==1));
true1 = numel(Y(Y==2));
true2 = numel(Y(Y==3));

for i = 1:length(lambda)
    [a0, b0] = SoftSVM(X_TRAIN,Y0vAll,lambda(i));
    [a1, b1] = SoftSVM(X_TRAIN,Y1vAll,lambda(i));
    [a2, b2] = SoftSVM(X_TRAIN,Y2vAll,lambda(i));
    B = [a0 a1 a2; b0 b1 b2];
    X = X_TEST;
    Y = Y_TEST;
    X_tild = [ones(size(X,1),1) X];
    Y_PRED = X_tild*B;
    Yt = zeros(size(Y,1),1);
    for j = 1:size(Y_PRED,1)
        [num, idx] = max(Y_PRED(j,:));
        Yt(j) = idx;
    end
    acc0 = 0;
    for a = 1:length(Y)
        if Y(a) == 1 && Yt(a)==Y(a)
            acc0=acc0+1;
        end
    end
    acc1 = 0;
    for b = 1:length(Y)
        if Y(b) == 2 && Yt(b)==Y(b)
            acc1=acc1+1;
        end
    end
    acc2 = 0;
    for c = 1:length(Y)
        if Y(c) == 3 && Yt(c)==Y(c)
            acc2=acc2+1;
        end
    end
    acc(i,1) = acc0/true0; 
    acc(i,2) = acc1/true1; 
    acc(i,3) = acc2/true2; 
end



subplot(3,3,4);
semilogx(lambda, acc(:,1));title('0');xlabel('lambda');ylabel('accuracy');
subplot(3,3,5);
semilogx(lambda, acc(:,2));title('1');xlabel('lambda');ylabel('accuracy');
subplot(3,3,6);
semilogx(lambda, acc(:,3));title('2');xlabel('lambda');ylabel('accuracy');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% confusion matrix
%
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
    
subplot(3,2,5);
imagesc(con_mat); colorbar; title('misclassification rate');
ylabel('predicted values'); xlabel('true values');
subplot(3,2,6);
imagesc(con_mat); colorbar; title('purity');
ylabel('predicted values'); xlabel('true values');