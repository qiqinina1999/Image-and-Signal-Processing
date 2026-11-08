clear all;
clc;

[x,Fs]=audioread('song.wav');
rp = 3; %passband ripple
rs = 60; %stopband ripple
wp = 250; %passband frequency
ws = 2000; %stopband frequency
w1 = 2*wp/Fs;
w2 = 2*ws/Fs;
[n,wn] = buttord(w1,w2,rp,rs);
[b,a] = butter(n,wn);

%1-1 plot magnitude and phase response

freqz(b,a);
saveas(gcf,'magnitude_response_lowpass3.fig');
saveas(gcf,'magnitude_response_lowpass3.jpg');

%1-2 zero-pole plot

[z,p,k] = tf2zp(b,a);
zplane(z,p);
title(sprintf('Butterworth Lowpass %g-%g Hz Digital Filter',wp,ws));
saveas(gcf,'zero_pole_plot_lowpass3.fig');
saveas(gcf,'zero_pole_plot_lowpass3.jpg');

%1-3 impulse response

impz(b,a);
saveas(gcf,'impulse_response_lowpass3.fig');
saveas(gcf,'impulse_response_lowpass3.jpg');
y=filter(b, a, x); %y[n]
%save output files
audiowrite('audio_lowpass3.wav',y,Fs);

%1-5 plot y[n]

time=(0:length(x)-1)/Fs;
subplot(2,1,1);
plot(time,x);
title('Original audio signal');
subplot(2,1,2);
plot(time,y);
title('Filtered audio signal');
saveas(gcf,'filtered_audio_signal_lowpass3.jpg');
