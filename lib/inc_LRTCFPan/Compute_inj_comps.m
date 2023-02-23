function Inj_comps = Compute_inj_comps(I_lrms, I_pan, paras)
%
sz = paras.sz;
ratio = paras.ratio;
Nways = paras.Nways;
lower = paras.lower;
sensor = paras.sensor;
block_size = paras.block_size;
P_highdim = hist_mapping(I_lrms, I_pan, ratio, sz/ratio);
Phigh_lp = MTF_lrms(P_highdim, sensor, '', ratio);
Phigh_lp_done = imresize(Phigh_lp, 1/ratio, 'nearest');
%
for band = 1:Nways(3)
    op_band = MTF_pan(P_highdim(:,:,band), sensor, ratio);
    Phigh_lp_ori(:,:,band) = op_band;
    op_band_de = imresize(op_band, 1/ratio, 'nearest');
    Phigh_de(:,:,band) = op_band_de;
end
%
Phigh_de_lp = MTF_lrms(Phigh_de, sensor, '', ratio);
I_LRMS_lp = MTF_lrms(I_lrms, sensor, '', ratio);
I_LRMS_hp = I_lrms - I_LRMS_lp;
Phigh_de_hp = Phigh_lp_done - Phigh_de_lp;
Block_index = [sz/ratio./block_size, Nways(3)];
Coeffs_de = zeros(Block_index);
%
for ii=1:Block_index(1)
    for jj=1:Block_index(2)
        for kk=1:Block_index(3)
            block_lrms = I_LRMS_hp(block_size(1)*(ii-1)+1:block_size(1)*(ii-1)+block_size(1), ...
                block_size(2)*(jj-1)+1:block_size(2)*(jj-1)+block_size(2), kk);
            block_pan = Phigh_de_hp(block_size(1)*(ii-1)+1:block_size(1)*(ii-1)+block_size(1), ...
                block_size(2)*(jj-1)+1:block_size(2)*(jj-1)+block_size(2), kk);
            Coeffs_de(ii,jj,kk) = ((block_pan(:))'*block_pan(:))^(-1) * (block_pan(:))'*block_lrms(:);
        end
    end
end
Coeffs_de(Coeffs_de<0) = 0;
%
Coeffs_de_sup = Suppl_coeffs(Coeffs_de, [lower 1]);
Coeffs = imresize(Coeffs_de_sup, sz, 'box');
Inj_comps = Coeffs.*(P_highdim - Phigh_lp_ori);
%
end