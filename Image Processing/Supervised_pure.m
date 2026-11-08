close all;
clc;

%% Reading an image
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
O=fread(fid,[512*7 512],'uint8');
for i=0:6
    O7(:,:,i+1)=O(1+512*i:512*(i+1),:)';
end

%% Supervised pure pixel classification 
% using minimum distance

%first type :buildings
m1=mean(reshape(O7(225:230,291:300,:),60,7));
%second type: water
m2=mean(reshape(O7(279:281,265:270,:),18,7));
%third type: vegetation
m3=mean(reshape(O7(318:322,51:55,:),25,7));
%fourth type: road
m4=mean(reshape(O7(162:165,159:162,:),16,7));
type=zeros(512);
tt1=zeros(1,7);
for i=1:512
    for i2=1:512
        tt1(1,:)=O7(i,i2,:);
        dis(1)=norm(tt1-m1); 
        dis(2)=norm(tt1-m2);
        dis(3)=norm(tt1-m3);
        dis(4)=norm(tt1-m4); %calculate all the distances
        [X,c]=min(dis); % find the types of minimum distances
        type(i,i2)=c; 
    end
end
figure
color1=[192/255,192/255,192/255];% gray: building
color2=[0,1,1];% blue: water
color3=[0,1,0];% green :vegetation
color4=[0,0,0];% black: road
map=[color1;...
    color2;...
    color3;...
    color4];
imagesc(type)
colormap(map)
caxis([0.5,4.5])
c=colorbar('Ytick',[1:4],'Yticklabel',{'Building','Water','Vegetation','Road'});
axis image
set(c,'TickLength',[0,0]);
title('Supervised pure pixel classification')

%Vegetation: most of vegetation pixels are classified correctly, but its
%edge, such as the pixel in the edge of park, are not classified clearly.
%I guess the reason is these pixel has some of vegetation but some are not, 
%some of these pixels are classified as vegetation, some of them may be
%classified as others.
