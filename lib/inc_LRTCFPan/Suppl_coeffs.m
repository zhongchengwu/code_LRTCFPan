function CoeffsSuped = Suppl_coeffs(CoeffsToSup,tol1,tol2,tol3)
%
iptsetpref('ImshowBorder', 'tight')
CoeffsToSup = double(CoeffsToSup);
L = size(CoeffsToSup,3);
% if (L<3)
%     CoeffsToSup=CoeffsToSup(:,:,[1 1 1]);
% end
%
if nargin == 1
    tol1 = [0.01 0.99];
end
if nargin <= 2
    tol = repmat(tol1, [L 1 1]);
    CoeffsSuped = linstretch(CoeffsToSup,tol);
%     figure,imshow(ImageToView(:,:,3:-1:1),[])
elseif nargin == 4
    if sum(tol1(2)+tol2(2)+tol3(2)) <= 3
        tol = [tol1;tol2;tol3];
        CoeffsSuped = linstretch(CoeffsToSup,tol);
%         figure,imshow(ImageToView(:,:,3:-1:1),[])
    else
        tol = [tol1;tol2;tol3];
        [N,M,~] = size(CoeffsToSup);
        NM = N*M;
        for i=1:3
            b = reshape(double(uint16(CoeffsToSup(:,:,i))),NM,1);
            b(b<tol(i,1))=tol(i,1);
            b(b>tol(i,2))=tol(i,2);
            b = (b-tol(i,1))/(tol(i,2)-tol(i,1));
            CoeffsSuped(:,:,i) = reshape(b,N,M);
        end
%         figure,imshow(ImageToView(:,:,3:-1:1),[])
    end
end
%
iptsetpref('ImshowBorder', 'loose')
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           Linear Stretching. 
% 
% Interface:
%           ImageToView = linstretch(ImageToView,tol)
%
% Inputs:
%           ImageToView:    Image to stretch;
%           tol:            Range;
%
% Outputs:
%           ImageToView:    Stretched image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CoeffsSuped = linstretch(CoeffsToSup,tol)
times = 1500;
CoeffsToSup = times*CoeffsToSup; %convert to......
[N,M,L] = size(CoeffsToSup);
CoeffsSuped = zeros([N,M,L]);
NM = N*M;
for i=1:L
    b = reshape(double(uint32(CoeffsToSup(:,:,i))),NM,1);
    [hb,levelb] = hist(b,max(b)-min(b));
    chb = cumsum(hb);
    t(1) = ceil(levelb(find(chb>NM*tol(i,1), 1 )));
    t(2) = ceil(levelb(find(chb<NM*tol(i,2), 1, 'last' )));
    b(b<t(1))=t(1);
    b(b>t(2))=t(2);
%     b = (b-t(1))/(t(2)-t(1));
    CoeffsSuped(:,:,i) = reshape(b,N,M);
end
%
CoeffsSuped = CoeffsSuped/times;
%
end