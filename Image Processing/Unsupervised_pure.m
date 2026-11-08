close all;
clc;

%% Reading an image
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
O=fread(fid,[512*7 512],'uint8');
for i=0:6
    O7(:,:,i+1)=O(1+512*i:512*(i+1),:)';
end

%% Unsupervised pure pixel classification
% using K-mean
A=rand(7,7)*255; %choose 7 random locations and 7 types
A1=zeros(7,7);
type=zeros(512);
tt1=zeros(1,7);
while sum(sum(abs(A-A1)))>1 % find the closest location
    A1=A;
    for i=1:512
        for i2=1:512
            tt1(1,:)=O7(i,i2,:);
            dis(1)=norm(tt1-A(1,:));
            dis(2)=norm(tt1-A(2,:));
            dis(3)=norm(tt1-A(3,:));
            dis(4)=norm(tt1-A(4,:));
            dis(5)=norm(tt1-A(5,:));
            dis(6)=norm(tt1-A(6,:));
            dis(7)=norm(tt1-A(7,:));
            [X,c]=min(dis);
            type(i,i2)=c;
        end
    end
    for i=1:7
        for i2=1:7
            A(i2,i)=sum(sum(O7(:,:,i).*(type==i2)))/nnz(type==i2);
        end
    end
end
figure
imagesc(type)
title('Unsupervised pure pixel classification')
saveas(gcf,'Unsupervised pure pixel classification.jpg')

% I chose 7 random locations and hoped to have better results. 
% Every time it showed different answer, but it is still difficult for this
% method to classified different types so clearly.