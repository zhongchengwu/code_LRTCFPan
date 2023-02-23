function Index = indexes_eval(HR_ref, HR_fused, ratio, flag)
%================
% This is a demo to compute pansharpening indexes.
%
% ratio: GSD ratio between HR-MS and LR-MS images.
%
% NOTE: the image is an H*W*S array and DYNAMIC RANGE [0, 1]. 
%
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Mar. 10, 2021
% Updated by 
% Feb. 15, 2023
%================
[rows, cols, tubs] = size(HR_ref);
%% Calculate similarity
psnr_vec = zeros(tubs, 1);
ssim_vec = zeros(tubs, 1);
Ref_8bit = HR_ref*255;
Fus_8bit = HR_fused*255;
for f_slice = 1:tubs
    psnr_vec(f_slice) = psnr_index(Ref_8bit(:, :, f_slice), Fus_8bit(:, :, f_slice));
    ssim_vec(f_slice) = ssim_index(Ref_8bit(:, :, f_slice), Fus_8bit(:, :, f_slice));
end
Index.PSNR = mean(psnr_vec);
Index.SSIM = mean(ssim_vec);
% Remove border for the subsequent analysis
HR_ref = HR_ref(ratio+1:rows-ratio, ratio+1:cols-ratio, :);
HR_fused = HR_fused(ratio+1:rows-ratio, ratio+1:cols-ratio, :);
HR_ref(HR_ref > 1) = 1;
HR_ref(HR_ref < 0) = 0;
%
 [ind_sam, ~] = SAM(HR_ref, HR_fused);
 Index.SAM = ind_sam;
 Index.SCC = CC(HR_ref, HR_fused);
%
 Index.ERGAS = ERGAS(HR_ref, HR_fused, ratio);
 Index.Q = Q(HR_ref, HR_fused);
%
 if strcmp(flag, 'print')
    fprintf('########### PSNR: %.4f   SSIM: %.4f   SAM: %.4f   SCC: %.4f   ERGAS: %.4f   Q: %.4f ###########\n',...
    Index.PSNR, Index.SSIM, Index.SAM, Index.SCC, Index.ERGAS, Index.Q)
 end
%
end