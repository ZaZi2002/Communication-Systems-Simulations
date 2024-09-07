%% part 1
clear
clc
t = 0:0.000001:0.001;
f1 = 2000;
f2 = 4000;
f3 = 8000;
x = sin(2*pi*f1*t) + 2*cos(2*pi*f2*t) + 3*sin(3*pi*f3*t);
m = (2 + 0.5.*x).*sin(2*pi*f3*t);
m_hilb = (2./(pi*t)).*sin(2*pi*f3*t) - (1./(4*pi*t)).*(cos(2*pi*t*(f1+f3)) - cos(2*pi*t*(f1-f3))) - (1./(2*pi*t)).*(sin(2*pi*t*(f2+f3)) - sin(2*pi*t*(f2-f3))) - (3./(4*pi*t)).*(cos(5*pi*t) - cos(pi*t));
plot(t,x);
title("x(t)");
figure(2)
%m = cos(2*pi*f1*t);
plot(t,m);
title("m(t)");
figure(3)
plot(t,m_hilb);
title("hilbert of m(t)");
%% part 2
d = designfilt('hilbertfir', 'FilterOrder', 30, 'TransitionWidth', 0.1); % hilbert filter design
hilbert_m = filter(d,m);
figure(4)
plot(t,hilbert_m);
title("hilbert of m(t)");
%% part 3
ma = m + 1i*hilbert_m;
figure(4)
subplot(3,1,1);
plot(t,abs(ma));
title("Re ma(t)");
subplot(3,1,2);
plot(t,imag(ma));
title("Im ma(t)");
subplot(3,1,3);
plot(t,m);
title("m(t)");
%% part 4
M = fft(m);
M = fftshift(M);
N = length(M);
f = [-N/2:N/2-1];
figure(5)
subplot(2,1,1);
plot(f,abs(M));
title("Re M(f)");
grid on
subplot(2,1,2);
plot(f,imag(M));
title("Im M(f)");
grid on
%% part 5
MH = fft(hilbert_m);
MH = fftshift(MH);
N = length(MH);
f = [-N/2:N/2-1];
figure(6)
plot(f,abs(MH));
title("Re hilbert of M(f)");
grid on
figure(7)
plot(f,imag(MH));
title("Im hilbert of M(f)");
grid on

MA = fft(ma);
MA = fftshift(MA);
N = length(MA);
f = [-N/2:N/2-1];
figure(8)
plot(f,abs(MA));
title("Re MA(f)");
grid on
figure(9)
plot(f,imag(MA));
title("Im MA(f)");
grid on