%% ex_1_1
% Andreas Husch
% andreas.husch@uni.lu
% 2022-09-14

%% Go through the example by evaluting the script section by section 
% (right click "Evaluate current section" or use the OS dependent keyboard shurtcut)

%% Load example mri data and show it
load mri;
figure('Name', 'Show the MRI image stack as individual axial slices');
montage(D);
image_size = size(D);

%% Apply a specific windowing by using a specifically defined "color"map 
montage(D, map);

%% A single axial slice from the Stack
figure('Name', 'A single axial slice from the Stack');
slice = D(:,:,10);
imagesc(slice); % Exercise: what is the differnce between "image" and "imagesc";

%% Apply Colormap? Try several
colormap(winter);
%colormap(map)

%% Have a look at the histogram
figure;
imhist(slice);
title('Histogram of MRI slice');

%% Work on binary images
figure;
colormap(gray);
imagesc(imbinarize(slice));  % binarize image using Otsu's method
title('Binarized image using Otsu method');

%% Work on binary images II - own treshold
figure;
THRESHOLD = 60;
colormap(gray);
imagesc(slice > THRESHOLD);

%% Interactive Windowing using the imcontrast tool
figure('Name', 'A single axial slice from the Stack');
slice = D(:,:,5);
imagesc(slice); 
imcontrast;


