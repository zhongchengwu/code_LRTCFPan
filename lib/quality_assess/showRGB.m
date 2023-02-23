% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Sep. 20, 2021
% Updated by 
% Feb. 15, 2023

function showRGB(Ori_Imag, Output, location)
%
if size(Ori_Imag,3)==4
    channel = [3 2 1];
    frame = 1;
elseif size(Ori_Imag,3)==8
    channel = [5 3 2];
    frame = 1;
end
%
th_MSrgb = image_quantile(Ori_Imag(:,:,channel,frame), [0.01 0.99]);
I_fuse = image_stretch(Output(:,:,channel,frame),th_MSrgb);
ent = rectangleonimage(I_fuse, location, 0.5, 3, 1, 2, 2);
imshow(ent,[])
%
end