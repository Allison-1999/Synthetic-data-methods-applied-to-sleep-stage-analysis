%%%%%
% Display the two series, the target covariances and the estimated ones
%
% pb 09/2009

function check_display_synth_bivariate_wPDFjoint(X,C,nfig)

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
subplot 211
plot(X(1,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);
ylabel('X(t)')
subplot 212
plot(X(2,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);
ylabel('Y(t)')

%% Check Covariances

[cx_est,lags] = xcorr(X(1,:)-mean(X(1,:))) ;
[cy_est,lags] = xcorr(X(2,:)-mean(X(2,:))) ;
[cxy_est,lags] = xcorr(X(1,:)-mean(X(1,:)),X(2,:)-mean(X(2,:))) ;


cx = C{1,1};
cy = C{2,2};
cxy = C{1,2};
cyx = C{2,1};
if length(cyx)==0, cyx=cxy; end

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
plot([-(Nc-1):(Nc-1)], [fliplr(cxy(2:Nc)) cyx],'r'); 
hold on
plot(lags,cxy_est/Nx,'k')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);
ylabel('C_{XY}')

%% Histograms

[hh1,bins1] = hist(X(1,:),100) ;
[hh2,bins2] = hist(X(2,:),100) ;

hh1 = hh1./sum(hh1)./(bins1(3)-bins1(2)) ;
hh2 = hh2./sum(hh2)./(bins2(3)-bins2(2)) ;

if nfig
    figure(nfig+3); clf
else
    figure
end
subplot 211
bar(bins1,hh1);

subplot 212
bar(bins2,hh2);

%% Joint-PDF

if nfig
    figure(nfig+4); clf
else
    figure
end
% hist3(X(1:2,:)',[30 30])
[h binsX binsY hX hY] = joint_hist(X(1,:)',X(2,:)',30,30) ;
imagesc(h)




return

