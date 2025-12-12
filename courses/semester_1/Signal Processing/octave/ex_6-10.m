% Exercise 7

%% 4

N = 8;  % Period N
n = (-3*N)/2:(3*N)/2;  % Values of n from 0 to N-1
w = 2*pi/N;  % Frequency parameter

fr = cos(w * n);

figure
plot(n, fr)
title('Real Part of N-Periodic Exponential Signals Over 3 Periods');

%% 5

n = -12:12
fn = cos(n)
figure
plot(n, fn)
title('cos(n) for n in [-12,12]');

% Exercise 8

%%1

% FTDT
Ff = @(nu) e.^(-2*i*nu).*(sin(5*nu/2)./sin(nu/2))
nu = linspace(-3*pi,3*pi,500);

figure
plot(nu, abs(Ff(nu)))
hold on
grid
title(" |FTDT| over 3 periods ")

figure
plot(nu, fftshift(abs(Ff(nu))))
hold on
grid
title(" |FTDT| over 3 periods ")


figure
plot(nu, arg(Ff(nu)))
hold on
grid
title(" Arg(FTDT) over 3 periods ")


%% 2

% definition of f[n]
n = -10:20 ;
support = [0:10]
f = (n >=support(1)) & (n<=support(end))


figure
axis([-10,20,0,2])
hold on
grid
stem(n,f,"r")
title('Signal f')

%% 3

fp = ones(size(support));
N = length(fp) % length N = 5

figure
axis([-10,20,0,2])
hold on
stem(n,ones(size(n)),"r")
title('Signal fp, period 5')

%% 4

DFf = fft(fp)
DFf_long = zeros(size(n));
DFf_long(11:11+N-1) = DFf;

figure
DFfp_long = [ repmat( DFf, 1,6) , 5];
stem(n,DFfp_long,'r')
title('FT of fp')

figure
stem(n,DFf_long,'r')
hold on
title('FT of finite f')

figure
DFfp_long = [ repmat( DFf, 1,6) , 5];
stem(n,DFfp_long,'r')
title('FT of fp')

%% 5

% Fourier transform in discrete time
Ff = @(nu) e.^(-2*i*nu).*(sin(5*nu/2)./sin(nu/2))

nu = linspace(-10,20,2000);
Ff_sa = abs( Ff(2*pi*nu/N) ) ;


figure
stem(n,DFf_long,'r')
hold on
plot(nu, Ff_sa,"k")
legend("|DFT|","|FT|")
title("Finite discrete signal")

figure
stem(n,DFfp_long,'r')
hold on
plot(nu, Ff_sa,"k")
legend("|DFT|","|FT|")
title("Periodic discrete signal")

Ff_sp = arg( Ff(2*pi*nu/N) ) ;

figure
stem(n,arg(DFf_long),'r')
hold on
plot(nu, Ff_sp,"k")
legend("arg(DFT)","arg(FT)")
title("Finite discrete signal")

figure
stem(n,arg(DFfp_long),'r')
hold on
plot(nu, Ff_sp,"k")
legend("arg(DFT)","arg(FT)")
title("Periodic discrete signal")

%% 6

fp = [ ones(size(support)) zeros(1,5)]
N = length(fp) % length N = 10

%% this defines the signal
%% adpating the previous gives the r

nu = linspace(-10,20,2000);

figure
axis([-10,20,0,2])
hold on
stem(n,[repmat(fp,1,3), 1],"r")
title('Signal fp, period 10')

%% Exercicve 9


 %%% Commands which center the DFT around 0 (low) frequency
 %%% This is also done by the   fftshift command
 N = 10
 n = [0:N-1]
 nc = [ -N/2 : N/2-1]
 floor(N/2)
 floor((N-1)/2)


 N = 11
 n = [0:N-1]
 nc = [ -(N-1)/2 : (N-1)/2 ]
 floor(N/2)
 floor((N-1)/2)



 %%1
 f = repmat( [0 1], 1, 32);
 N = length(f)
 n = 0:N-1;
 nc = -floor(N/2):floor((N-1)/2)

 figure
 stem(n,f)


 %% 2
 DFf_a = abs(fft(f));
 figure
 subplot(1,2,1)
 stem(n,DFf_a)
 title('ABS FFT')
 subplot(1,2,2)
 stem(nc,fftshift(DFf_a))
 title('SHIFTED ABS FFT')

 %%
 %% if length N is odd

 f1 = [f,0];
 N = length(f1)
 n = 0:N-1;
 nc = -floor(N/2):floor((N-1)/2)

 figure
 stem(n,f1)

 DFf_a = abs(fft(f1));
 figure
 subplot(1,2,1)
 stem(n,DFf_a)
 title('ABS FFT')
 subplot(1,2,2)
 stem(nc,fftshift(DFf_a))
 title('SHIFTED ABS FFT')

 %%%%  zero-padding to get better sampling of FTDT

 flong = [f,zeros(size(f)), zeros(size(f))];
 N = length(flong)
 n = 0:N-1;
 nc = -floor(N/2):floor((N-1)/2)

 DFf_a = abs(fft(flong));
 figure
 subplot(1,2,1)
 stem(n,DFf_a)
 title('ABS FFT')
 subplot(1,2,2)
 stem(nc,fftshift(DFf_a))
 title('SHIFTED ABS FFT')

  %%% 3
 f = repmat( [0 0  1 1 ], 1, 16);

 %%% and so on...
