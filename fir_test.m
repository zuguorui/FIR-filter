function fir_test()

clear all;
close all;

N = 255;
sampleRate = 8000;
freqs = [1000, 1500];
gain = [0, 60];


filter = fir_filter(sampleRate, gain, freqs, N);

figure
freqz(filter);