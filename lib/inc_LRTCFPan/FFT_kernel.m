function par = FFT_kernel(sf, sensor, Nways)
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Oct. 31, 2021
% Updated by 
% Apr. 01, 2023
%
sz = [Nways(1) Nways(2)];
switch sensor
    case 'QB' 
        GNyq = [0.34 0.32 0.30 0.22]; % Band Order: B,G,R,NIR
    case 'IKONOS'
        %GNyq = [0.26,0.28,0.29,0.28]; % Band Order: B,G,R,NIR
        GNyq = 0.3 .* ones(1,Nways(3));
    case 'GeoEye1'
        GNyq = [0.23,0.23,0.23,0.23]; % Band Order: B,G,R,NIR
    case 'WV2'
        GNyq = [0.35 .* ones(1,7), 0.27];
    case 'WV3'    
        GNyq = [0.325 0.355 0.360 0.350 0.365 0.360 0.335 0.315];
    case 'none'
        GNyq = 0.3 .* ones(1,Nways(3));
end
%
N = 41;
OTF  = zeros(Nways);
OTFT = zeros(Nways);
fcut = 1/sf;
for i=1:Nways(3)
    alpha = sqrt(((N-1)*(fcut/2))^2/(-2*log(GNyq(i))));
    H = fspecial('gaussian', N, alpha);
    Hd = H./max(H(:));
    h = fwind1(Hd,kaiser(N));
    psf = real(h);
    temp = psf2otf(psf,sz);
    temp1 = conj(temp);
    OTF(:,:,i) = temp;
    OTFT(:,:,i) = temp1;
end
par.fft_B = OTF;
par.fft_BT = OTFT;
%
par.B = @(z)B_filter(z, par.fft_B, Nways);
par.ST = @(y)ST_upsam(y, sf, sz, Nways);
%
end
