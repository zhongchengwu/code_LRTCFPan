%% =================================================================
% This script runs the LRTCFPan code.
%
% Please make sure your data is in range [0, 1].
%
% Reference: Zhong-Cheng Wu, Ting-Zhu Huang*, Liang-Jian Deng*, Jie Huang, Jocelyn Chanussot, Gemine Vivone
%            "LRTCFPan: Low-Rank Tensor Completion Based Framework for Pansharpening"
%             IEEE Transactions on Image Processing (TIP), 2023.
%
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Mar. 10, 2021
% Updated by 
% Feb. 15, 2023

%% =================================================================
clc;
clear;
close all;
addpath(genpath([pwd,'/lib']));
%
load 'Sim_gf2_guangzhou.mat'
fprintf('### number of experiments: %d ...###\n', num);
%
fprintf('###################### Please wait......######################\n')
%% Perform interpolated image (i.e., EXP)
I_exp = interp23tap(I_lrms, ratio);
Metrics_exp = indexes_eval(Ref_I_gt, I_exp, ratio, 'print'); 

%% Perform LRTCFPan algorithm
% Parameter settings
paras = parasetting(sensor, type, I_lrms, I_pan);
% Such parameter configuration can be further fine-tuned
paras.ratio = ratio;
paras.sensor = sensor;
%
t_start = tic; 
[I_fused] = inc_LRTCFPan(I_lrms, I_pan, paras);
time_LRTCFPan = toc(t_start);
Metrics_fused = indexes_eval(Ref_I_gt, I_fused, ratio, 'print');
%
fprintf('###################### Complete execution! ! !######################\n')

%% Show result
location = [180 220 5 105];
range_bar = [0, 0.15];
%
Re_images{1} = I_exp;
Re_images{2} = I_fused;
Image_truncate(Ref_I_gt, Re_images, location)    % Display the RGB images
%
Image_residual(Ref_I_gt, Re_images, range_bar)   % Display the error maps
%