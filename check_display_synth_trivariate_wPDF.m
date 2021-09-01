%%%%%
% Display three series, the target covariances and the estimated ones
%
% pb 09/2009

function check_display_synth_trivariate_wPDF(X,C,nfig)

if nargin<3,
    nfig=0;
end

Nx = length(X) ;

%% Display Series

if nfig
    figure(nfig+1); clf
else
    figure
end
subplot 311
plot(X(1,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);
ylabel('X(t)')
subplot 312
plot(X(2,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);
ylabel('Y(t)')
subplot 313
plot(X(3,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);
ylabel('Z(t)')

%% Check Covariances

[cx_est,lags] = xcorr(X(1,:)) ;
[cy_est,lags] = xcorr(X(2,:)) ;
[cz_est,lags] = xcorr(X(3,:)) ;

[cxy_est,lags] = xcorr(X(1,:),X(2,:)) ;
[cxz_est,lags] = xcorr(X(1,:),X(3,:)) ;
[cyz_est,lags] = xcorr(X(2,:),X(3,:)) ;


cx = C{1,1};
cy = C{2,2};
cz = C{3,3};
cxy = C{1,2}; cyx = C{2,1};
if isempty(cyx), cyx=cxy; end
cxz = C{1,3}; czx = C{3,1};
if isempty(czx), czx=cxz; end
cyz = C{2,3}; czy = C{3,2};
if isempty(czy), czy=cyz; end

Nc=length(cx);

if nfig
    figure(nfig+2); clf
else
    figure
end
subplot 311
plot([-(Nc-1):(Nc-1)], [fliplr(cx(2:Nc)) cx],'r'); 
hold on
plot(lags,cx_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{XX}')

subplot 312
plot([-(Nc-1):(Nc-1)], [fliplr(cy(2:Nc)) cy],'r'); 
hold on
plot(lags,cy_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{YY}')

subplot 313
plot([-(Nc-1):(Nc-1)], [fliplr(cz(2:Nc)) cz],'r'); 
hold on
plot(lags,cz_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{ZZ}')

if nfig
    figure(nfig+3); clf
else
    figure
end
subplot 311
plot([-(Nc-1):(Nc-1)], [fliplr(cxy(2:Nc)) cyx],'r'); 
hold on
plot(lags,cxy_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{XY}')

subplot 312
plot([-(Nc-1):(Nc-1)], [fliplr(cxz(2:Nc)) czx],'r'); 
hold on
plot(lags,cxz_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{XZ}')

subplot 313
plot([-(Nc-1):(Nc-1)], [fliplr(cyz(2:Nc)) czy],'r'); 
hold on
plot(lags,cyz_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{YZ}')

%% Histograms

[hh1,bins1] = hist(X(1,:),100) ;
[hh2,bins2] = hist(X(2,:),100) ;
[hh3,bins3] = hist(X(3,:),100) ;


hh1 = hh1./sum(hh1)./(bins1(3)-bins1(2)) ;
hh2 = hh2./sum(hh2)./(bins2(3)-bins2(2)) ;
hh3 = hh3./sum(hh3)./(bins3(3)-bins3(2)) ;

if nfig
    figure(nfig+4); clf
else
    figure
end
subplot 311
bar(bins1,hh1);

subplot 312
bar(bins2,hh2);

subplot 313
bar(bins3,hh3);

% TODO : joint-PDF


return





