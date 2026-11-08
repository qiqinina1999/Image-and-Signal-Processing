close all;
clc;

%% Reading an image
dir *.lan 
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
B=A(512*4+1:512*5,:)';
C=ones(size(B));

%% compare wavelet to Gaussian Pyramid
wl=[.05 .25 .4 .25 .05];
wh=[0 0 1 0 0]-wl;

X=conv2(B,wl,'same');% horizontal weighted average
XL=X(:,2:2:end);
XL=conv2(XL,wl','same');% vertical weighted average
XLL=XL(2:2:end,:);
X=conv2(B,wh,'same');% Gaussian Pyramid
XH=X(:,2:2:end);
XH=conv2(XH,wh','same'); %get highpass of horizontal and vertical
XHH=XH(2:2:end,:);
X=conv2(B,wl,'same');
XL=X(:,2:2:end);
XL=conv2(XL,wh','same');
XLH=XL(2:2:end,:); % first lowpass, then highpass

X=conv2(B,wh,'same');
XH=X(:,2:2:end);
XH=conv2(XH,wl','same');
XHL=XH(2:2:end,:);  % first highpass, then lowpass
G1=XLL;
min(min(ans))
RDGX=G1-XLL;
max(max(RDGX))

figure
subplot(2,2,1)
imagesc(XLL),colormap(gray)
title('LL')
subplot(2,2,2)
imagesc(XLH)
title('horizontalL,verticalH')
subplot(2,2,3)
imagesc(XHL)
title('HL')
subplot(2,2,4)
imagesc(XHH)
title('HH')

figure
imagesc(XLL),colormap(gray)
figure
imagesc(G1),colormap(gray)
figure
imagesc(RDGX),colormap(gray)

%it seem like only the edge of figure has some different, others is almost
%same.