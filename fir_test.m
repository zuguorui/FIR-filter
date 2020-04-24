function fir_test()

clear all;
close all;

N = 256;
sampleRate = 8000;
freqs = [100, 500, 1000];
gain = [70, 0, 30];


filter = fir_filter(sampleRate, gain, freqs, N);

figure
freqz(filter);