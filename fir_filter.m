function filter = fir_filter(response, sampleRate, type)

% 1型FIR滤波器，其振幅响应H[k]是一个偶函数，其冲激响应具有奇数长度，并且满足h[n] = h[N-n]
if type == 1
   
end
% 2型FIR滤波器，其振幅响应H[k]是一个偶函数，其冲击响应具有偶数长度，并且满足h[n] = h[N-n]
if type == 2
    
end
% 3型FIR滤波器，其振幅响应H[k]是一个奇函数，其冲击响应具有奇数长度，并且满足h[n] = -h[N-n]
if type == 3
    
end
% 4型FIR滤波器，其振幅响应H[k]是一个奇函数，其冲激响应具有偶数长度，并且满足h[n] = -h[N-n]
if type == 4
    
end


function filter = fir_filter1(response, sampleRate)



