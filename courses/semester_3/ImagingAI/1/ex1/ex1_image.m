%% ex_1_image - RGB and grayscale images
% Andreas Husch
% andreas.husch@uni.lu
% 2022-09-14

%% Load an RGB color image
I = imread('peppers.png');

%% Using rgb2gray to compute an intensity value
figure;
ig = rgb2gray(I);
imagesc(ig);
axis ij;
colormap gray;
% Gray=0.2989×R+0.5870×G+0.1140×B

%% Using the mean of R,G,B to compute an intensity value
figure;
igmean = mean(I,3);
imagesc(igmean);
axis ij;
colormap gray;

%% Question why are the results of mean() vs rgb2gray different? Hint, type: doc rgb2gray
% Visualise the differences
imageDiff = double(ig) - igmean;
% Is the different data type part in this case part of the image difference
% or not?
figure;
image(imageDiff);
colormap hot;
%try to visualize using imagesc instead:
imagesc(imageDiff)
%what is imagesc doing?

R = I(:,:,1);  % Red value
G = I(:,:,2);  % Green value
B = I(:,:,3);  % Blue value
grey = 0.2989*R+0.5870*G+0.1140*B;
figure;
imagesc(grey);
axis ij;
colormap gray;

%% Self-Study: Visulize intensity image as surface
figure;
s = surf(ig);
s.EdgeColor = 'none';
camlight headlight;
lighting gouraud;
axis image;
colormap gray;