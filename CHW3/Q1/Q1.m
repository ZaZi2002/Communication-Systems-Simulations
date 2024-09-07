%% part 1
clear all
clc
close all
fs = 10000; % sampling freq
syms t;
x = @(t) 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-3) - heaviside(t-5); % x(t)
x_integ = int(x(t),t); % symbolic integra of x(t)
t = -1:1/fs:6; 
subplot(2,1,1);
plot(t,x(t)); % plot of x(t)
grid on;
title("x(t)");
x_integral = matlabFunction(x_integ); % changing symbolic x_integ to function handler in order to plot
subplot(2,1,2);
plot(t,x_integral(t)); % plot of integral of x(t)
grid on;
title("integral of x(t)");
%% part 2
fc = 500; % carrier frequency
fk = 50; % frequency deviation
t = 1.99:1/fs:2.01; 
xc = @(t) cos(2*pi*fc*t + 2*pi*fk.*x_integral(t)); % manual xc(t)
figure(2);
plot(t,xc(t));
grid on
title("xc(t)");
%% part 3
t = 1.99:1/(fs):2.01;
x = 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-3) - heaviside(t-5); % x(t)
xc_fmmod = fmmod(x,fc,fs,fk); % fmmod xc(t)
figure(3)
plot(t,xc_fmmod);
grid on
title("xc(t) with fmmod");
%% part 4
t = -1:7/(fs):6;
x = 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-3) - heaviside(t-5); % x(t)
xc_fmmod = fmmod(x,fc,fs,fk); % fmmod xc(t)
X = fft(x); % fft of x(t)
X = fftshift(X);
N = length(X);
f = [-N/2:N/2-1];
figure(4)
subplot(2,1,1);
plot(f,abs(X)); 
title("Re X(f)");
grid on
Xc = fft(xc_fmmod); % fft of xc(t)
Xc = fftshift(Xc);
N = length(Xc);
f = [-N/2:N/2-1];
figure(4)
subplot(2,1,2);
plot(f,abs(Xc));
title("Re Xc(f)");
grid on
%% part 5
% it's theorical
%% part 6
% it's theorical
%% part 7
t = -1:1/fs:6;
x = 2*heaviside(t) - 5*heaviside(t-2) + 4*heaviside(t-3) - heaviside(t-5); % x(t)
xc_fmmod = fmmod(x,fc,fs,fk); % fmmod xc(t)
vc = diff(xc_fmmod); % derivation of xc_fmmod
yc = abs(vc); % abs of derivated signal
y = lowpass(yc,1,fs); % passing yc from a lowpass filter
figure(5);
plot(y);
grid on
title("y(t) with the system in part 6");

y_fmdemod = fmdemod(xc_fmmod,fc,fs,fk); % fmdemod of xc_fmmod
figure(6);
plot(t,y_fmdemod);
grid on
title("y(t) with fmdemod");