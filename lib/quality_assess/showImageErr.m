% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Sep. 20, 2021
% Updated by 
% Feb. 15, 2023

function showImageErr(Ori_Imag, Output, range_bar)
% This is a demo to show the error map of GT and Estimated Img
if size(Ori_Imag,3)==4
    channel = [3 2 1];
    frame = 1;
elseif size(Ori_Imag,3)==8
    channel = [5 3 2];
    frame = 1;
end
%
Multi_Err = abs(Ori_Imag(:, :, channel, frame) - Output(:, :, channel, frame));
ErrMap = mean(Multi_Err,3);
imshow(ErrMap,[])
%#######################
caxis(range_bar)
% colorbar;
colormap jet
axis off
%#######################
end