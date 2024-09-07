%% part 1
clear
clc
t = -10:0.001:10;
m = exp(-6*t).*(heaviside(t-4) - heaviside(t-8)) + exp(6*t).*(heaviside(-t-4) - heaviside(-t-8));
plot(t,m)