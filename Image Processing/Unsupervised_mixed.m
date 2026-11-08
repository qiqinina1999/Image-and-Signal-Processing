close all;
clc;

%% Reading an image
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
O=fread(fid,[512*7 512],'uint8');
for i=0:6
    O7(:,:,i+1)=O(1+512*i:512*(i+1),:)';
end

%% Unsupervised mixed pixel classification

%First endmember
z=reshape(O7,512*512,7)';
ttt=sum(z.^2);
[E,m]=max(ttt);
A=z(:,m);

% rest endmembers
for i=1:4
    % orthogonal subspace
    P=eye(7)-A*inv(A'*A)*A';
    ttt=sum((P*z).^2);
    [E,m]=max(ttt);
    A(:,i+1)=z(:,m);
end
% Least square
abd=inv(A'*A)*A'*z;
figure
for i=1:4
    subplot(2,2,i)
    imagesc(reshape(abd(i,:),512,512))
end
colormap(gray)
sgtitle('Unsupervised mixed pixel classification')
saveas(gcf,'Unsupervised mixed pixel classification.jpg')

% Without clear benchmarks, it is difficult for this method to classified
% water, buildings and road.
% Fortunately, it can classified the vegetation well.
% If we can add the types of classification, such as different types of
% roof (different materials) can become more correctly.