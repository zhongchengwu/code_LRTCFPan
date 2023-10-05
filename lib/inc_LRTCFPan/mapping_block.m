function block_high_pan = mapping_block(block_lrms, block_pan)
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Oct. 31, 2021
% Updated by 
% Apr. 01, 2023
%
[~, ~, S] = size(block_lrms);
for i=1:S
    temp = block_lrms(:,:,i);
    block_high_pan(:,:,i) = (std2(temp)./std2(block_pan))...
        .*(block_pan-mean2(block_pan))+mean2(temp);
end
%
end
