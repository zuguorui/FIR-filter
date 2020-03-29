function freqResponse = generateResponse(sampleRate, profile, banks, N)

M = fix(N / 2);
maxFreq = sampleRate / 2;


freqStep = maxFreq / M;

freqResponse = ones(1, N);

filterIndex = 1;
profileIndex = 1;

previousFreq = 0;
currentFreq = 0;
previousGain = 0;
currentGain = 0;
allFinish = false;
while profileIndex <= length(profile)
    if(allFinish == true)
        break;
    end
    currentFreq = banks(profileIndex);
    currentGain = 10^(profile(profileIndex) * 0.05);
    if(profileIndex == 1)
        previousFreq = 0;
        previousGain = 10^(profile(1) * 0.05);
    else
        previousFreq = banks(profileIndex - 1);
        previousGain = 10^(profile(profileIndex - 1) * 0.05);
    end
    centerFreq = (currentFreq + previousFreq) / 2;
    while true
        if filterIndex == M + 1
            allFinish = true;
            break;
        end
        freq1 = filterIndex * freqStep;
        if freq1 <= centerFreq
            freqResponse(filterIndex) = previousGain;
        elseif freq1 > centerFreq && freq1 <= currentFreq
            freqResponse(filterIndex) = currentGain;
        else
            break;
        end
        filterIndex = filterIndex + 1;
    end
    profileIndex = profileIndex + 1;
end

if filterIndex < M+1
    currentGain = 10^(profile(length(profile)) * 0.05);
    while filterIndex <= M
        freqResponse(filterIndex) = currentGain;
        filterIndex = filterIndex + 1;
    end
end

for i = 0 : M-1
    freqResponse(N - i) = freqResponse(i + 1);
end

end