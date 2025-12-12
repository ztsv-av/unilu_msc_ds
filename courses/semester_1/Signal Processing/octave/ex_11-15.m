 % 11
 %% 1
 f = @(t) 3*sin( pi*t/20) + cos( pi*t/40) ;
 t=linspace(0,100,201); % or t = 0:0.5:100
 figure
 plot(t,f(t),'k')
 hold on
 fn = f(t)+ randn(size(t))/5;
 plot(t,fn,'b')
 legend("f","f noise")

 N = length(t)
 tc = -floor(N/2):floor((N-1)/2);

 %%%2
 Ff_a = abs(fft(f(t)));
 Ffn = fft(fn);
 Ffn_a = abs(Ffn);
 figure
 plot(tc, [fftshift(Ff_a)', fftshift(Ffn_a)'])
 legend("|F(f)|","|F(fn)|")


 %%% 3
 figure
 plot(tc, fftshift(Ffn_a),'k')
 hold on
 th = zeros(size(t));
 th(1:25) = 1;
 th(end-24:end) =1;  %% keep an intervall [-24:25]
 th_Ffn = Ffn.*th;
 plot(tc,fftshift(abs(th_Ffn)),'g')
 title("|F(fn)| and thresholed")

  figure
  th_fn = ifft(th_Ffn);
  plot(t,f(t),'k')
  hold on
  plot(t,real(th_fn),'b')
  legend("f","f denoised")


 %%4
  t=linspace(0,100,201);
  N = length(t)
  tc = -floor(N/2):floor((N-1)/2);
  g = @(t) 5*(t >= 0 & t < 30) + (t >= 30 & t < 60) + 4*(t >= 60 & t <= 100);
  gn = g(t) + randn(size(t))/5
  figure
  plot(t,g(t),'k')
  hold on
  plot(t,gn,'b')
  legend("g","g noise")
 %%5
   Fg_a = abs(fft(g(t)));
   Fgn = fft(gn);
   Fgn_a = abs(Fgn);
   figure
   plot(tc, [fftshift(Fg_a)', fftshift(Fgn_a)'])
   legend("|F(g)|","|F(gn)|")

   figure
   plot(tc, fftshift(Fgn_a),'k')
   hold on
   th = zeros(size(t));
   th(1:25) = 1;
   th(end-24:end) =1;  %% keep an intervall [-24:25]
   th_Fgn = Fgn.*th;
   plot(tc,fftshift(abs(th_Fgn)),'g')
   title("|F(gn)| and thresholed")

   figure
   th_gn = ifft(th_Fgn);
   plot(t,g(t),'k')
   hold on
   plot(t,real(th_gn),'b')
   legend("g","g denoised")

clear all
close all



%%% exercise 13

%%% load the image package
%%% pkg load image

%%% install the package
% pkg install -forge image

%% 1
A = ones(8)
FA = fft2(A)
FAs = fftshift(FA)

%% 2
A = ones(64);
FA = fft2(A);
FAs = fftshift(FA);
figure
FAL= log(1+abs(FAs)); FALm = max(FAL(:));
imshow( 1- FAL/FALm )    %% video inversion
% not interesting


A = [ 0 255; 0 255];
A = repmat(A,64,64);
figure, imshow(A)
FA = fft2(A);


%%...
A = uint8([ 100 100; 200 200])
A = repmat(A,64,64);
figure, imshow(A);
FA = fft2(A);


%%...
A = uint8([ 100 100 200 200 200 100])
A = repmat(A, 1, 40);
A = toeplitz( A );
figure, imshow(A);

%% 3

A = zeros(256,256);
A(78:178,78:178) = 1;    %% the square
figure, imshow(A)
FA = fftshift(fft2(A));
figure, FAL= log(1+abs(FA)); FALm = max(FAL(:));
imshow( FAL/FALm )


[x,y]=meshgrid(-128:127,-128:127);
A = (x+y<63)&(x+y>-64)&(y-x<63)&(y-x>-64);    %% diamond shape
figure, imshow(A)
FA = fftshift(fft2(A));

% ...

[x,y]=meshgrid(-128:127,-128:127);
z=sqrt(x.^2+y.^2);                        %% a disc
for R= [ 4  16 32 64]                     %% radii
  A = (z<R);
  figure, imshow(A), title(['Rayon=',num2str(R)])
  FA = fftshift(fft2(A));
  figure, FAL= log(1+abs(FA)); FALm = max(FAL(:));
  imshow( FAL/FALm ), title(['TFD, Rayon=',num2str(R)])
endfor

%% 4
A = imread('lady.jpg');
figure,  imshow(A)
FA = fftshift(fft2(A));
figure, FAL= log(1+abs(FA)); FALm = max(FAL(:));
imshow( FAL/FALm )
figure; imshow(arg(FA))


B = imread('office.jpg');
figure,  imshow(B)
FB = fftshift(fft2(B));
figure, FBL= log(1+abs(FB)); FBLm = max(FBL(:));
imshow( FBL/FBLm )
figure; imshow(arg(FB))


FAB = abs(FA).*exp(i* arg(FB));
AB = ifft2(FAB);
AB(2:10,2:10)
AB= uint8(abs(AB));
AB(2:10,2:10)
figure; imshow(AB)
title(" Amplitude=lady, Phase=office")


FBA = abs(FB).*exp(i* arg(FA));
BA = ifft2(FBA);
BA(2:10,2:10)


BA= uint8(abs(BA));
figure; imshow(BA)
title(" Amplitude=office, Phase=lady")


%%%% Exercise 14

%%% 1
  A = imread('office.jpg');
  figure,  imshow(A)

  %% DFT of A
  FA = fftshift(fft2(A));
  figure, FAL= log(1+abs(FA));
         imshow( FAL/max(FAL(:)))








  %%% additive normal noise st. deviation  sig
  sig = 20;
  An = uint8( (double(A) + sig*randn(size(A))) );

  %% ...





  %% DFT of An
  %% ...



  %% plot column 100 of original and noisy
  col = 100
  figure, plot( [A(:, col) An(:,col)] )
   legend("original","noisy")












  %%%%% 2


  %% Create  frequancy response for ideal filter  h
  %%%  Ex 13 3c

  [x,y] = meshgrid(-128:127,-128:127);
  z = sqrt(x.^2+y.^2);                  %% a disc
  R = 64;
  Fh =  (z<R);
  figure, imshow(Fh), title(['Rayon=',num2str(R)])








  %% apply in frequency domain
  %....






  hAn = ifft2(FhAn);
  %% check what you get


   %% complete;;;

  figure, imshow(hAn);






   figure, plot( [A(:, col) An(:,col),hAn(:,col)] )
   legend("original","noisy","denoised")









  %%%%%%% 3

  %% even in the original image, cutting
  %% high frequencies in a non smooth way
  %% yields Gibbs effect, visible as ringing


   %% complete ...

clear all
close all



%% exercise 15


 %%%1
 A = imread('lady.jpg');
figure,  imshow(A)

 Ap = imread('ladyp.jpg');
 figure,  imshow(Ap)







 %%%2
  FA = fftshift(fft2(A));
  figure, FAL= log(1+abs(FA));
         imshow( FAL/max(FAL(:)))
%....











  %%%3
  %% inspect |Fap| to locate the spots/frequencies to remove



  %....













  %%%4

  % define the filters
   m3 = ones(3,3)/9;   % = fspecial('average');
   m5 = ones(5,5)/25;  % = fsepcial(('average', [5,5]);

   Apm3  = uint8(conv2(Ap,m3,'same'));
   figure, imshow(Apm3);

   Apm5  = uint8(conv2(Ap,m5,'same'));
   figure, imshow(Apm5);




















