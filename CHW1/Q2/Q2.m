%% part 1
clear
clc
[recordedVoice,~] = audioread('introduction.wav'); %reading voice file
recordedVoice = recordedVoice/(rms(recordedVoice)); %normalizing the signal
syms z
H = 0.05*(1 + z^(-1600) + z^(-2400) + z^(-4000)); %transfer function
h = iztrans(H); %inverse z-transform
h = double(coeffs(h)); %making h a vector
output = conv(h,recordedVoice); %conv of channel and signal
%soundsc(output,40000);
rms(output)^2 %power of the output signal
%plot(abs(recordedVoice));
outputfft = fft(output); 
outputfft = fftshift(outputfft);
plot(abs(outputfft)); %spectrum of the output signal
%% part 2
clear
clc
[recordedVoice,~] = audioread('introduction.wav'); %reading voice file
recordedVoice = recordedVoice/(rms(recordedVoice)); %normalizing the signal
syms z
noise = sqrt(0.05)*randn(1); %making gausian whitenoise with 0.05 variance and 0 mean
H = 0.05*(1 + z^(-1600) + z^(-2400) + z^(-4000)) + noise; %transfer function + noise
h = iztrans(H); %inverse z-transform
h = double(coeffs(h)); %making h a vector
output = conv(h,recordedVoice); %conv of channel and signal
%soundsc(output,40000);
rms(output)^2 %power of the output signal
%plot(abs(recordedVoice));
outputfft = fft(output); 
outputfft = fftshift(outputfft);
plot(abs(outputfft)); %spectrum of the output signal
%% part 3
%% part 4
[recordedVoice,~] = audioread('introduction.wav'); %reading voice file
recordedVoice = recordedVoice/(rms(recordedVoice)); %normalizing the signal
syms z
noise = sqrt(0.05)*randn(1); %making gausian whitenoise with 0.05 variance and 0 mean
H = 0.05*(1 + z^(-1600) + z^(-2400) + z^(-4000)) + noise; %transfer function + noise
h = iztrans(H); %inverse z-transform
h = double(coeffs(h)); %making h a vector
output1 = conv(h,recordedVoice); %conv of channel and signal
output = conv(output1,Hd.Numerator); %conv of output and designed(5k) filter
soundsc(output,40000);
rms(output)^2 %power of the output signal
%plot(abs(recordedVoice));
outputfft = fft(output); 
outputfft = fftshift(outputfft);
plot(abs(outputfft)); %spectrum of the output signal
%% part 5
[recordedVoice,~] = audioread('introduction.wav'); %reading voice file
recordedVoice = recordedVoice/(rms(recordedVoice)); %normalizing the signal
syms z
noise = sqrt(0.05)*randn(1); %making gausian whitenoise with 0.05 variance and 0 mean
H = 0.05*(1 + z^(-1600) + z^(-2400) + z^(-4000)) + noise; %transfer function + noise
h = iztrans(H); %inverse z-transform
h = double(coeffs(h)); %making h a vector
output1 = conv(h,recordedVoice); %conv of channel and signal
output = conv(output1,Hd2.Numerator); %conv of output and designed(2k) filter
soundsc(output,40000);
rms(output)^2 %power of the output signal
%plot(abs(recordedVoice));
outputfft = fft(output); 
outputfft = fftshift(outputfft);
plot(abs(outputfft)); %spectrum of the output signal
