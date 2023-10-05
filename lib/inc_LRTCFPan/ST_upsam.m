function z = ST_upsam(y, sf, sz, Nways)
% Created by Zhong-Cheng Wu (wuzhch97@163.com)
% Oct. 31, 2021
% Updated by 
% Apr. 01, 2023
%
z = zeros(Nways);
t = zeros(sz);
s0 = 3;
for i=1:Nways(3)
    t(s0:sf:end,s0:sf:end) = y(:,:,i);
    z(:,:,i) = t;
end
%
end

