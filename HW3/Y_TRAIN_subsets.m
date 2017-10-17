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