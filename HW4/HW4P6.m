img = imread('colors.jpg'); %import 500x500 pixel image
img = double(img(:,:,1) + img(:,:,2) + img(:,:,3)); %convert to gray scale

[U,S,V] = svd(img);
true_rank = rank(img);
plot_ = 1;
rank_ = [true_rank, 10, 50, 200];

figure;
for k = rank_
    img_k = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
    subplot(3,2,plot_); 
    imagesc(img_k); title(['rank = ' num2str(k) ]); colormap('Gray');
    if plot_ == 1;
        colorbar;
    end
    plot_ = plot_ + 1;
end

for i = 1:4
    X = U(:,i) * V(:,i)';
    subplot(6,4,16+i);
    imagesc(X); set(gca, 'XTickLabel',[]);
    if i == 1
        title('Largest SV');
    else
        set(gca, 'YTickLabel',[]);
    end
end

len = length(img);
for j = 0:3
    Y = U(:,len-j) * V(:,len-j)';
    subplot(6,4,21+j);
    imagesc(Y);
    if j > 0
        set(gca, 'YTickLabel',[]);
        if j == 3
            title('Smallest SV');
        end
    end
end