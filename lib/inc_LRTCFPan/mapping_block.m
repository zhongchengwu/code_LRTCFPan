function block_high_pan = mapping_block(block_lrms, block_pan)
%
[~, ~, S] = size(block_lrms);
for i=1:S
    temp = block_lrms(:,:,i);
    block_high_pan(:,:,i) = (std2(temp)./std2(block_pan))...
        .*(block_pan-mean2(block_pan))+mean2(temp);
end
%
end