%% Project: Supervised Mixed Pixel Classification
%% Description: This project implements supervised mixed pixel classification using non-negative least squares in MATLAB as part of academic coursework.


close all;
clc;

%% Reading an image
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
O=fread(fid,[512*7 512],'uint8');
for i=0:6
    O7(:,:,i+1)=O(1+512*i:512*(i+1),:)';
end

%% upervised mixed pixel classification
% using Least square

A=[m1' m2' m3' m4'];
A(8,:)=10^4*[1 1 1 1];
type=zeros(512,512,4);
for i=1:512
    for i2=1:512
        tt1=zeros(7,1);
        tt1(:,1)=O7(i,i2,:);
        tt1(8,1)=10^4;
        type(i,i2,:)=lsqnonneg(A,tt1);
    end
end
figure
for i=1:4
    subplot(2,2,i)
    imagesc(type(:,:,i))
end
colormap(gray)

sgtitle('Supervised mixed pixel classification')
saveas(gcf,'Supervised mixed pixel classification.jpg')
