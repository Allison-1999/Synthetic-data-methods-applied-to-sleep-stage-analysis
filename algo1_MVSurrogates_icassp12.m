% ALGORITHM 1 AND FIGURE 1 for submitted ICASSP 12 PAPER: 
% Multivariate Surrogates 
%
% Example with prescribed covariance and marginal distributions
% 
% Using codes of Surrogates 
% ALGORITHM 1 of the paper
%
% Pierre Borgnat, Patrice Abry, Patrick Flandrin, 09/2011



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prepare some orginal multivariate processes (with circulant embedding)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 2^15; 

% set parameters for the MAR(1) model
Phi = [[0.8 1 0.0] ; [0 0.2 0] ; [0.2 1  0.5]];
Sigmae = eye(3);

% Generate Trivariate Covariance Structure
Ncov = N+1; % cov. could be asymmetric, get cov. seq. of length N+1
R = CovarMAR1(Ncov,Phi,Sigmae);


%% Multivariate Gaussian sequence w/ Circulant Embedding Matrix

[Y,W,C,Ybis] = synth_circul_multivariate(N,R,1) ;

check_display_synth_trivariate_wPDF(Y,C,0) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIMPLE MULTIVARIATE GAUSSIAN SURROGATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Multivariate Simple Surrogate / Algorithm 0
%
% [Ys] = phasemodul_multivariate(Y) ; 
%
% check_display_synth_trivariate_wPDF(Ys,C)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MULTIVARIATE IAAFT SURROGATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Trivariate IAAFT Surrogates

[Nmv,Nx] = size (Y(1:3,:)) ;

clear ASk PhSk Ck
for ii=1:Nmv
    ASk(ii,:) = abs(fft(Y(ii,:))) ;
    PhSk(ii,:) = angle(fft(Y(ii,:))) ;
    Ck(ii,:) = sort(Y(ii,:)) ;
end    


%% Series with non-Gaussian marginal

% Example:
% (Warning: for easiest display of figures, we use centred series and equal energy to Y)
% X1 uniforme
% X2 triangular
% X3 gamma law
%
% WARNING: compatibility Esp{Ck1(t)*Ck2(t)} = C{1,2}(1) and so on

clear Ck_target
    Ck_target(1,:) = (rand(size(Y(1,:)))) -0.5 ;
    Ck_target(2,:) = 0.3*Ck_target(1,:) + 0.3*( (rand(size(Y(1,:)))) -0.5);
for ii=1:2
    Ck_target(ii,:) = Ck_target(ii,:)*sqrt(sum(Y(ii,:).^2)/sum(Ck_target(ii,:).^2)) ;
end
% Check variance:
% mean(Ck_target(1,:).*Ck_target(2,:))-mean(Ck_target(1,:))*mean(Ck_target(2,:))
%    Ck_target(3,:) = Ck(3,:) ;
     alpha_3  = 2.2 ; beta_3 = sqrt(C{3,3}(1)/alpha_3) ;
     Ck_target(3,:) = gamrnd(alpha_3,beta_3,1,N) ;

Nmaxiter=15000;

[sk,rk,Niter]=surrogate_iaaft_multivariate_synth(ASk,PhSk,Ck_target,Nmaxiter);
Niter

% [sk,rk,Niter]=MV2surrogate_iaaft_transport_synth_vsignal(Y,100);


%% Display Figure 1 of the paper

check_display_synth_trivariate_wPDF(sk,C,20)
disp('*----- Algorithm 1: Surrogate Signal sk0 (without Optimal Transport of MultiD-Hist) 3 components) ------*')


%% Nicer Axis and Titles for Fig. 1 of ICASSP12 paper
% Some parameters for display

fs1 = 18;
fs2=12;
lw1=2;
Ndisp = 500;
printfig = 0;

%%  Time Series
figure(21);
subplot 311; 
% title('IAAFT Surrogate: covariance and marginal','FontSize',fs1) 
ylabel('x_1(n)','FontSize',fs1) 
axis([1 Ndisp -5 5])
set(gca,'FontSize',fs2)

subplot 312; 
ylabel('x_2(n)','FontSize',fs1) 
axis([1 Ndisp -3 3])
set(gca,'FontSize',fs2)

subplot 313; 
ylabel('x_3(n)','FontSize',fs1) 
axis([1 Ndisp -3.5 12])
set(gca,'FontSize',fs2)
xlabel('n','FontSize',fs1) 

if printfig
   print -depsc fig1_icassp12_series.eps
end

%% Marginal Distributions
[hh1,bins1] = hist(sk(1,:),100) ;
[hh2,bins2] = hist(sk(2,:),100) ;
[hh3,bins3] = hist(sk(3,:),100) ;


hh1 = hh1./sum(hh1)./(bins1(3)-bins1(2)) ;
hh2 = hh2./sum(hh2)./(bins2(3)-bins2(2)) ;
hh3 = hh3./sum(hh3)./(bins3(3)-bins3(2)) ;


figure(24);
subplot 311; title('Marginal Distributions','FontSize',fs1) 
set(bar(bins1,hh1),'FaceColor','w','BarWidth',1.0)
db1=bins1(3)-bins1(2) ;
Unif_Width = max(sk(1,:))-min(sk(1,:)) ;
Unif_Proba = 1/Unif_Width;
lesaxes= axis ;
lesaxes(1) = -6; lesaxes(2) = 6;
lesaxes(4) = 0.15;
axis(lesaxes)
hold on
plot([lesaxes(1) min(sk(1,:))-db1],[0 0]+0.001,'r--','LineWidth',lw1)
plot([min(sk(1,:)) max(sk(1,:))],[1 1]*Unif_Proba,'r--','LineWidth',lw1)
plot([max(sk(1,:))+db1 lesaxes(2)],[0 0]+0.001,'r--','LineWidth',lw1)
ylabel('p(x_1)','FontSize',fs1) 
set(gca,'FontSize',fs2)


subplot 312; 
set(bar(bins2,hh2),'FaceColor','w','BarWidth',1.0)
db2=bins2(3)-bins2(2) ;
Triangle_Width = max(sk(2,:))-min(sk(2,:)) ;
Triangle_Proba=2/Triangle_Width;
ylabel('p(x_2)','FontSize',fs1) 
lesaxes=axis;
lesaxes(4) = 0.5;
axis(lesaxes)
hold on
plot([lesaxes(1) min(sk(2,:))],[0 0]+0.001,'r--','LineWidth',lw1)
plot([min(sk(2,:)) 0],[0 1]*Triangle_Proba,'r--','LineWidth',lw1)
plot([0 max(sk(2,:))],[1 0]*Triangle_Proba,'r--','LineWidth',lw1)
plot([max(sk(2,:)) lesaxes(2)],[0 0]+0.001,'r--','LineWidth',lw1)
set(gca,'FontSize',fs2)


subplot 313; 
bb3 = bins3+alpha_3*beta_3 ;
gam_pdf3 = gampdf(bb3,alpha_3,beta_3) ;
set(bar(bins3+alpha_3*beta_3,hh3),'FaceColor','w','BarWidth',1.0);
ylabel('p(x_3)','FontSize',fs1) 
lesaxes=axis;
lesaxes(2) = 18; lesaxes(4) = 0.25;
axis(lesaxes)
hold on
plot(bb3,gam_pdf3,'r--','LineWidth',lw1)
set(gca,'FontSize',fs2)
xlabel('x','FontSize',fs1) 


if printfig
   print -depsc fig1_icassp12_marginal.eps
end

%% Auto-Covariance

figure(22);

subplot 311; %title('IAAFT Surrogate: covariance and marginal','FontSize',fs1) 
ylabel('C_{11}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -40;
lesaxes(2) = 40;
lesaxes(3) = -1;
lesaxes(4) = 7.5;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)


subplot 312; 
ylabel('C_{22}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -40;
lesaxes(2) = 40;
lesaxes(3) = -0.3;
lesaxes(4) = 1.2;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)



subplot 313; 
ylabel('C_{33}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -40;
lesaxes(2) = 40;
lesaxes(3) = -1;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)
xlabel('n','FontSize',fs1) 


if printfig
   print -depsc fig1_icassp12_autocov.eps
end

%% Cross-Covariance

figure(23);

subplot 311; %title('IAAFT Surrogate: covariance and marginal','FontSize',fs1) 
ylabel('C_{12}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -40;
lesaxes(2) = 40;
lesaxes(3) = -0.5;
lesaxes(4) = 1.5;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)


subplot 312; 
ylabel('C_{13}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -40;
lesaxes(2) = 40;
lesaxes(3) = -1;
lesaxes(4) = 5;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)


subplot 313; 
ylabel('C_{23}(n)','FontSize',fs1) 
lesaxes=axis;
lesaxes(1) = -40;
lesaxes(2) = 40;
lesaxes(3) = -0.5;
lesaxes(4) = 1.5;
axis(lesaxes)
grid on
set(gca,'FontSize',fs2)
xlabel('n','FontSize',fs1) 


if printfig
   print -depsc fig1_icassp12_crosscov.eps
end

%%

return



