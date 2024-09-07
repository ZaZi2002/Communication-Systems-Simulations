%% part 1
clear
clc
recordObj = audiorecorder(40000,16,1);
disp("Begin Recording")
recordTime = 5;
%recordblocking(recordObj,recordTime); %recording time
disp("End Recording")
%play(recordObj); %playing the recorded voice
%recordedVoice = getaudiodata(recordObj);
plot(recordedVoice); 
%audiowrite('introduction.wav',recordedVoice,40000); %saving .wav
%save('introduction.mat',"recordedVoice",'-mat'); %saving .mat
%% part 2
[recordedVoice,~] = audioread('introduction.wav'); %reading voice file
spectrogram(recordedVoice,1024,0,1024,40000,'yaxis'); %spectogram
%% part 3
[recordedVoice,Fs] = audioread('introduction.wav'); %reading voice file
spectrogram(recordedVoice,1024,0,1024,40000,'centered'); %centered spectogram
%% part 4
clear
clc
[recordedVoice,Fs] = audioread('introduction.wav'); %reading voice file
rms(recordedVoice)^2 %power of the signal
plot(abs(recordedVoice));
%% part 6
[recordedVoice,Fs] = audioread('introduction.wav'); %reading voice file
recordedVoice = recordedVoice/(rms(recordedVoice)); %normalizing the signal
spectrogram(recordedVoice,1024,0,1024,40000,'centered'); %normalized spectrogram
rms(recordedVoice)^2 %power of the signal
%soundsc(recordedVoice,40000);
plot(abs(recordedVoice));
%% part 7
[recordedVoice,Fs] = audioread('introduction.wav'); %reading voice file
recordedVoice = recordedVoice/(rms(recordedVoice)); %normalizing the signal
voicefft = fft(recordedVoice);
voicefft = fftshift(voicefft);
plot(abs(voicefft)); %ploting spectrum of the voice
fr = dsp.FarrowRateConverter; %making an object from dsp...
fr.InputSampleRate = 40000; %input sample rate which was 40000
fr.OutputSampleRate = 30000; %output sample rate that I think is good
recordedVoice = fr(recordedVoice);
figure(2); %ploting new spectogram of the voice
spectrogram(recordedVoice,1024,0,1024,40000,'centered'); %normalized spectrogram
figure(3); %ploting new spectrum of the voice
voicefft = fft(recordedVoice);
voicefft = fftshift(voicefft);
plot(abs(voicefft));
%% part 8
[music,Fs] = audioread('Rush.mp3'); %reading voice file
fs = 44100;
tenSecondMusic = music(180*fs:190*fs); %cuting 10 seconds of the music 3:00 to 3:10
%soundsc(tenSecondMusic,44100);
save('Rush.mat',"tenSecondMusic",'-mat'); %saving .mat
matData = load('Rush.mat'); %loading .mat file
spectrogram(tenSecondMusic,1024,0,1024,40000,'centered');
figure(2); %ploting spectrum of 10 second music
musicfft = fft(tenSecondMusic);
musicfft = fftshift(musicfft);
plot(abs(musicfft));
fr = dsp.FarrowRateConverter; %making an object from dsp...
fr.InputSampleRate = 44100; %input sample rate which was 44100
fr.OutputSampleRate = 20000; %output sample rate that I think is good
tenSecondMusic = fr(tenSecondMusic);
figure(3); %ploting new spectrum of 10 second music
musicfft = fft(tenSecondMusic);
musicfft = fftshift(musicfft);
plot(abs(musicfft));
soundsc(tenSecondMusic,44100);