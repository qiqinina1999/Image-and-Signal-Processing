%% Project: Image Contrast Stretching
%% Description: This project implements image contrast stretching techniques using MATLAB as part of academic coursework.
close all;
clc;

%% Reading an image 
A=imread('human.JPG');
B=imread('landscape.jpg')
A=double(A); 
B=double(B);

%% Linear
A1=A*255/150-95; 
B1=B*255/150-95 
%[0 0 0]: black, [255 255 255]: white

%% Piecewise Linear
A2=A*2.*(A<=100)+(200+55/155*(A-100)).*(A>100); 
B2=B*2.*(B<=100)+(200+55/155*(B-100)).*(B>100);

%% nonlinear
A3=sqrt((A-255/2).^2); 
B3=sqrt((B-255/2).^2);

%% Print 
figure(1)
subplot(2,2,1)
imshow(A./255)
title('Original image')
subplot(2,2,2)
imshow(A1./255)
title('Linear')
subplot(2,2,3)
imshow(A2./255)     
title('Piecewise Linear')
subplot(2,2,4)
imshow(A3./255)     
title('Nonlinear')
sgtitle('Contrast stretching (human)')
saveas(gcf,'Contrast stretching human.jpg')

figure(2)
subplot(2,2,1)
imshow(B./255)
title('Original image')
subplot(2,2,2)
imshow(B1./255)
title('Linear')
subplot(2,2,3)
imshow(B2./255)     
title('Piecewise Linear')
subplot(2,2,4)
imshow(B3./255)     
title('Nonlinear')
sgtitle('Contrast stretching (landscape)')
saveas(gcf,'Contrast stretching landscape.jpg')


       
       
