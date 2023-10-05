function high_pan = hist_mapping(I_lrms, I_pan, ratio, blocksize)
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Oct. 31, 2021
% Updated by 
% Apr. 01, 2023
%
br = blocksize(1);
bc = blocksize(2);
[nr, nc, S] = size(I_lrms);
[Nr, Nc] = size(I_pan);
high_pan = zeros(Nr, Nc, S);
while mod(nr, br)~=0 
    br = br-1;
end
while mod(nc, bc)~=0 
    bc = bc-1;
end
gridx = 1:br:nr-br+1; gridX = 1:ratio*br:Nr-ratio*br+1;
gridy = 1:bc:nc-bc+1; gridY = 1:ratio*bc:Nc-ratio*bc+1;
for i=1:length(gridx)
    for j=1:length(gridy)
        high_pan(gridX(i):gridX(i)+ratio*br-1,gridY(j):gridY(j)+ratio*bc-1,:) = mapping_block...
            (I_lrms(gridx(i):gridx(i)+br-1,gridy(j):gridy(j)+bc-1,:), ...
            I_pan(gridX(i):gridX(i)+ratio*br-1, gridY(j):gridY(j)+ratio*bc-1));
    end
end
%
end
