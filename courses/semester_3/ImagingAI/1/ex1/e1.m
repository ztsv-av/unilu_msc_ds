% 1.1
% --- 1 ---
% read image
image = imread("cameraman.tif");
% display image
imshow(image);
% save image
imwrite(image, "cameraman_.gif") % 2nd
imwrite(image, "cameraman_.tif") % 1st largest
imwrite(image, "cameraman_.png") % 3rd
imwrite(image, "cameraman_.jpg") % 4th

% --- 2 ---
% find the minimum and maximum intensity values
min_val = min(image(:));
max_val = max(image(:));
% display the intensity range
fprintf('Intensity range: [%d, %d]\n', min_val, max_val);
% scale image
image_scaled = double(image) / 255;
% display the scaled gray value image
figure;
imshow(image_scaled);
title('Scaled Gray Value Image [0, 1]');
% convert to binary image using a threshold (e.g., 0.5)
i_binary = imbinarize(image_scaled, 0.5);
% display the binary image
figure;
imshow(i_binary);
title('Binary Image');

% --- 3 ---
% read png image
image_rgb = imread("peppers.png");
% display image
imshow(image_rgb);
% get the size and dimensions of the image array
image_size = size(image_rgb);
% display the size and dimensions
fprintf('Size of the image array: %d x %d x %d\n', image_size(1), image_size(2), image_size(3));

% --- 4 ---
% read the indexed image and colormap
[I, Imap] = imread('corn.tif');
% get image size
image_size = size(I);
fprintf('Size of the image array: %d x %d\n', image_size(1), image_size(2));
% display image with / without color map
figure;
imshow(I);
title('Grayscale Image without Colormap');
figure;
imshow(I, Imap);
title('Indexed Image with Colormap');

% --- 5 ---
image_rgb = imread("peppers.png");
R = image_rgb(:,:,1);
G = image_rgb(:,:,2);
B = image_rgb(:,:,3);
% display the Red component
figure;
imshow(R);
title('Red Component');
% display the Green component
figure;
imshow(G);
title('Green Component');
% display the Blue component
figure;
imshow(B);
title('Blue Component');

% Create a red-only image
redImage = cat(3, R, zeros(size(R)), zeros(size(R)));
% Create a green-only image
greenImage = cat(3, zeros(size(G)), G, zeros(size(G)));
% Create a blue-only image
blueImage = cat(3, zeros(size(B)), zeros(size(B)), B);
% display the Red component
figure;
imshow(redImage);
title('Red Component');
% display the Green component
figure;
imshow(greenImage);
title('Green Component');
% display the Blue component
figure;
imshow(blueImage);
title('Blue Component');

% --- 6 ---
% read the grayscale image and resize it to 512x512
I = imread('cameraman.tif');
I_resized = imresize(I, [512, 512]);
% display the resized grayscale image
figure;
imshow(I_resized);
hold on;
title('Resized Grayscale Image with Intensity Profile (512x512)');
% define the start and end points of the line for the intensity profile
x1 = 1; % starting x-coordinate
y1 = 256; % middle y-coordinate (line row at half of the image height)
x2 = 512; % end x-coordinate (full width of image)
y2 = 256; % same y-coordinate (horizontal line at row 256)
% draw a line on the image to show where the profile is taken
line([x1, x2], [y1, y2], 'Color', 'r', 'LineWidth', 2);
% extract the intensity values along the line
intensity_profile = improfile(I_resized, [x1, x2], [y1, y2]);
% resize the intensity profile to match a 128x128 plot (downsampling)
intensity_profile_resized = imresize(intensity_profile, [128, 1]);
% create an inset axes for the intensity profile at the bottom left
profile_axes = axes('Position', [0.65, 0.6, 0.3, 0.3]); % [x, y, width, height]
% plot the intensity profile on the inset axes
plot(profile_axes, intensity_profile_resized, 'LineWidth', 2);
xlabel(profile_axes, 'Pixel Position');
ylabel(profile_axes, 'Intensity');
title(profile_axes, 'Intensity Profile');
hold off;

% --- 7 ---
% read the grayscale image
I = imread('cameraman.tif');
% display the original grayscale image
figure;
imshow(I);
title('Original Grayscale Image');
% create a custom colormap (e.g., transitioning from blue to red)
custom_cmap = [linspace(0, 0.7, 256)' ...   % red component
               linspace(0, 0.5, 256)' ...   % green component
               linspace(0, 0.5, 256)'];     % blue component
% display the grayscale image with the custom colormap
figure;
imshow(I);
colormap(custom_cmap);   % apply the custom colormap
colorbar;                % show colorbar to indicate color scale
title('Pseudo-Color Image with Custom Colormap');

% 1.2
% --- 1.9 ---
% read the grayscale image
I = imread('cameraman.tif');
% Display the original grayscale image
figure;
imshow(I);
title('Original Grayscale Image');
% Step 1: Calculate the histogram of the grayscale image
[h, bins] = imhist(I);  % h is the histogram counts, bins are the intensity levels (0-255)
% Step 2: Normalize the histogram to obtain the PDF (discrete probability density function)
pdf = h / sum(h);  % Normalize by the total number of pixels
% Step 3: Calculate the cumulative distribution function (CDF) from the PDF
cdf = cumsum(pdf);
% Step 4: Plot the histogram, PDF, and CDF
% Plot the histogram
figure;
subplot(3,1,1);
bar(bins, h);
xlabel('Intensity Values');
ylabel('Frequency');
title('Grayscale Image Histogram');
% Plot the PDF
subplot(3,1,2);
plot(bins, pdf, 'LineWidth', 2);
xlabel('Intensity Values');
ylabel('PDF');
title('Probability Density Function (PDF)');
% Plot the CDF
subplot(3,1,3);
plot(bins, cdf, 'LineWidth', 2);
xlabel('Intensity Values');
ylabel('CDF');
title('Cumulative Distribution Function (CDF)');

% --- 1.10 ---
% Step 1: Read the original grayscale image
G = imread('cameraman.tif');
% Display the original grayscale image
figure;
imshow(G);
title('Original Grayscale Image (G)');
% Step 2: Calculate the histogram and cumulative distribution function (CDF)
[h, bins] = imhist(G);   % Histogram of the image
pdf = h / sum(h);        % Normalize the histogram to get PDF
cdf = cumsum(pdf);       % Calculate the cumulative distribution function (CDF)
% Step 3: Use the CDF to transform the original image into the new image Gt
% The CDF will map the original pixel intensities to new values
G_t = uint8(255 * cdf(double(G) + 1));  % Add 1 because image indices start from 1 in MATLAB
% Step 4: Display the transformed image
figure;
imshow(G_t);
title('Transformed Grayscale Image (Gt) using CDF');
% Step 5: Compare histograms of the original and transformed images
% Histogram of original image
figure;
subplot(2,1,1);
imhist(G);
title('Histogram of Original Image (G)');
% Histogram of transformed image
subplot(2,1,2);
imhist(G_t);
title('Histogram of Transformed Image (Gt)');

% 1.11
% Read the grayscale image
I = imread('cameraman.tif');
% Calculate the mean value of the gray values
g_mean = mean(I(:));
% Calculate the variance of the gray values
g_variance = var(double(I(:)));
% Calculate the minimum and maximum gray values
g_min = min(I(:));
g_max = max(I(:));
% Display the results
fprintf('Mean value (g): %.2f\n', g_mean);
fprintf('Variance (σ^2): %.2f\n', g_variance);
fprintf('Minimum value (gmin): %d\n', g_min);
fprintf('Maximum value (gmax): %d\n', g_max);

% --- 1.12 ---
% Read the grayscale image
G = imread('cameraman.tif');  % Replace 'cameraman.tif' with your image if needed
% Convert to binary image: b(x,y) = 1 if g(x,y) > 0, otherwise 0
B = G > 128;  % This creates a binary image
% Display the binary image
imshow(B);
title('Binary Image (Direct Threshold)');
% Read the grayscale image
G = imread('cameraman.tif');  % Replace 'cameraman.tif' with your image if needed
% Create a look-up table (LUT) that maps pixel intensities to binary values
LUT = zeros(256, 1);  % LUT initialized to zeros
LUT(129:end) = 1;       % For all non-zero values, set binary value to 1
% Apply the LUT to transform the image to binary
B_lut = LUT(double(G) + 1);  % G is indexed by its pixel values
% Display the binary image
imshow(B_lut);
title('Binary Image (LUT Transformation)');

% --- 1.13 ---
% Initialize the image of size 256x256 with zeros
image_size = 512;
num_stripes = 8;
stripe_width = image_size / num_stripes;  % Height of each stripe
% Create an empty image
stripe_image = zeros(image_size, image_size);
% Assign intensity values to each stripe (starting from 32 and stepping by 32)
intensity_values = 32:32:256;
for i = 1:num_stripes
    % Calculate the row indices for the current stripe
    start_row = (i - 1) * stripe_width + 1;
    end_row = i * stripe_width;
    % Assign the intensity value to the stripe
    stripe_image(:, start_row:end_row) = intensity_values(i);
end
% Convert the image to uint8 format for display
stripe_image = uint8(stripe_image);
% Display the image
imshow(stripe_image);