grid = [1 1 0 0 ; 1 0 1 0 ; 0 0 1 0 ; 1 1 0 0 ; 0 0 1 0];
disp(grid);

% The area of a binary image object is the total number of pixels in the object (the number of 1s).
% The contour length (or perimeter) is the number of boundary pixels around the object. You can calculate this by counting how many sides of the 1s are adjacent to a 0.
% Pixel Connectivity: Depending on whether we use 4-connectivity (only vertical and horizontal neighbors) or 8-connectivity (including diagonal neighbors), the perimeter might slightly differ, but typically, the above counts for 4-connectivity.
% 4D: contour length 10; 8D: 12

% Euler number is the difference of the number C of components minus the number H of holes
% E=-1:
% 0 0 0 0 0 0 0
% 0 1 1 1 1 1 0
% 0 1 0 1 0 1 0
% 0 1 1 1 1 1 0
% 0 0 0 0 0 0 0
% E=-2:
% 1 1 1 1 1 1 1
% 1 0 1 0 0 0 1
% 1 1 1 0 0 0 1
% 1 0 1 0 0 0 1
% 1 1 1 1 1 1 1

% 2.6
img = imread("coins.png");
bw = imbinarize(img);
imshow(bw);
imhist(img);

% 2.7, 2.8
thres = 85;
if size(img, 3) == 3
    img = rgb2gray(img);
end
binaryImg = img < thres;
figure;
subplot(1, 2, 1), imshow(img), title('Original Image');
subplot(1, 2, 2), imshow(binaryImg), title('Binarized Image (Threshold = 85)');

% 2.9
img = imread("circlesBrightDark.png");
imshow(img);
imhist(img);

thresh = multithresh(img,2); % 2 threshold levels => 3 classes
labels = imquantize(img,thresh);
imshow(labels);
title("Segmented BW Image");
labelsRGB = label2rgb(labels);
imshow(labelsRGB)
title("Segmented RGB Image")

% 2.11
img = imread("hawkes_bay_raw.jpg");
imshow(img);