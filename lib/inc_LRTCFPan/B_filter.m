function x = B_filter(z, fft_B, Nways)
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Oct. 31, 2021
% Updated by 
% Apr. 01, 2023
%
x = zeros(Nways);
for i=1:Nways(3)
    x(:,:,i) = real(ifft2(fft2(z(:,:,i)).*fft_B(:,:,i)));
end   
end
