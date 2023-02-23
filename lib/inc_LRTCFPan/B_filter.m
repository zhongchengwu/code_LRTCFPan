function x = B_filter(z, fft_B, Nways)
%
x = zeros(Nways);
for i=1:Nways(3)
    x(:,:,i) = real(ifft2(fft2(z(:,:,i)).*fft_B(:,:,i)));
end   
end