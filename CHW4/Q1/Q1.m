close all
clear all
clc
%% part 1
n_bits = 500; % number of bits
data = randi([0 1],n_bits,1); % generating random binary data
input_data = 0;
Ts = 1; % sampling freq
N = 50;
Tb = N*Ts; % pulse duration of each binary data
t = 0:Ts:Tb*n_bits; % specifing time range
for i = 1:n_bits % generating input pulse data with binary data
    input_data = input_data + data(i)*2*(heaviside(t - (i-1)*Tb) - heaviside(t - (i)*Tb));
end
input_data = input_data - 1; % now the amplitude range is +-1
plot(t,input_data);
grid on

%% part 2
N = n_bits*Tb/Ts + 1; % number of samples
S = 1; % power spectral density
noise = sqrt(S/Ts)*randn(1,N);
figure(2);
plot(noise);
grid on

%% part4
A = 0.6; % amplitude of the carrier
s = input_data.*-1.*A.*cos(10.*pi.*t./Tb + 0.001);
%figure(3);
%plot(s);

%% part 5
noise = sqrt(S/Ts)*randn(1,N)*0.5 ; % creating white noise
v = s + noise; % adding noise to signal
figure(4);
plot(v);
grid on
title("v(t) = s(t) + n(t)");

%% part 6
A = dot(A.*cos(10.*pi.*t./Tb),v);
B = dot(A.*sin(10.*pi.*t./Tb),v);
constMap = comm.ConstellationDiagram("Title","BPSK","ShowTrajectory",false);
constMap(v(1:20));

%% part 7
t = 0:Ts:Tb*n_bits;
vo = v*A.*cos(10.*pi.*t./Tb); 
vo = lowpass(vo,0.000000001); % low pass filter
vo = vo((Tb/2):length(vo)); % shifting signal for correct sampling
vo = downsample(vo,50); % sampling the signal
%vs = -1*vo;
t = 0:1:n_bits-1;
figure(5);
stem(t,vo);
grid on

%% part 8
output_data([n_bits,1]) = 0;
for i = 1:n_bits % generating output binary code
    if vo(i)>=0
        output_data(i) = 0;
    elseif vo(i)<0
        output_data(i) = 1;
    end
end
figure(6)
hold on
stem(output_data,'filled','red'); % recived signal
stem(data,'filled','blue'); % transfered signal
grid on
title('Output(red) VS Input(blue)    Low Noise!');

%% part 9
% first you should choose A in line 29 between
% [0.07,0.18,0.29,0.40,0.52,0.63]
diff = 0;
for i = 1:n_bits % finding differences
    if output_data(i) ~= data(i)
        diff = diff + 1;
    end
end
BER = diff/n_bits;
BER

%% part 10
% Caution : This part takes a lot of time, please run it seperately!!!!!!
% first you should choose A in line 107 between
% [0.07,0.18,0.29,0.40,0.52,0.63]
BER = ([50,1]);
BER_mean = 0;
for i = 1:50
    n_bits = 500; % number of bits
    data = randi([0 1],n_bits,1); % generating random binary data
    input_data = 0;
    Ts = 1; % sampling freq
    N = 50;
    Tb = N*Ts; % pulse duration of each binary data
    t = 0:Ts:Tb*n_bits; % specifing time range
    for j = 1:n_bits % generating input pulse data with binary data
        input_data = input_data + data(j)*2*(heaviside(t - (j-1)*Tb) - heaviside(t - (j)*Tb));
    end
    input_data = input_data - 1; % now the amplitude range is +-1
    N = n_bits*Tb/Ts + 1; % number of samples
    S = 1; % power spectral density
    noise = sqrt(S/Ts)*randn(1,N)*0.5;
    A = 0.07; % amplitude of the carrier     !!!!!
    s = input_data.*-1.*A.*cos(10.*pi.*t./Tb);
    v = s + noise; % adding noise to signal
    t = 0:Ts:Tb*n_bits;
    vo = v*A.*cos(10.*pi.*t./Tb); 
    vo = lowpass(vo,0.000000001); % low pass filter
    vo = vo((Tb/2):length(vo)); % shifting signal for correct sampling
    vo = downsample(vo,50); % sampling the signal
    output_data([n_bits,1]) = 0;
    for j = 1:n_bits % generating output binary code
        if vo(j)>=0
            output_data(i) = 0;
        elseif vo(j)<0
            output_data(j) = 1;
        end
    end
    diff = 0;
    for j = 1:n_bits % finding differences
        if output_data(j) ~= data(j)
            diff = diff + 1;
        end
    end
    BER(i) = diff/n_bits;
    BER_mean = BER_mean + BER(i);
end
BER_mean/50

%% part 10 contineu
mean = [0.6187,0.2145,0.0783,0.0174,0.0052,0.0001];
SNR = [-9.12,-3.92,0.22,3.01,5.29,6.96];
figure(7);
plot(SNR,mean,'green');
grid on
xlabel("SNR");
ylabel("mean BER");
title("BER/SNR");

%% part 11 
pfo = comm.PhaseFrequencyOffset("FrequencyOffset",0.001,"SampleRate",1);
scatterplot(v);
title("Original Constellation")
y = pfo(v);
scatterplot(y);
title("Constellation After Phase Offset")