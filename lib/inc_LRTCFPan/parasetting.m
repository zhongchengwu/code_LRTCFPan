function [paras] = parasetting(sensor, type, I_lrms, I_pan)
% 
[~, ~, l] = size(I_lrms);
sz = size(I_pan);
Nways = [sz, l];
paras = [];
paras.sz = sz;
paras.Nways = Nways;
paras.tol = 2*1e-5;
paras.maxit = 200;
% Such parameter configuration can be further fine-tuned
% on your data, if need.
%% =====Paras setting========
switch sensor
    case 'none'   % Guangzhou dataset (GF-2)
        if strcmp(type, 'R')
            lambda{1} = 0.05;
            lambda{2} = 18;
            lambda{3} = 1e-4;
            eta{1} = 1e-4;
            eta{2} = 8.1;
            eta{3} = 1.8; 
            paras.eta = eta;
            paras.lower = 0;
            paras.lambda = lambda;
            paras.block_size = [8, 8];
        elseif strcmp(type, 'F')
            lambda{1} = 1;
            lambda{2} = 50;
            lambda{3} = 1e-4;
            eta{1} = 1e-4;
            eta{2} = 2.1;
            eta{3} = 4.7;
            paras.eta = eta;
            paras.lower = 0.4;
            paras.lambda = lambda;
            paras.block_size = [10, 10];
        end
    case 'QB'   % Indianapolis dataset (QB)
         if strcmp(type, 'R')
             lambda{1} = 0.11;
             lambda{2} = 65;
             lambda{3} = 1e-4;
             eta{1} = 1e-4;
             eta{2} = 1.1;
             eta{3} = 8.7;
             paras.eta = eta;
             paras.lower = 0;
             paras.lambda = lambda;
             paras.block_size = [8, 8];
        elseif strcmp(type, 'F')
            lambda{1} = 0.4;
            lambda{2} = 75;
            lambda{3} = 0.1;
            eta{1} = 1e-3;
            eta{2} = 2.1;
            eta{3} = 6.7;
            paras.eta = eta;
            paras.lower = 0.8;
            paras.lambda = lambda;
            paras.block_size = [10, 10];
        end
     case 'WV3'   % Rio dataset (WV-3)
         if strcmp(type, 'R')
             lambda{1} = 0.14;
             lambda{2} = 56;
             lambda{3} = 1e-4;
             eta{1} = 1e-4;
             eta{2} = 4.2;
             eta{3} = 8.3;
             paras.eta = eta;
             paras.lower = 0;
             paras.lambda = lambda;
             paras.block_size = [8, 8];
        elseif strcmp(type, 'F')
            lambda{1} = 1.1;
            lambda{2} = 36;
            lambda{3} = 1e-4;
            eta{1} = 1e-4;
            eta{2} = 6.2;
            eta{3} = 3.3;
            paras.eta = eta;
            paras.lower = 0.6;
            paras.lambda = lambda;
            paras.block_size = [10, 10];
         end
end
%
end