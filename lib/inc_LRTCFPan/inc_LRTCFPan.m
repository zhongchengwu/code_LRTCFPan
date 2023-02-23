function [X_out] = inc_LRTCFPan(I_lrms, I_pan, paras)
% Initiation
tol = paras.tol; 
eta = paras.eta;
maxit = paras.maxit;            
Nways = paras.Nways;
ratio = paras.ratio;
sensor = paras.sensor;
lambda = paras.lambda;
I_incos = Compute_inj_comps(I_lrms, I_pan, paras);
% Histogram mapping
par = FFT_kernel(ratio, sensor ,Nways);
%
rng('default')
U = zeros(Nways); 
V = U; 
Z = U; 
T = U;
Theta_1 = U; 
Theta_2 = V; 
Theta_3 = Z;
X = interp23tap(I_lrms, ratio); % Initialize the X
%%
X_k = X;
for it = 1:maxit
    % update X
    X = X_solver(U, V, Z, Theta_1, Theta_2, Theta_3, par, paras);
    % update U
    [U, ~] = Log_prox_tnn(X+Theta_1/eta{1}, 1/eta{1});
    % update V
    V = (2*lambda{1}*(Z+I_incos)+eta{2}*X+Theta_2) / (2*lambda{1}+eta{2});
    % update Z
    Z = (2*lambda{1}*(V-I_incos)+2*lambda{2}*T+eta{3}*par.B(X)+Theta_3) / (2*(lambda{1}+lambda{2})+eta{3});
    % update T
    T = T_solver(Z, I_lrms, paras);
    % update Theta
    Theta_1 = Theta_1 + eta{1}*(X-U);
    Theta_2 = Theta_2 + eta{2}*(X-V); 
    Theta_3 = Theta_3 + eta{3}*(MTF_lrms(X, sensor, '', ratio) - Z); % efficient or time-safe
    %%
    Rel_Err = norm(Unfold(X-X_k, Nways, 3), 'fro')/norm(Unfold(X_k, Nways, 3), 'fro');
    X_k = X;
    if Rel_Err < tol  
        break;
    end   
end
%
X_out = X;
%
end