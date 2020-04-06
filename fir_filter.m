%% 根据freqs上对应的gains生成fir滤波器的频域响应。
% sampleRate：采样率
% gain：增益数组，单位为dB。
% freqs：response对应的频率点
% N：要生成的fir滤波器长度
function h = fir_filter(sampleRate, gain, freqs, N)

% 假设N=5，那么我们可以知道H[1] = H[4], H[2] = H[3]。因此只要计算出H[0]、H[1]、H[2]便可以得到完整的H[0]、H[1]、H[2]、H[3]、H[4]，进而通过IDFT得到时域上的h[n]。
% 假设N=6，同理，H[1]=H[5]，H[2]=H[4]。因此只要计算出H[0]、H[1]、H[2]、H[3]，就可以得到完整的H[0]、H[1]、H[2]、H[3]、H[4]、H[5]。
% 要注意Matlab代码下标从1开始，因此还要再处理一下。
M = 0;
if rem(N, 2) == 1
    M = (N - 1) / 2;
else
    M = N / 2;
end
M= M + 1;



freqStep = sampleRate / N;

H_amp = ones(1, N);

freqEdge = ones(1, length(freqs));

for i = 1 : (length(freqs) - 1)
    freqEdge(i) = (freqs(i) + freqs(i + 1)) / 2;
end
freqEdge(length(freqEdge)) = sampleRate;

freqIndex = 1;
ampIndex = 1;
while true
    
    if ampIndex > M
        break
    end
    if (ampIndex - 1) * freqStep > freqEdge(freqIndex)
        freqIndex = freqIndex + 1;
        continue
    else
        H_amp(ampIndex) = 10 ^ (gain(freqIndex) * 0.05);
        ampIndex = ampIndex + 1;
    end
end

% 上面提过，根据N是奇数还是偶数，幅度有不同的对称性。
if rem(N, 2) == 1
    for i = 1 : N-M
        H_amp(M + i) = H_amp(M - i + 1);
    end
else
    for i = 1 : N-M
        H_amp(M + i) = H_amp(M - i);
    end
end

figure
plot(H_amp);

% 到这步幅度就计算完了，接着计算相位
w0 = 2 * pi / N;
theta = (w0 * 1) .* [0 : 1 : N-1];
H_phase = exp(-1i .* theta);

H = H_amp .* H_phase;

h = ifft(H, N);

h = circshift(h',M)';

h = real(h);

window = hanning(N);

h = h .* window';

end