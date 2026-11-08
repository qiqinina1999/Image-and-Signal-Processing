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

% Figure 1 can see the distribution of buildings.
% Figure 2 can see the distribution of the river, some of regions look like
% has some water, but I'm not sure these regions are water or classified
% incorrectly.
% Figure 3 can see the distribution of vegetation, and the vegetation in the park are classified well.
% Figure 4 can see the distribution of roads, but in the city ​​center,
% these road can not be classified so clearly, it showed like some points.
% By using supervised mixed pixel classification, I think it is similar to
% supervised pure pixel classification, and show better result than
% unsupervised mixed pixel classification.