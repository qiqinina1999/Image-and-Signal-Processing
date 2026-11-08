close all;
clc;

%% Reading an image
% Image fusion
load fusion_spot % the file is uploaded on handout, I decided to use it 
a=double(A1(:,:,[3 2 1]));
z=reshape(a,size(a,1)*size(a,2),size(a,3))';
R=z-repmat(mean(z')',1,size(a,1)*size(a,2)); 
R1=R*R'/(size(a,1)*size(a,2));
[V,D]=eig(R1);
D=diag(D);
PCA1=fliplr(V)'*z;
a1=reshape(PCA1',size(a,1),size(a,2),size(a,3));
F=zeros(size(A,1),size(A,2),size(a,3));
Rat1=size(A,1)/size(a,1);
Rat2=size(A,2)/size(a,2);
for i=1:Rat1
    for i2=1:Rat2
        F(i:Rat1:end,i2:Rat2:end,:)=a1;
    end
end

x=0:255;
[Y,X]=hist(A(:),x);
ZA=zeros(1,256);
for i=1:256
    ZA(i)=sum(Y(1:i));
end
ha=a(:,:,size(a,3)); % use one of multispectral band
[y3,x3]=hist(ha(:),x);
ZAF1=zeros(1,256);
for i=1:256
    ZAF1(i)=sum(y3(1:i));
end
ZAF1=ZAF1/size(a,1)/size(a,2)*size(A,1)*size(A,2);%t ranform low resolution into high resolution
AF1=zeros(size(A,1),size(A,2));
for i=1:256
    [n,N]=max(ZAF1>=ZA(i));
    AF1(A==(i-1))=N;
end

F(:,:,size(a,3))=AF1;
PCAF=fliplr(V)'*reshape(F,size(A,1)*size(A,2),size(a,3))';% return original coordinate space
F1=reshape(PCAF',size(A,1),size(A,2),size(a,3));% get final figure
F(:,:,size(a,3))=A;
PCAF2=fliplr(V)'*reshape(F,size(A,1)*size(A,2),size(a,3))';
F2=reshape(PCAF2',size(A,1),size(A,2),size(a,3));

figure(1)
subplot(2,2,1)
imagesc(A1(:,:,1))
title('Original')
subplot(2,2,2)
imagesc(A),colormap(gray)
title('Fusion')
subplot(2,2,3)
imagesc(F1(:,:,1))
title('PCA')
colormap(gray)

%% Color transform
ah=rgb2hsv(a);% tranform into HSV and change the intensity
FC=zeros(size(A,1),size(A,2),size(a,3));
Rat1=size(A,1)/size(a,1);
Rat2=size(A,2)/size(a,2);
for i=1:Rat1
    for i2=1:Rat2
        FC(i:Rat1:end,i2:Rat2:end,:)=ah;
    end
end


FC(:,:,size(a,3))=double(A)/255;
FCR=hsv2rgb(FC);
figure(1)
subplot(2,2,4)
imagesc(FCR);
title('Color transform')
saveas(gcf,'Q1.jpg')

% After fusion, the white and black contrast becomes more obivous
% After PCA, Image sharpness becomes lower and the white pixels become a
% little gray.
% The difference: Color transform is focused on the change of brightness
% and keep the color same, but PCA has to change on the detail of image.