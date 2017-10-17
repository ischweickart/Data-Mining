% - Image segmentation data set
% Def: Image Segmentation is the classification of image pixels
% x(i) = [x_1(i) x_2(i) x_3(i)] in R^3
%           R      G      B
% X is a vector in R^204800x3
% 
image = imread('image.jpg');
fore = imread('mask0.jpg');
back = imread('mask1.jpg');

W = size(image,2);
H = size(image,1);

imgR = image(:,:,1); %red pixel values
rVec = reshape(imgR,[W*H,1]);
imgG = image(:,:,2);
gVec = reshape(imgG,[W*H,1]);
imgB = image(:,:,3);
bVec = reshape(imgB,[W*H,1]);

imgX = cast([rVec gVec bVec], 'double')/255.0;
% 
% y = image; %labels

% X: an N-by-3 matrix. Each of the "N" rows is a data point that corresponds to 
% a pixel in the image. Each row has 3 entries, which correspond to the RGB values
% of that pixel. Each of the "N" pixels is labeled as either 
% foreground (class 1) or background (class 0).

% Y: an N-by-1 matrix (column vector) that stores the class labels (0 or 1).
% If Y(i) = 1 then pixel "i" is foreground.
% If Y(i) = 0 then pixel "i" is background.

% TOTAL_X: an M-by-3 matrix containing all data points, both labeled and unlabeled.
% Here "M" is the total number of pixels in the image.

% IMAGE - The original image data (used to visualize the results)

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

% newImg = reshape(fx,[H W 3]);

% figure
% subplot(3,1,1);
% imagesc(newImg);
% 
% subplot(3,1,2);
% 
% subplot(3,1,3);



