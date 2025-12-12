n1 = [0:299];
n2 = [300:799];
f = [cos(pi/5*n1) 2*cos(4*pi/5*n2)];

N = length(f) % define N as length of f, N = 800
n = [0:N-1]; % plot signal f from 0 to N

figure
plot(n,f);
title("Signal f")

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

 %%%% Exercise 19

  %%%   only DFT  using fft and  STFT using sftp
 clear all, close all

 %%%%% 1 2

 N = 768

 n1 = [0:511];
 n2 = [512:767];
 f = [ sin( pi/5*n1) sin(4*pi/5*n2)];
 n = [n1 n2];
 figure
 plot(n,f);
 hold on
 grid
 set(gca, "xlim",[ 440 580])
 set(gca, 'xtick', 440:10:580);
 title("Signal f")


 %%% 3

 Lfft=1024;
 Ff = fftshift(fft(f,Lfft));
 freq = linspace(-pi,pi,Lfft);

 figure
 subplot(2,1,1), plot(freq, abs(Ff)); grid
 set(gca, "xlim",[ 0 freq(end)])
 title("|Ff| on [0,pi]")
 subplot(2,1,2), plot(freq, angle(Ff));
 set(gca, "xlim",[ 0 freq(end)]) ; grid
 title("phase(Ff) on [0,pi]")


 %%%% 4


 fr = flip(f);
 figure
 plot (n, fr)
 set(gca, "xlim",[ 200 330])
 title("Signal fr, time inversion")

 Ffr = fftshift(fft(fr,Lfft));

 figure
 subplot(2,1,1), plot(freq, abs(Ffr)); grid
 set(gca, "xlim",[ 0 freq(end)])
 title("|Ffr| on [0,pi]")
 subplot(2,1,2), plot(freq, angle(Ffr));
 set(gca, "xlim",[ 0 freq(end)]) ; grid
 title("phase(Ffr) on [0,pi]")


 %%%  5
 %%%  out of program

 %%% 6

 %% similar

 %%% 7

 %% similar


 %%% 8


   win_size = 33;    %% small time window
   overlap = 16;
   WFTf = stft(f,win_size,overlap,512,2);

   figure,
   m_n = [ 0: overlap : N-1] ;
   imagesc(m_n,[0 freq(end)],WFTf), colorbar
   title(sprintf("STFT Hamming, windows size %d, overlap %d",win_size,overlap))


   win_size = 65;     %%% large time window
   overlap = 32;
   WFTf = stft(f,win_size,overlap,512,2);

   figure,
    m_n = [ 0: overlap : N-1] ;
   imagesc(m_n,[0 freq(end)],WFTf), colorbar
   title(sprintf("STFT Hamming, windows size %d, overlap %d",win_size,overlap))


 %%%%  for time reversed signal fr


   win_size = 33;    %% small time window
   overlap = 16;
   WFTfr = stft(fr,win_size,overlap,512,2);

   figure,
   m_n = [ 0: overlap : N-1] ;
   imagesc(m_n,[0 freq(end)],WFTfr), colorbar
   title(sprintf("STFT Hamming, windows size %d, overlap %d",win_size,overlap))


   win_size = 65;     %%% large time window
   overlap = 32;
   WFTfr = stft(fr,win_size,overlap,512,2);

   figure,
    m_n = [ 0: overlap : N-1] ;
   imagesc(m_n,[0 freq(end)],WFTfr), colorbar
   title(sprintf("STFT Hamming, windows size %d, overlap %d",win_size,overlap))




pause

 %%%%%   9

 clear all, close all

N = 700
n = [0:N-1];
f = zeros(size(n));

f(1:300)=10.*sin( pi.*[0:299]./5000+ (pi.*[0:299]).^2./12000);

f(350:449)=15.*exp(-([0:99]./10.-5).^2);

f(501:700)=10.*sin([0:199]./(pi));

  figure
  plot(n,f);
  title("Signal f")


 %%%% FFT

 Lfft = 1024;
 Ff = fftshift(fft(f,Lfft));
 freq = linspace(-pi,pi,Lfft);

   figure
   subplot(2,1,1), plot(freq, abs(Ff)); grid
   set(gca, "xlim",[ 0 freq(end)])
   title("|Ff| on [0,pi]")
   subplot(2,1,2), plot(freq, angle(Ff));
   set(gca, "xlim",[ 0 freq(end)]) ; grid
   title("phase(Ff) on [0,pi]")



 %%% STFT


 win_size = 65;
 overlap = 32;
 WFTf = stft(f,win_size,overlap,512,2);

   figure, colormap("hot");
   m_n = [ 0: overlap : N-1] ;
   imagesc(m_n,[0 freq(end)],WFTf), colorbar
   title(sprintf("STFT Hamming, windows size %d, overlap %d",win_size,overlap))


