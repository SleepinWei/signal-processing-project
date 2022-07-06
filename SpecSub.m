function ch_denoise = SpecSub(ch_noise,backg)
    ff_wn = fft(backg);
    D2 = mean(abs(ff_wn).^2);
    
    ch_ff = fft(ch_noise);
    angles = angle(ch_ff);
    amp_ff = abs(ch_ff).^2;
    % amp_ff = abs(ch_ff);
    amp_ff_denoise = amp_ff-D2;
    amp_ff_denoise(amp_ff_denoise <0) =0;
    amp_ff_denoise = sqrt(amp_ff_denoise);
    ff_denoise = amp_ff_denoise .* exp(1j * angles);
    ch_denoise = real(ifft(ff_denoise));
end