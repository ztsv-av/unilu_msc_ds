%% ex_1_gray_value_quantizsation -
% Andreas Husch
% andreas.husch@uni.lu
% 2022-09-20

%% Load an RGB color image
I = imread('peppers.png');
%% Using rgb2gray to compute a grayscale image
figure;
ig = rgb2gray(I);
imagesc(ig);
axis ij;
colormap gray;

%% Quantizise using 2 to 8 bit:
figure;
for i=1:8 % number of bits i used for display (2^i colors in colormap)
    ax = subplot(2,4,i);
    title('a');
    imagesc(ig);
    colormap(ax, gray(2^i));
    colorbar(ax);
    axis off;
    title(['# of gray values:' num2str(2^i)]);     
end