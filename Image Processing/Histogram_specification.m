close all;
clc;

%% Reading an image
A=imread('human.JPG');
A=rgb2gray(A);
A=double(A);
B=imread('landscape.JPG');
B=rgb2gray(B);
B=double(B);

%% Histogram specification with a distribution I designed
%design a normal distribution with a symmetrical grayscale of 20
y=exp(-(x-127.5).^2);
y=y/sum(y);
ZA1=zeros(1,256);
for i=1:256
    ZA1(i)=sum(y(1:i));
end
for i=1:256
    [n,N]=max(ZA1>=ZA(i));
    A1(A==(i-1))=N;
end
[Y,X]=hist(A1(:),x);
figure()
subplot(2,2,2),plot(X,Y),set(gca,'xlim',[0 255]) % Histogram after processing
title('Histogram') 
subplot(2,2,1) ,imagesc(A),colormap(gray)
title('Original image')
subplot(2,2,3), imagesc(A1)
title('Histogram equalization') 
saveas(gcf,'Histogram Equalization human.jpg')
%the human face, white clothes and wood are regarded as the same grayscale
%the black shadow behind the door frame is regarded as the same grayscale.
%the handrail with sunshine is considered white because of the sunlight and its original color is white.

ZB1=zeros(1,256);
for i=1:256
    ZB1(i)=sum(y(1:i));
end
for i=1:256
    [n,N]=max(ZB1>=ZB(i));
    B1(B==(i-1))=N;
end
[Y,X]=hist(B1(:),x);
figure()
subplot(2,2,2),plot(X,Y),set(gca,'xlim',[0 255]) % Histogram after processing
title('Histogram') 
subplot(2,2,1) ,imagesc(B),colormap(gray) 
title('Original image')
subplot(2,2,3), imagesc(B1) 
title('Histogram equalization') 
saveas(gcf,'Histogram Equalization landscape.jpg')
%Similar grayscale pixels of landscape photos which is nearby are considered one grayscale.