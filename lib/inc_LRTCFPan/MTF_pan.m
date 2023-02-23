%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           MTF filters the panchromatic (PAN) image using a Gaussin filter matched with the Modulation Transfer Function (MTF) of the PAN sensor. 
% 
% Interface:
%           I_Filtered = MTF_PAN(I_PAN,sensor,ratio)
%
% Inputs:
%           I_PAN:          PAN image;
%           sensor:         String for type of sensor (e.g. 'WV2', 'IKONOS');
%           ratio:          Scale ratio between MS and PAN.
%
% Outputs:
%           I_Filtered:     Output filtered PAN image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function I_Filtered = MTF_pan(I_PAN,sensor,ratio)
%
switch sensor
    case 'QB' 
        GNyq = 0.15; 
    case 'IKONOS'
        GNyq = 0.17;
    case {'GeoEye1','WV4'}
        GNyq = 0.16;
    case 'WV2'
        GNyq = 0.11;
    case 'WV3'
        GNyq = 0.14; 
    case 'none'
        GNyq = 0.15;
end
%
N = 41;
fcut = 1/ratio;
%
alpha = sqrt(((N-1)*(fcut/2))^2/(-2*log(GNyq)));
H = fspecial('gaussian', N, alpha);
Hd = H./max(H(:));
h = fwind1(Hd,kaiser(N));
I_PAN_LP = imfilter(I_PAN,real(h),'replicate');
%
I_Filtered= double(I_PAN_LP);
%
end