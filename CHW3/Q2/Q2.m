%% part 1-1
clear all
clc
close all
fs = 10000; % sampling freq
syms t;
x = @(t) 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-3) - heaviside(t-5); % x(t)
t = -1:1/fs:6; 
plot(t,x(t)); % plot of x(t)
grid on;
title("x(t)");
%% part 1-2
fc = 5000; % carier frequency
Qk = 1; % phase deviation
t = 1.99:1/fs:2.01; 
xc = @(t) cos(2*pi*fc*t + Qk.*x(t)); % manual xc(t)
figure(2);
plot(t,xc(t));
grid on
title("xc(t)");
%% part 1-3
t = 1.99:1/(fs):2.01;
x = 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-4) - heaviside(t-5); % x(t)
xc_pmmod = pmmod(x,fc,fs,Qk); % pmmod xc(t)
figure(3)
plot(t,xc_pmmod);
grid on
title("xc(t) with pmmod");
%% part 1-4
fc = 500;
t = -1:7/fs:6;
x = 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-4) - heaviside(t-5); % x(t)
xc_pmmod = pmmod(x,fc,fs,Qk); % pmmod xc(t)
X = fft(x); % fft of x(t)
X = fftshift(X);
N = length(X);
f = [-N/2:N/2-1];
figure(4)
subplot(2,1,1);
plot(f,abs(X)); 
title("Re X(f)");
grid on
Xc = fft(xc_pmmod); % fft of xc(t)
Xc = fftshift(Xc);
N = length(Xc);
f = [-N/2:N/2-1];
figure(4)
subplot(2,1,2);
plot(f,abs(Xc));
title("Re Xc(f)");
grid on
%% part 2
% theorical