%% Exercise 5 of MS_DS-19, Luxembourg 2022.
%
% Andreas Husch, University of Luxembourg, Luxembourg Centre for Systems Biomedicine, andreas.husch@uni.lu
% thanks to Florin Bernard, University of Bonn, Dept. of Computer Science, Learning and Optimisation for Visual Computing Group

%% Representation of digital images: bitmaps vs. pointclouds
clear all;
close all;

% consider a 4x4 binary binary image I
I = [0 0 1 0; ...
     0 1 1 0; ...
     0 1 1 0; ...
     0 1 0 0];
 
figure, imagesc(I), colormap(gray);
%%
% Transfer the binary matrix into a pointcloud representation of the image
% The pointcloud should be representet as an Index Matrix of Dimension 2xN
% with N=Number of "true" pixels in the Image I

[x,y] = ; % <---- YOUR CODE HERE --->
% Hint: the funtion ind2sub might be helpful for you
PC = [x';y'];

% overlay the pointcloud onto our prevously printed image
hold on;
plot(%<---- YOUR CODE HERE ----> , '*');

%% Orthogonal Procrustes analysis (rigid registration of two point-clouds)
%
% From Wikipedia:
% Procrustes had a stronghold on Mount Korydallos at Erineus, on the sacred way between
% Athens and Eleusis.[3] There he had a bed, in which he invited every passer-by to spend 
% the night, and where he set to work on them with his smith's hammer, to stretch them to fit.
% In later tellings, if the guest proved too tall, Procrustes would amputate the excess length; 
% nobody ever fit the bed exactly.[4] Procrustes continued his reign of terror until he was 
% captured by Theseus, travelling to Athens along the sacred way, 
% who "fitted" Procrustes to his own bed: 
%
% He killed Damastes, surnamed Procrustes, by compelling him to make his own body fit his bed, 
% as he had been wont to do with those of strangers. And he did this in imitation of Heracles. 
% For that hero punished those who offered him violence in the manner in which they had plotted
% to serve him.[5]
%
% X = [1 1; 3 1; 2 2]; 
% Y = [1 1.5; 3 2; 2 2.5]; 
X = [1 1; 3 1; 2 2.7; 2 0.1];
Y = [1 1.5; 3 2; 2 2.5; 2 0.9];

figure, plot(X(:,1),X(:,2), 'k+'), hold on, plot(Y(:,1),Y(:,2), 'r+'), xlim([0 4]), ylim([0 3]);
for i=1:size(X,1)
    text(X(i,1),X(i,2), ['  ' num2str(i)], 'HorizontalAlignment', 'left');
    text(Y(i,1),Y(i,2), ['  ' num2str(i)], 'HorizontalAlignment', 'left');
end

[dissimilarity,Ytransformed,transform] = procrustes(X,Y, 'scaling', false, 'reflection', false);
plot(Ytransformed(:,1),Ytransformed(:,2), 'g+'), title('rigid (rot -> schwarz)');

%% Linear registration of two homolgous point-clouds
% we are looking for a 2x2 matrix T such that X=Y*T <=> X(:,1) = Y*t1, X(:,1) = Y*t2, 
X = [1 1; 3 1; 2 2.7; 2 0.1]; % first point cloud of four points in R^2
% Y = [1 1.5; 3 2; 2 2.5; 2 0.9]; % second point cloud of four points in R^2
Y = [1   1.51; 3  1.06;  2.00  2.33; 1.99 0.10] ; % second point cloud of four points in R^2 with detection error

% this can be solved using pseudo-inverse 
A = Y;
B1 = X(:,1);
B2 = X(:,2);
t1 = % <---- YOUR CODE HERE ----> 
t2 = % <---- YOUR CODE HERE ----> 

% matlab has the special matrix invese operator \,
% in practice one will ALWAYS use \ as it is numerically more stable 
% than the PseudeoInvesere. However, analyticall it is exactly the same in
% the given case.
% solve linear system of equations using \ operator

%t1 = <---- YOUR CODE HERE ----> 
%t2 = <---- YOUR CODE HERE ----> 

T = [t1 t2]

% transform Y to X with the previously determinded matrix
Ytransformed = Y*T;

figure, plot(X(:,1),X(:,2), 'k+'), hold on, plot(Y(:,1),Y(:,2), 'r*'), xlim([0 4]), ylim([0 3]);
for i=1:size(X,1)
    text(X(i,1),X(i,2), ['  ' num2str(i)], 'HorizontalAlignment', 'left');
    text(Y(i,1),Y(i,2), ['  ' num2str(i)], 'HorizontalAlignment', 'left');
end
plot(Ytransformed(:,1),Ytransformed(:,2), 'g+'), title('linear (rot -> schwarz)');

%% Affine registration of two point-clouds
% we are looking for a 3x3 homogeneous matrix T such that X=Y*T <=> X(:,1) = Y*t1, X(:,1) = Y*t2, 
% solve linear system of equations using \ operator
Yhom = [Y ones(size(Y,1),1)];
t1 = Yhom\X(:,1);
t2 = Yhom\X(:,2);

T = [t1 t2 [0;0;1]];

YHomTransformed = Yhom*T;
Ytransformed = YHomTransformed(:,1:2);

figure, plot(X(:,1),X(:,2), 'k+'), hold on, plot(Y(:,1),Y(:,2), 'r+'), xlim([0 4]), ylim([0 3]);
for i=1:size(X,1)
    text(X(i,1),X(i,2), ['  ' num2str(i)], 'HorizontalAlignment', 'left');
    text(Y(i,1),Y(i,2), ['  ' num2str(i)], 'HorizontalAlignment', 'left');
end
plot(Ytransformed(:,1),Ytransformed(:,2), 'g+'), title('affine (rot -> schwarz)');

%% Image registration
% create image with parallel horizontal and vertical lines (a grid)
gridIm = ones(128,128);
nLines = 10;
for i=1:nLines
    lineIdx = floor((i-1)*size(gridIm,1)./(nLines-1))+1;
    gridIm(lineIdx,:) = 0;
    gridIm(min(lineIdx+1, size(gridIm,1)),:) = 0;
    gridIm(:,lineIdx) = 0;
    gridIm(:,min(lineIdx+1, size(gridIm,1))) = 0;
end
figure, imshow(gridIm);


%% Rigid transformation
alpha_rad = -pi/4; % rotation angle

R_alpha = [cos(alpha_rad) sin(alpha_rad); -sin(alpha_rad) cos(alpha_rad)]; % 2d rotation matrix from angle

rigidMatrix = zeros(3,3); % homogenous 2D transformation matrix
rigidMatrix(1:2,1:2) = R_alpha; % rotational part
rigidMatrix(3,1) = 50; % x translation
rigidMatrix(3,2) = 0; % y translation
rigidMatrix(3,3) = 1; % must be 1 in matlab (in CG other values are used for particular purposes)
rigidT = maketform('affine', rigidMatrix);


[gridRigid, xdata, ydata] = imtransform(gridIm,rigidT, 'bicubic'); % see http://blogs.mathworks.com/steve/2006/07/07/spatial-transformations-translation-confusion/
figure, imshow(gridIm);
axis([0 256 -128 128]);
axis on;

figure, imshow(gridRigid, 'XData', xdata, 'YData', ydata);
axis([0 256 -128 128]);
axis on;


%% Linear transformation
linearT = maketform('affine', [1.2 0 0; 0.8 1 0;0 0 1]);
[gridLinear, xdata, ydata] = imtransform(gridIm,linearT, 'bicubic');

figure, imshow(gridLinear, 'XData', xdata, 'YData', ydata);
axis([0 256 -128 128]);
axis on;


%% Affine transformation
affineT = maketform('affine', [1.2 0 0; 0.8 1 0; 15 5 1]);
[gridAffine, xdata, ydata] = imtransform(gridIm,affineT, 'bicubic');

figure, imshow(gridAffine, 'XData', xdata, 'YData', ydata);
axis([0 256 -128 128]);
axis on;



%% Projective transformation
U = [1 1; 1 128; 128 128; 128 1];
X = [1 1; 10 128;128 100; 128 40];
figure, plot(U(:,1),U(:,2), 'k+', 'LineWidth', 2), hold on;
plot(X(:,1),X(:,2), 'r+', 'LineWidth', 2), xlim([-10 138]), ylim([-10 138]);

% generate matrix that maps each row of U to the corresponding row of X
projT = maketform('projective', U,X); 
[gridProj, xdata, ydata] = imtransform(gridIm,projT, 'bicubic');

figure, imshow(gridProj, 'XData', xdata, 'YData', ydata);
axis([0 256 -128 128]);
axis on;


%% warp field
fSize = 10;
[mx my] = meshgrid(1:fSize,1:fSize);
x = rand(fSize,fSize);
y = rand(fSize,fSize);

figure, quiver(x,y,0), grid on; 


%% 3d affine and rotation transformation
grid3Im = ones(64,64,64)*256;
nLines = 5;
for i=1:nLines
    lineIdx = floor((i-1)*size(grid3Im,1)./(nLines-1))+1;
    grid3Im(lineIdx,:,:) = 0;
    grid3Im(:,lineIdx,:) = 0;
    grid3Im(:,:,lineIdx) = 0;
end
figure, MPR(gca,grid3Im);
colormap gray;

rot = angle2dcm(pi/4,0,0); % angle2dcm function not available in all matlab versions
shear = eye(3);
shear(1,2) = 1.5;
trans = [0 0 0];

affineMatrix = [1 0 0 0; 0 1 0 0;0 0 1 0;trans 1];
affineMatrix(1:3,1:3) = shear*rot;

affine3dT = affine3d(affineMatrix);
[grid3Affine] = imwarp(grid3Im,affine3dT); % apply 3d affine transformation

rotMatrix = [1 0 0 0; 0 1 0 0;0 0 1 0;trans 1];
rotMatrix(1:3,1:3) = rot;
rotate3dT = affine3d(rotMatrix);

[grid3Rot] = imwarp(grid3Im,rotate3dT);

figure, MPR(gca, grid3Affine), colormap gray, xlabel('shear and rotate');
figure, MPR(gca, grid3Rot), colormap gray, xlabel('rotate only');

