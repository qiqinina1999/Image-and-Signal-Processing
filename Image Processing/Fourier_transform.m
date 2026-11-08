close all
clc;
%% Reading an image
A=imread('human.JPG');
A=rgb2gray(A);
A=double(A);
B=imread('landscape.JPG');
B=rgb2gray(B); % tranform into grey levels
B=double(B); 

%% Fourier transform
FTA=fftshift(fft2(A)); % fast fourier transform
FTB=fftshift(fft2(B)); 
midAx=floor(size(A,2)/2)+1;% find the middle point in frequency domain 
midAy=floor(size(A,1)/2)+1;
midBx=floor(size(B,2)/2)+1;
midBy=floor(size(B,1)/2)+1;
%Ideal lowpass in human figure
[AX,AY]=meshgrid(1:size(A,2),1:size(A,1));
% pass 1/2 range of frequency(low one)
H=((AX-midAx).^2+(AY-midAy).^2).^0.5<((size(A,1)+size(A,2))/2)/2/2;
% because of different length of x and y, so we need to average them
A1=ifft2(ifftshift(FTA.*H));
% transform into the real number (inverse fast fourier transform)
figure()
subplot(2,2,1) ,imagesc(A),colormap(gray)
title('Original figure')
subplot(2,2,2), imagesc(A1) 
title('Fourier transform')
% the human photo becomes more blurred, 
% and the black and white contrast is less obvious than the original image.

%Ideal lowpass in landscape figure
[BX,BY]=meshgrid(1:size(B,2),1:size(B,1));
H=((BX-midBx).^2+(BY-midBy).^2).^0.5<((size(B,1)+size(B,2))/2)/2/2; 
B1=ifft2(ifftshift(FTB.*H));
subplot(2,2,3) ,imagesc(B),colormap(gray) 
subplot(2,2,4), imagesc(B1) 
saveas(gcf,'Fourier transform.jpg')
% it look similar to original one. 