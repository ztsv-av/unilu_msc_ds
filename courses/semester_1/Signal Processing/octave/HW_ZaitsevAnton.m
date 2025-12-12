%% Name: Zaitsev
%% First name: Anton

% for imread, imshow
%   if necessary, in command line:
%   pkg load image
%   or
%   pkg install -forge image




%% Exercise 1

clc; clear all; close all; % clear all variables and images
% pkg load image

%%% 1

Im1 = imread('Im1.jpg'); % load image
whos Im1
Im1 = double(Im1)/255;  % normalization on [0,1]
whos Im1

figure, imshow(Im1); % plot image
title('Image 1 | Noisy')

% When we plot the graph of the Im1.jpg we can clearly
%   see the presense of noise in the image,
%   i.e. almost horizontal lines that go along
%   the whole image

%%% 2

m3 = ones(3,3)/9; # define mean filter 3 by 3
Im1m3 = (conv2(Im1,m3,'same')); % perform convolution of the image and the filter
figure, imshow(Im1m3) % plot image after applying mean filter
title('Mean filter 3x3 on Image 1')

% Here, perform the same steps as with 3x3 filter,
%   but increase the size of the filter to 5x5
m5 = ones(5,5)/25; # define mean filter 5 by 5
Im1m5 = (conv2(Im1,m5,'same'));
figure, imshow(Im1m5)
title('Mean filter 5x5 on Image 1')

% We can notice that as we increase the size of the mean filter
%   the image becomes more "smooth",
%   i.e filter adds a blurring effect to the image.
% The filter replaces each pixel value by the average value of itself
%   and its 8 or 24 neighboring pixels (3x3 or 5x5 filters respectively)

%%% 3

% Perform Fourier Transform in 2D
%   and shift lower frequences to the center of the spectrum
%   so that the zero frequency component
%   is located right at the center of the plot of the amplitude
FIm1 = fftshift(fft2(Im1));
% Compute the amplitude of the Fourier Transform
%   and convert to logarithmic scale (+1 to avoid computational issues).
% Next, when showing the image, normalize it, i.e. scale each value
%   in the range [0,1]
figure, FIm1L = log(1+abs(FIm1)); imshow( FIm1L/max(FIm1L(:)));
title("FFT of Image 1");
% We can notice 4 "anomalies", disks that are located on the same line.
% These anomalies represent the noise in the original image.

%%% 4

C = [[240, 256]; [245, 215]; [260, 123]; [266, 82]];
% C contains the approximate centers of the regions of the "anomalies"
%   which appeared seem due to noise.

%%% 5

% We can create a filter Fh that will nullify the "anomlies" present
%   in the original image.
% To do this, we can create a matrix with ones of the size of the original image
%   and add 4 circles filled with zeros with the centers specified in C.
% The radius of the "anomalies" is approximately 12-18.
% Let us  define 4 circles with centers defined in C with radii 16.
% The bigger the radius, the more information we will lose, but 16 should be fine.
R = 16; % define radius of "anomalies"
[x,y] = meshgrid(1:size(Im1)(2), 1:size(Im1)(1)); % define a coordinate matrix of size Im1
z1 = sqrt((x-240).^2+(y-256).^2); % define circle of first anomaly at center (240, 256)
z2 = sqrt((x-245).^2+(y-215).^2); % define circle of second anomaly at center (245, 215)
z3 = sqrt((x-260).^2+(y-123).^2); % define circle of third anomaly at center (260, 123)
z4 = sqrt((x-266).^2+(y-82).^2); % define circle of fourth anomaly at center (266, 82)
Fh = ~((z1 < R) | (z2 < R) | (z3 < R) | (z4 < R)); % put 1's outside the circles, 0 otherwise
figure, imshow(Fh)
title(['"FFT of filter h | radius=',num2str(R)]);

%%% 6

% Now, multiply amplitude of the Fourier Transform of the original signal
%   with the defined filter to remove "anomalies" that create noise in the image.
FhIm1 = Fh .* FIm1;
figure, FhIm1L = log(1+abs(FhIm1)); imshow( FhIm1L/max(FhIm1L(:)));
title("FFT of filtered Image 1")

%%% 7

% Reconstruct "denoised" signal using inverse Fourier Transform.
% Note that most of the noise that was present in the original image is gone,
%   meaning that 4 anomalies that were identified in the amplitude of the
%   Fourier Transform of the original image indeed depicted the noise
%   that we wanted to remove.
hIm1 = ifft2(ifftshift(FhIm1));
figure, imshow(abs(hIm1));
title("Reconstruction of Image 1")




%% Exercise 2

clc; clear all; close all; % clear all variables and images

%%% 1

load -binary  signal_hw.bin f % load signal f from signal_hw.bin file

N = length(f) % define N as length of f, N = 800
n = [0:N-1]; % plot signal f from 0 to N

figure
plot(n,f);
title("Signal f")

%%% 2

Lfft=1024; % define zero-padding up to 2^10=1024
Ff = fftshift(fft(f,Lfft)); % compute FFT of the zero-padded signal
freq = linspace(-pi,pi,Lfft); % create a space of length of frequences 1024 from -pi to pi

figure
subplot(2,1,1), plot(freq, abs(Ff)); grid
set(gca, "xlim",[0 freq(end)]) % limit plot to [0, pi]
title("Amplitude |Ff| on [0,pi]")
subplot(2,1,2), plot(freq, angle(Ff)); grid
set(gca, "xlim",[0 freq(end)])  % limit plot to [0, pi]
title("Phase(Ff) on [0,pi]")

%%% 3

fr = flip(f); % "flip" the signal, i.e. time-inverse signal f
figure
plot(n,fr);
title("Signal fr")

Ffr = fftshift(fft(fr,Lfft)); % compute FFT of the zero-padded signal

figure
subplot(2,1,1), plot(freq, abs(Ffr)); grid % plot amplitude of Ffr
set(gca, "xlim",[0 freq(end)]) % limit plot to [0, pi]
title("Amplitude |Ffr| on [0,pi]")
subplot(2,1,2), plot(freq, angle(Ffr)); grid % plot phase of Ffr
set(gca, "xlim",[0 freq(end)])  % limit plot to [0, pi]
title("Phase(Ffr) on [0,pi]")

%%% 4

% We have a real finite discrete signal of length 800,
%   which appears to be a combination of two periodic functions.
% The first function is defined approximately on the interval n1=[0:499] with a period of 10.
% The maximum value of the first function is 1, minimum is -1.
% For a period of 10 and maximum 1 we have a function sin(pi/5*n1).
% The second function is defined approximately on the interval n2=[299:799] with of period of 5.
% The maximum value of the second function is 2, minimum is -2 (sin function multiplied by 2).
% For a period of 5 and maximum 2 we have a function 2*sin(2*pi/5*n2).
% However, if we look at the amplitude plot, the highest frequency lies in the interval [2.5,2.6],
%   but 2*pi/5 lies in in the interval [1.2,1.3]. To solve this, we can multiply 2*pi/5 by 2
%   and get function 2*sin(4*pi/5*n2), which frequency lies exactly in the interval [2.5,2.6].
% Since the amplitude shows only 2 frequences,
%   we can deduce that we have a sum of exactly these two functions on the interval [299:499],
%   the maximum value of the sum on this inteval is 3, minimum is -3.
% Judging by the plot of the amplitude,
%   the second, higher frequency, is the most present in the signal,
%   since its amplitude is higher.
% Thus, the second function, 2*sin(4*pi/5*n2), is the most present in the signal,
%   and it is multiplied by a higher constant in the sum.
% The maximum (minimum) value of sin(pi/5*n1)+2*sin(4*pi/5*n2) is exactly 3 (-3).

% Also, we can notice that as we time-inverse the signal f,
%   the amplitude of the FFT of f and fr remains the same, while the phase is reflected across the y-axis.
% This is natural, since we consider the real signal f,
%   and the amplitude for real signals is an even function, while the phase is an odd function.
% Amplitude is independent of time orientation.
% A(-t) = A(t), Phi(-t) = -Phi(t)

%%% 5

win_size = 33; % small time window 33
overlap = 16; % window overlap of 16

% Short-time Fourier Transform with Hamming window of signal f, window size 33, window overlap 16
WFTf = stft(f,win_size,overlap,512,2);

figure,
m_n = [ 0: overlap : N-1] ;
imagesc(m_n,[0 freq(end)],WFTf), colorbar
title(sprintf("STFT Hamming, signal f, windows size %d, overlap %d",win_size,overlap))

% Short-time Fourier Transform with Hamming window of signal fr, window size 33, window overlap 16
WFTfr = stft(fr,win_size,overlap,512,2);

figure,
m_n = [ 0: overlap : N-1] ;
imagesc(m_n,[0 freq(end)],WFTfr), colorbar
title(sprintf("STFT Hamming, signal fr, windows size %d, overlap %d",win_size,overlap))

win_size = 65; % large time window 65
overlap = 32; % window overlap of 32

% Short-time Fourier Transform with Hamming window of signal f, window size 65, window overlap 32
WFTf = stft(f,win_size,overlap,512,2);

figure,
m_n = [ 0: overlap : N-1] ;
imagesc(m_n,[0 freq(end)],WFTf), colorbar
title(sprintf("STFT Hamming, signal f, windows size %d, overlap %d",win_size,overlap))

% Short-time Fourier Transform with Hamming window of signal fr, window size 65, window overlap 32
WFTfr = stft(fr,win_size,overlap,512,2);

figure,
m_n = [ 0: overlap : N-1] ;
imagesc(m_n,[0 freq(end)],WFTfr), colorbar
title(sprintf("STFT Hamming, signal fr, windows size %d, overlap %d",win_size,overlap))

%%% 6

% Again, by looking at the plot of the WFT, we notice the overlap of two most present frequencies
%   on the time interval [299:499].
% Also, WTF allows us to exactly tell when the first frequency ends and where the second one starts.
% Just by looking at the plot of WTF we can tell that the first frequency is present around the interval [0:499],
%   the second frequency is present around the interval [299:799] and there is an overlap of these two frequences
%   around the interval [299:499].
% The higher frequency, with its amplitude approximately equal to 2.5 is the most present in the signal.

% As we increase the windows size for both f and fr,
%   we obtain better frequency localization, but worse time localization,
%   due to the trade-off between time and frequency resolution.
% Also, as we time-inverse the signal and compute its STFT, we observe
%   a reversal along the time axis compared to the STFT of the original signal.
% Time-inverting the signal essentially reflects the entire signal around the origin,
%   which is why when we compute windowed Fourier Transform of the time-inversed signal,
%   we obtain a mirror image of the windowed Fourier Transform of the original signal.

%%% 7

% Using our deductions from Questions 4 and 6,
%   we can propose the following defition of signal f (and thus fr):
n1 = [0:299];
n2 = [300:499];
n3 = [500:799];
f = [sin(pi/5*n1) sin(pi/5*n2)+2*sin(4*pi/5*n2) 2*sin(4*pi/5*n3)];

N = length(f)
n = [0:N-1];

figure
plot(n,f);
title("Deduced signal f")

Lfft=1024;
Ff = fftshift(fft(f,Lfft));
freq = linspace(-pi,pi,Lfft);

figure
subplot(2,1,1), plot(freq, abs(Ff)); grid
set(gca, "xlim",[0 freq(end)])
title("Amplitude |Ff| of deduced signal on [0,pi]")
subplot(2,1,2), plot(freq, angle(Ff)); grid
set(gca, "xlim",[0 freq(end)])
title("Phase(Ff) of deduced signal on [0,pi]")

% We notice a slight difference in the phase between the original signal and proposed signal.
% If we investigate further, we can notice that the value of the original signal at x=0 is different
%   from the value of proposed signal at x=0.
% Thus, there must be some additional constant added to the angle of the sin functions
