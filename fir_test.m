function fir_test()

clear all;
close all;

N = 1000;
sampleRate = 8000;
freqs = [100, 500, 1000];
gain = [70, 50, 30];


filter = fir_filter(sampleRate, gain, freqs, N);

figure
freqz(filter);