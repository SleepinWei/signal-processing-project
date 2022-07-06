function ch_denoise = Wiener(ch1_noise,noise)
    M = 1000;
    len = length(ch1_noise);
    noise_ff = fft(noise);
    eta = sum(abs(noise_ff.^2)) / (len);
%     ham = hamming(M); 
%     ham_ff = fft(ham);
    ch_denoise = zeros(1,length(ch1_noise));
    for i = [1 :M: length(ch1_noise)-M+1] 
%         noise_slice = noise(i:i+M-1);
%         noise_slice_ff = fft(noise_slice); 
%         eta = mean(abs(noise_slice_ff.^2));
        slice_ff = fft(ch1_noise(i:i+M-1));
        slice_amp = abs(slice_ff);
        slice_amp = slice_amp.^2; 
        filter = slice_amp ./(slice_amp + eta);
        slice_filtered = slice_ff .* filter; 
        slice_iff = ifft(slice_filtered);
        ch_denoise(1,i:i+M-1) = real(slice_iff);
    end
end