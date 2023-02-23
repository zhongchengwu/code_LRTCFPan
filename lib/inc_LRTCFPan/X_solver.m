function X_out = X_solver(U, V, Z, Theta_1, Theta_2, Theta_3, par, opts)
%
eta = opts.eta;
Nways = opts.Nways;
X_out = zeros(Nways);
%
for band = 1:Nways(3)
    FFT_molecular = eta{1}*fft2(U(:,:,band))-fft2(Theta_1(:,:,band))+...
        eta{2}*fft2(V(:,:,band))-fft2(Theta_2(:,:,band))+eta{3}*fft2(Z(:,:,band)).*par.fft_BT(:,:,band)...
        -fft2(Theta_3(:,:,band)).*par.fft_BT(:,:,band);
    %
    FFT_denominator = eta{3}*par.fft_B(:,:,band).*par.fft_BT(:,:,band) + (eta{1}+eta{2});
    %
    X_out(:,:,band) = real(ifft2(FFT_molecular./FFT_denominator));
end
%
X_out(X_out>1)=1;
X_out(X_out<0)=0;
%
end 