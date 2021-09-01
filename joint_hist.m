% Joint Histogram for 2 data
%
% [h binsX binsY hX hY] = joint_hist(X,Y,NhX,NhY) ;
% [h binsX binsY hX hY] = joint_hist(X,Y,binsX,binsY) ;
%
% X, Y          input data
% NhX, NhY      Number of bins for each Data (default: 20)
% or binsX, binsY
% h             Joint, 2D- histogram
% binsX         bins selected for X (center)
% binsY 
% hX            Marginal histogram for X
% hY            Marginal histogram for Y
%
% pb 2008/10 (but see also hist3)



function [h binsX binsY hX hY] = joint_hist(X,Y,NhX,NhY)

if nargin <3, 
    NhX=20;
    NhY=20;
elseif nargin <4
    NhY=NhX;
end;

if length(NhX)>1,
binsX=NhX; 
binsY=NhY;

DX=binsX(3)-binsX(2);
EdgesX=binsX-DX/2 ;
EdgesX(1)=-inf;
EdgesX(end+1)=inf;

DX=binsY(3)-binsY(2);
EdgesY=binsY-DX/2 ;
EdgesY(1)=-inf;
EdgesY(end+1)=inf;

else
SpanX=max(X)-min(X);
DX=SpanX/(NhX-1);
EdgesX=min(X)-eps:DX:max(X)+DX+eps;

SpanY=max(Y)-min(Y);
DY=SpanY/(NhY-1);
EdgesY=min(Y)-eps:DY:max(Y)+DY+eps;

end

[hX, iX]=histc(X,EdgesX) ;

[hY, iY]=histc(Y,EdgesY) ;

if length(NhX)==1,
binsX = EdgesX(1:end-1)+DX/2;
binsY = EdgesY(1:end-1)+DY/2;
end;

h = accumarray([iX, iY], ones(size(iX))) ;
h = h' ;

return



% for kk=1:MX,
%   ind=find(X==kk);
%   [h(kk,:),bins]=hist(Y(ind),1:MY) ;
%   h2(kk,:) = h(kk,:) ./ sum(h(kk,:));
%   h3(kk,:) = h(kk,:) ./ max(h(kk,:));
% end

