
% Excercice 5, hands on OCTAVE

%% 1
1 + 1

a = 1 + 1

b = 1 + 1 ;

a==b

sqrt(-1)

sin( 0.01 )

sin([ -0.01 pi])

%%% numerical precision

format long
a = 1
eps
b = 1 + eps
a==b

c = (a+b)/2
a==c
format short

pause
%% 2

v = 1:5
v = 1:0.5:5
v = 1:0

v = linspace(1,5,9)

v^2

v.^2

v = [ 1 ; 2 ; 3 ]
w = [  2:-1:0]'
v*w
v*w'
v'*w
v.*w

A = [ 1, 2, 3; 4,5,6; 7,8,9]
A.^2
A^2
A(:, 2) = [ ]

pause
%% 3

x = linspace(1,4,3)
y = 2*x.^2 + 1 + log( (x-pi).^2 )/pi^4
figure
plot(x,y)

x = linspace(1,4,3000);
y = 2*x.^2 + 1 + log( (x-pi).^2 )/pi^4 ;
figure
plot(x,y)


x = linspace(3.14,3.15,3000);
y = 2*x.^2 + 1 + log( (x-pi).^2 )/pi^4 ;
figure
plot(x,y)

pause
%% 4

[f, fs] = audioread ('bird.wav');

size(f)

plot(f)


sound(f,fs)

sound(2*f,fs)

sound(f/3,fs)

pause
%% 5

n = 50000
N = [1:n]';

f = [ sin( pi/50*N)];

figure
plot(f)

sound(f,fs)

pause
%% 6
A = imread('femme.jpg');

size(A)

figure
imshow(A)

A(100:110, 200:210)

M = max(max(A))

figure
imshow(M-A)
title('negative')

figure
imshow(2*A)
title('saturation')

figure
imshow(A/2)
title('lower intensity')

g = linspace(0,1,256)';
gmap = (cos(g*3*pi)+1)/2;

figure, plot([g gmap]), axis square


figure,  imshow(A, [gmap*ones(1,3)])



