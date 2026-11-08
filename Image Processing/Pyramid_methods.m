clear
close all


%% Reading an image
dir *.lan 
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
B=A(512*4+1:512*5,:)';
C=ones(size(B));

%% Gaussian Pyramid &  Laplacian pyramid
% weight matrix
W=[.05 .25 .4 .25 .05];
W=W'*W;

B1=B;
figure
sgtitle('Gaussian pyramid&Laplacian pyramid')
for i=1:6
    C=ones(size(B1));
    D=conv2(B1,W,'same')./conv2(C,W,'same');
    eval(['G',num2str(i),'=D(2:2:end,2:2:end);'])
    E=zeros(size(G1,1)*2/2^(i-1));
    eval(['E(2:2:end,2:2:end)=G',num2str(i),';'])
    H=4*conv2(E,W,'same')./conv2(C,W,'same');
    eval(['H',num2str(i),'=H;'])
    eval(['L',num2str(i),'=B1-H;'])
    subplot(6,2,i*2-1)
    eval(['imagesc(G',num2str(i),'),colormap(gray)']) %Gaussian pyramid
    subplot(6,2,i*2)
    eval(['imagesc(L',num2str(i),')']) %Laplacian pyramid
    eval(['B1=G',num2str(i),';']);
end

figure
for i=1:6
   eval(['RC',num2str(i),'=H',num2str(i),'+L',num2str(i),';'])
   subplot(6,1,i)
   eval(['imagesc(RC',num2str(i),')'])
   colormap(gray)
end
RC1==B;
min(min(ans))
RC2==G1;
min(min(ans))
RC3==G2;
min(min(ans))
RC4==G3;
min(min(ans))
RC5==G4;
min(min(ans))
RC6==G5;
min(min(ans))

RD1=RC1-B;
figure,imagesc(RD1),colormap(gray)
RD2=RC2-G1;
figure,imagesc(RD2),colormap(gray)
figure,imagesc(RC2),colormap(gray)
title('Laplacian pyramid')
figure,imagesc(G1),colormap(gray)
title('Gaussian pyramid')

