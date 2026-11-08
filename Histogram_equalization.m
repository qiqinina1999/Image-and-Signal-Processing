close all;
clc;

%% Reading an image
A=imread('human.JPG');
A=rgb2gray(A);
A=double(A);
B=imread('landscape.JPG');
B=rgb2gray(B);
B=double(B);

%% Histogram equalization
x=0:255;
[Y,X]=hist(A(:),x); 
figure(1)
subplot(2,2,3),plot(X,Y),set(gca,'xlim',[0 255]); % original historgram

Y=Y/size(A,1)/size(A,2);

ZA=zeros(1,256);
for i=1:256
    ZA(i)=sum(Y(1:i));
    A1(A==i-1)=ZA(i)*255;
end

[Y,X]=hist(A1(:),x);
subplot(2,2,4),plot(X,Y),set(gca,'xlim',[0 255]); % histogram equalization

subplot(2,2,1) ,imagesc(A),colormap(gray) 
title('Original image')
subplot(2,2,2), imagesc(A1)
title('Histogram equalization')
saveas(gcf,'Histogram equalization human.jpg')
%The human picture is noisy and the brightness becomes high as you can see
%the low values are dispersed and the high values is disappeared in the
%historgram.

[Y,X]=hist(B(:),x);
figure(2)
subplot(2,2,3),plot(X,Y),set(gca,'xlim',[0 255]); % original historgram
Y=Y/size(B,1)/size(B,2);
ZB=zeros(1,256);
for i=1:256
    ZB(i)=sum(Y(1:i));
    B1(B==i-1)=ZB(i)*255;
end
[Y,X]=hist(B1(:),x);
subplot(2,2,4),plot(X,Y),set(gca,'xlim',[0 255]); % histogram equalization

subplot(2,2,1),imagesc(B),colormap(gray) 
title('Original image')
subplot(2,2,2), imagesc(B1)
title('Histogram equalization')
saveas(gcf,'Histogram equalization landscape.jpg')

%The black and white contrast of landscape photos is increased, and some 
%light colors, Such as the ocean, deepened significantly. As we can see in
%the historgram, the values about 20(175) are dispersed, then after
%calculating, they turned into lower(higher) value which is not appeared in
%the original figure.