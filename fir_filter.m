%% ����freqs�϶�Ӧ��gains����fir�˲�����Ƶ����Ӧ��
% sampleRate��������
% gain���������飬��λΪdB��
% freqs��response��Ӧ��Ƶ�ʵ�
% N��Ҫ���ɵ�fir�˲�������
function h = fir_filter(sampleRate, gain, freqs, N)

% ����N=5����ô���ǿ���֪��H[1] = H[4], H[2] = H[3]�����ֻҪ�����H[0]��H[1]��H[2]����Եõ�������H[0]��H[1]��H[2]��H[3]��H[4]������ͨ��IDFT�õ�ʱ���ϵ�h[n]��
% ����N=6��ͬ��H[1]=H[5]��H[2]=H[4]�����ֻҪ�����H[0]��H[1]��H[2]��H[3]���Ϳ��Եõ�������H[0]��H[1]��H[2]��H[3]��H[4]��H[5]��
% Ҫע��Matlab�����±��1��ʼ����˻�Ҫ�ٴ���һ�¡�
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

% �������������N����������ż���������в�ͬ�ĶԳ��ԡ�
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

% ���ⲽ���Ⱦͼ������ˣ����ż�����λ
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