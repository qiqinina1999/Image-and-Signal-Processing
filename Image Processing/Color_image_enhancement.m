close all;
clc;

%% Reading an image
A=imread('human.JPG');
A=rgb2gray(A);
A=double(A);
figure(1)
subplot(2,2,1) ,imagesc(A),colormap(gray) 
title('Original figure')
figure(2)
subplot(2,2,1) ,imagesc(B),colormap(gray) 
title('Original figure')
B=imread('landscape.JPG');
B=rgb2gray(B); % tranform into grey levels
B=double(B); 
AA=ones(size(A));
BB=ones(size(B));

%% high-pass&high-boost
f=[0.1 0.8 0.1];
M=f'*f;
A1=conv2(A,M,'same')./conv2(AA,M,'same');
B1=conv2(B,M,'same')./conv2(BB,M,'same');
A1=A-A1;
A=A1+A;
B1=B-B1;
B=B1+B;

figure(1)
subplot(2,2,2), imagesc(A) 
title('High-boost mask')
figure(2)
subplot(2,2,2), imagesc(B) 
title('High-boost mask')

%% Fourier transform
FTA=fftshift(fft2(A)); 
FTB=fftshift(fft2(B)); 
midAx=floor(size(A,2)/2)+1; 
midAy=floor(size(A,1)/2)+1;
midBx=floor(size(B,2)/2)+1;
midBy=floor(size(B,1)/2)+1;

%Ideal lowpass in human figure
[AX,AY]=meshgrid(1:size(A,2),1:size(A,1));
H=((AX-midAx).^2+(AY-midAy).^2).^0.5<((size(A,1)+size(A,2))/2)/2/2;
A1=ifft2(ifftshift(FTA.*H));
A=A1;
figure(1)
subplot(2,2,3), imagesc(A) 
title('Fourier transform')

%Ideal lowpass in landscape figure
[BX,BY]=meshgrid(1:size(B,2),1:size(B,1));
H=((BX-midBx).^2+(BY-midBy).^2).^0.5<((size(B,1)+size(B,2))/2)/2/2; 
B1=ifft2(ifftshift(FTB.*H));
B=B1;
figure(2)
subplot(2,2,3), imagesc(B) 
title('Fourier transform')

%% Histogram equalization
x=0:255;
[Y,X]=hist(A(:),x); 
Y=Y/size(A,1)/size(A,2);

ZA=zeros(1,256);
for i=1:256
    ZA(i)=sum(Y(1:i));
    A1(A==i-1)=ZA(i)*255;
end

[Y,X]=hist(A1(:),x);
figure(1)
subplot(2,2,4), imagesc(A1)
title('Histogram equalization')
saveas(gcf,'Color image enhancement human.jpg')
% After image-processed in the human figure, it looks like their eyes and their shadows are more visible
% and facial expressions are more clearly defined.

[Y,X]=hist(B(:),x);
Y=Y/size(B,1)/size(B,2);
ZB=zeros(1,256);
for i=1:256
    ZB(i)=sum(Y(1:i));
    B1(B==i-1)=ZB(i)*255;
end
[Y,X]=hist(B1(:),x);
figure(2)
subplot(2,2,4), imagesc(B1)
title('Histogram equalization')
saveas(gcf,'Color image enhancement landscape.jpg')
%After image processing in the landscape figure becomes darker overall
%the black and white contrast is slightly increased
%and the direction of the sun beam is clearer
