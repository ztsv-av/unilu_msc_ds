%% ex_1_downsample
% Andreas Husch
% andreas.husch@uni.lu 
% 2022-09-14

%% Go through the example by evaluting the script section by section 
% (right click "Evaluate current section" or use the OS dependent keyboard shurtcut)

%% Load example mri data and show it
load mri;
figure('Name', 'A single axial slice from the Stack');
slice = D(:,:,10);
colormap(gray);
THRESHOLD = 60;
thrSlice = slice > THRESHOLD;
 

subplot(2,2,1);
s = pcolor(slice);
s.EdgeColor = 'b';
axis image;
axis ij;
axis off;


subplot(1,3,1);
s = pcolor(thrSlice);
s.EdgeColor = 'b';
axis image;
axis ij;
axis off;

subplot(1,3,2);
s = pcolor(imresize(thrSlice,0.5));
s.EdgeColor = 'b';

axis image;
axis ij;
axis off;

subplot(1,3,3);
s = pcolor(imresize(imresize(thrSlice,0.5), 0.5));
s.EdgeColor = 'b';

axis image;
axis ij;
axis off;

