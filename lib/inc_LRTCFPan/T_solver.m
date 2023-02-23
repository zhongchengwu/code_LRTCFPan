function T_out = T_solver(Z, I_lrms, opts)
%
ratio = opts.ratio;
Nways = opts.Nways;
s0 = 3;
lambda = opts.lambda;
T = Log_prox_tnn(Z, lambda{3}/(2*lambda{2}));
%
for band=1:Nways(3)
    T(s0:ratio:end,s0:ratio:end,band) = I_lrms(:,:,band);
end
T_out = T;
%
end