% ALGORITHM 2 AND FIGURE 2 for submitted ICASSP 12 PAPER: 
% Multivariate Surrogates 
%
% Example with prescribed covariance and joint-distribution
% 
% Using codes of Surrogates 
% ALGORITHM 2 of the paper
%
% Pierre Borgnat, Patrice Abry, Patrick Flandrin, 09/2011


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prepare some orginal multivariate processes (with circulant embedding)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N2 = 2^15; 

% Generate Bivariate Covariance Structure
clear R2
    ax = 0.5 ;
    ay = 1 ;
    axy = 0.7 ;
    sxy = 0.7 ;
    nn=0:N2-1;
    cx = exp(-ax*nn) ; 
    cy = exp(-ay*nn) ; 
    cxy = sxy * exp(-axy*nn) ; 
    
    R2{1,1} = cx;
    R2{1,2} = cxy;
    R2{2,2} = cy ;

%% Multivariate Gaussian sequence w/ Circulant Embedding Matrix

[Y2,W2,C2] = synth_circul_multivariate(N2,R2,1) ;

check_display_synth_bivariate_wPDFjoint(Y2,C2,100) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BIVARIATE IAAFT SURROGATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Bivariate IAAFT Surrogates

[Nmv,Nx] = size (Y2(1:2,:)) ;

clear ASk2 PhSk2 Ck2
for ii=1:Nmv
    ASk2(ii,:) = abs(fft(Y2(ii,:))) ;
    PhSk2(ii,:) = angle(fft(Y2(ii,:))) ;
    Ck2(ii,:) = sort(Y2(ii,:)) ;
end    


%% Series with non-Gaussian jiont-distribution

% Example:
% (Warning: for easiest display of figures, we use centred series and equal energy to Y)
% (attention pour comparaison simple: doit être centre et de meme energie que Y)
% X1 uniforme
% X2 triangular and X2 = X1 + U (U is uniform)

% WARNING: compatibility Esp{Ck1(t)*Ck2(t)} = C{1,2}(1) and so on

clear Ck_target2
    Ck_target2(1,:) = (rand(size(Y2(1,:)))) -0.5 ;
    Ck_target2(2,:) = 0.3*Ck_target2(1,:) + 0.3*( (rand(size(Y2(1,:)))) -0.5);
for ii=1:Nmv
    Ck_target2(ii,:) = Ck_target2(ii,:)*sqrt(sum(Y2(ii,:).^2)/sum(Ck_target2(ii,:).^2)) ;
end
% Check Covariance:
% mean(Ck_target2(1,:).*Ck_target2(2,:))-mean(Ck_target2(1,:))*mean(Ck_target2(2,:))

Nmaxiter=15000;


% Surrogate from Algorithm 1
[sk2_0,rk2_0,Niter2_0]=surrogate_iaaft_bivariate_synth(ASk2,PhSk2,Ck_target2,Nmaxiter);
Niter2_0

% Surrogate from Algorithm 2

[sk2,rk2,Niter2]=MV2surrogate_iaaft_transport_synth(ASk2,PhSk2,Ck_target2,5000) ;
Niter2

% [sk2,rk2,Niter2]=MV2surrogate_iaaft_transport_synth_vsignal(Y(1:2,:),30);

%%

figure(109) ; clf
% hist3(X(1:2,:)',[30 30])
[h2d binsX binsY hX hY] = joint_hist(Ck_target2(1,:)',Ck_target2(2,:)',30,30) ;
imagesc(h2d)
title('Target 2D histogram')
colormap(flipud(gray))
disp('*----- Target 2D histogram ------*')


check_display_synth_bivariate_wPDFjoint(sk2_0,C2,120)
disp('*----- Surrogate Signal sk0 without Optimal Transport of MultiD-Hist ------*')
%for ii=121:124; figure(ii); title('Classical IAAFT Surrogate'); end
%disp('in pause')
%pause

check_display_synth_bivariate_wPDFjoint(sk2,C2,130)
disp('*----- Surrogate Signal ------*')

figure(109)
disp('*----- Compare Target (fig 109) and Realized (fig 134 or 144) 2D-Histogram ------*')

disp(' in pause ')
pause

%% Display of Figures for Fig. 2 of ICASSP12 paper
% Some parameters for display

fs1 = 18;
fs2=12;
lw1=2;
Ndisp = 500;
printfig = 0;

%%  Time Series
figure(131);
subplot 211; 
% title('IAAFT Surrogate: covariance and marginal','FontSize',fs1) 
ylabel('x_1(n)','FontSize',fs1) 
axis([1 Ndisp -2 2])
set(gca,'FontSize',fs2)

subplot 212; 
ylabel('x_2(n)','FontSize',fs1) 
axis([1 Ndisp -2 2])
set(gca,'FontSize',fs2)

xlabel('n','FontSize',fs1) 

if printfig
   print -depsc fig2_icassp12_series.eps
end

%% Auto-Covariance

figure(132);

subplot 311; %title('IAAFT Surrogate: covariance and marginal','FontSize',fs1) 
ylabel('C_{11}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -20;
lesaxes(2) = 20;
lesaxes(3) = -0.3;
lesaxes(4) = 1.2;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)


subplot 312; 
ylabel('C_{22}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -20;
lesaxes(2) = 20;
lesaxes(3) = -0.3;
lesaxes(4) = 1.2;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)



subplot 313; 
ylabel('C_{12}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -20;
lesaxes(2) = 20;
lesaxes(3) = -0.3;
lesaxes(4) = 1.2;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)

xlabel('n','FontSize',fs1) 


if printfig
   print -depsc fig2_icassp12_cov.eps
end

%% Marginal Distributions
[hh1,bins1] = hist(sk2(1,:),100) ;
[hh2,bins2] = hist(sk2(2,:),100) ;


hh1 = hh1./sum(hh1)./(bins1(3)-bins1(2)) ;
hh2 = hh2./sum(hh2)./(bins2(3)-bins2(2)) ;

figure(133); clf
subplot 211; % title('Marginal Distributions','FontSize',fs1) 
set(bar(bins1,hh1),'FaceColor','w','BarWidth',1.0)
db1=bins1(3)-bins1(2) ;
Unif_Width = max(sk2(1,:))-min(sk2(1,:)) ;
Unif_Proba = 1/Unif_Width;
lesaxes= axis ;
lesaxes(1) = -2.25; lesaxes(2) = 2.25;
lesaxes(4) = 0.35;
axis(lesaxes)
hold on
plot([lesaxes(1) min(sk2(1,:))-db1],[0 0]+0.001,'r--','LineWidth',lw1)
plot([min(sk2(1,:)) max(sk2(1,:))],[1 1]*Unif_Proba,'r--','LineWidth',lw1)
plot([max(sk2(1,:))+db1 lesaxes(2)],[0 0]+0.001,'r--','LineWidth',lw1)
ylabel('p(x_1)','FontSize',fs1) 
set(gca,'FontSize',fs2)


subplot 212; 
set(bar(bins2,hh2),'FaceColor','w','BarWidth',1.0)
db2=bins2(3)-bins2(2) ;
Triangle_Width = max(sk2(2,:))-min(sk2(2,:)) ;
Triangle_Proba=2/Triangle_Width;
ylabel('p(x_2)','FontSize',fs1) 
lesaxes=axis;
lesaxes(4) = 0.5;
axis(lesaxes)
hold on
plot([lesaxes(1) min(sk2(2,:))],[0 0]+0.001,'r--','LineWidth',lw1)
plot([min(sk2(2,:)) 0],[0 1]*Triangle_Proba,'r--','LineWidth',lw1)
plot([0 max(sk2(2,:))],[1 0]*Triangle_Proba,'r--','LineWidth',lw1)
plot([max(sk2(2,:)) lesaxes(2)],[0 0]+0.001,'r--','LineWidth',lw1)
set(gca,'FontSize',fs2)

xlabel('x','FontSize',fs1) 


if printfig
   print -depsc fig2_icassp12_marginal.eps
end


%% Joint-Distribution: Target

figure(109) ; clf
% hist3(X(1:2,:)',[30 30])
[h2d binsX binsY hX hY] = joint_hist(Ck_target2(1,:)',Ck_target2(2,:)',30,30) ;
imagesc(binsX,binsY,h2d)
%title('Target 2D histogram')
colormap(flipud(gray))
lesaxes=axis;
lesaxes(1) = -2.25;
lesaxes(2) = 2.25;
lesaxes(3) = -3;
lesaxes(4) = 3;
axis(lesaxes)
xlabel('x_1','FontSize',fs1) 
ylabel('x_2','FontSize',fs1) 
title('Target P(x_1,x_2)','FontSize',fs1) 
colorbar
set(gca,'FontSize',fs2)

if printfig
   print -depsc fig2_icassp12_TargetPDF.eps
end

disp('*----- Target 2D histogram ------*')

%% Joint-Distribution: with Algo 1 (Covariance and Marginals)

figure(124) ; clf
% hist3(X(1:2,:)',[30 30])
[h2d binsX binsY hX hY] = joint_hist(sk2_0(1,:)',sk2_0(2,:)',30,30) ;
imagesc(binsX,binsY,h2d)
%title('Target 2D histogram')
colormap(flipud(gray))
lesaxes=axis;
lesaxes(1) = -2.25;
lesaxes(2) = 2.25;
lesaxes(3) = -3;
lesaxes(4) = 3;
axis(lesaxes)
xlabel('x_1','FontSize',fs1) 
ylabel('x_2','FontSize',fs1) 
title('Algorithm 1: P(x_1,x_2)','FontSize',fs1) 
colorbar
set(gca,'FontSize',fs2)

if printfig
   print -depsc fig2_icassp12_Algo1PDF.eps
end

disp('*----- Algo 1 - 2D-Histogram ------*')

%% Joint-Distribution: with Algo 2 (Covariance and Joint-Distribution)

figure(134) ; clf
% hist3(X(1:2,:)',[30 30])
[h2d binsX binsY hX hY] = joint_hist(sk2(1,:)',sk2(2,:)',30,30) ;
imagesc(binsX,binsY,h2d)
%title('Target 2D histogram')
colormap(flipud(gray))
lesaxes=axis;
lesaxes(1) = -2.25;
lesaxes(2) = 2.25;
lesaxes(3) = -3;
lesaxes(4) = 3;
axis(lesaxes)
xlabel('x_1','FontSize',fs1) 
ylabel('x_2','FontSize',fs1) 
title('Algorithm 2: P(x_1,x_2)','FontSize',fs1) 
colorbar
set(gca,'FontSize',fs2)

if printfig
   print -depsc fig2_icassp12_Algo2PDF.eps
end

disp('*----- Algo 2 - 2D-Histogram ------*')

%%

return

