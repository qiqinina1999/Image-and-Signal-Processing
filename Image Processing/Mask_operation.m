close all;
clc;

%% Reading an image
A=imread('human.JPG');
A=rgb2gray(A);
A=double(A);
B=imread('landscape.JPG');
B=rgb2gray(B); % tranform into grey levels
B=double(B); 

%% Low-pass (average)
AA=ones(size(A));
BB=ones(size(B));
M=ones(3)/9;
A1=conv2(A,M,'same')./conv2(AA,M,'same');
B1=conv2(B,M,'same')./conv2(BB,M,'same');
figure()
subplot(2,2,1) ,imagesc(A),colormap(gray) 
title('Original figure')
subplot(2,2,2), imagesc(A1) 
title('Low-pass (average) ')
subplot(2,2,3) ,imagesc(B),colormap(gray) 
subplot(2,2,4), imagesc(B1) 
saveas(gcf,'Low-pass (average).jpg')
% they seem like original figure, but in the human figure, the white color
% become a little gray because of average.

%% Low-pass (weighted average)
M=ones(3)*-1;
M(3,3)=3;
A1=conv2(A,M,'same')./conv2(AA,M,'same');
B1=conv2(B,M,'same')./conv2(BB,M,'same');
figure()
subplot(2,2,1) ,imagesc(A),colormap(gray) 
title('Original figure')
subplot(2,2,2), imagesc(A1) 
title('Low-pass (weighted average)')
subplot(2,2,3) ,imagesc(B),colormap(gray)
subplot(2,2,4), imagesc(B1) 
saveas(gcf,'Low-pass (weighted average).jpg')
%it become almost gray and some pixel is white on the edge of clothes etc.

%% high-pass&high-boost
f=[0.1 0.8 0.1];
M=f'*f;
A1=conv2(A,M,'same')./conv2(AA,M,'same');
B1=conv2(B,M,'same')./conv2(BB,M,'same');
A1=A-A1;
A2=A1+A;
B1=B-B1;
B2=B1+B;

figure()
subplot(2,2,1) ,imagesc(A),colormap(gray) 
title('Original figure')
subplot(2,2,2), imagesc(A1)
title('High-pass mask')
subplot(2,2,3) ,imagesc(B),colormap(gray)
subplot(2,2,4), imagesc(B1) 
saveas(gcf,'High-pass mask.jpg')
%they become almost gray and have some noises, I think it is because A(B)
%and A1(B1) is almost same, so when A minus A1, it will become to 0.

figure()
subplot(2,2,1) ,imagesc(A),colormap(gray) 
title('Original figure')
subplot(2,2,2), imagesc(A2) 
title('High-boost mask')
subplot(2,2,3) ,imagesc(B),colormap(gray) 
subplot(2,2,4), imagesc(B2) 
saveas(gcf,'High-boost mask.jpg')
%the white color become to a little bit gray, but they are still similar to
%original figure.


