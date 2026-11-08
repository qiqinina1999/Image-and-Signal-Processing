x=audiorecorder(16000,16,1);
disp('start your speech')
recordblocking(x,10)
disp('recoding ends here')
Y=getaudiodata(x);
play(x)
audiowrite('myVoice.wav',Y,16000,'BitsPerSample',16);
temp=whos('-regexp','Y');
size=temp.bytes;
disp('Size taken in the workspace (Bytes):');
disp(size);
sizefile=dir('myVoice.wav');
disp('Size of .Wav File (Bytes)');
disp(sizefile.bytes);
figure
plot (Y)
title('MyVoice')
