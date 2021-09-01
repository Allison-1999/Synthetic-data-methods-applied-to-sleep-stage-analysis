% test_synth_MVsurrogate_transport
% 
% (using codes of Surrogates + codes from Patrice and Hannes)
%
% pb 09/2011

% addpath(genpath('/Users/pborgnat/Arborescence/Matlab/STATIONARITY/Surrogate/'))
% addpath(genpath('/Users/pborgnat/Arborescence/Matlab/SIGNAUX/Synth_with_Surrogates/'))
% addpath(genpath('/Users/pborgnat/Arborescence/Matlab/TOOLBOXES_Second/MVnGSynthesis/'))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prepare some orginal multivariate processes (with circulant embedding)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 2^10; 

%% Possible model
R=cell(2,2) ;
    ax = 0.5 ;
    ay = 1 ;
    axy = 0.7 ;
    sxy = 0.5 ;
    nn=0:N-1;
    cx = exp(-ax*nn) ; 
    cy = exp(-ay*nn) ; 
    cxy = sxy * exp(-axy*nn) ; 
    
    R{1,1} = cx;
    R{1,2} = cxy;
    R{2,2} = cy ;

%% Multivariate sequence w/ PB code

[Y,W,C,Ybis] = synth_circul_multivariate(N,R,1) ;

check_display_synth_bivariate_wPDFjoint(Y,C) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIMPLE MULTIVARIATE GAUSSIAN SURROGATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Bivariate Simple Surrogates
% 
% [Ys1,Ys2] = phasemodul_bivariate(Y(1,:),Y(2,:)) ;
% 
% check_display_synth_bivariate([Ys1;Ys2],C)
%
%% Multivariate Simple Surrogate
%
% [Ys] = phasemodul_multivariate(Y) ;
%
% check_display_synth_trivariate(Ys,C)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BIVARIATE IAAFT SURROGATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Bivariate IAAFT Surrogates

[Nmv,Nx] = size (Y(1:2,:)) ;

clear ASk PhSk Ck
for ii=1:Nmv
    ASk(ii,:) = abs(fft(Y(ii,:))) ;
    PhSk(ii,:) = angle(fft(Y(ii,:))) ;
    Ck(ii,:) = sort(Y(ii,:)) ;
end    


%%
% Processus a marginal non gaussienne

% Exemple distribution uniforme 
% (attention pour comparaison simple: doit être centre et de meme energie que Y)
% X1 uniforme
% X2 en triangle

% ATTENTION: Cond. necessaire de realisabilite Esp{Ck1(t)*Ck2(t)} = C{1,2}(1)

clear Ck_target
    Ck_target(1,:) = (rand(size(Y(1,:)))) -0.5 ;
    Ck_target(2,:) = 0.2*Ck_target(1,:) + 0.3*( (rand(size(Y(1,:)))) -0.5);
for ii=1:Nmv
    Ck_target(ii,:) = Ck_target(ii,:)*sqrt(sum(Y(ii,:).^2)/sum(Ck_target(ii,:).^2)) ;
end  
mean(Ck_target(1,:).*Ck_target(2,:))-mean(Ck_target(1,:))*mean(Ck_target(2,:))

figure(9) ; clf
% hist3(X(1:2,:)',[30 30])
[h2d binsX binsY hX hY] = joint_hist(Ck_target(1,:)',Ck_target(2,:)',30,30) ;
imagesc(h2d)
title('Target 2D histogram')
disp('*----- Target 2D histogram ------*')


Nmaxiter=15000;

[sk0,rk0,Niter]=surrogate_iaaft_bivariate_synth(ASk,PhSk,Ck_target,Nmaxiter);
Niter

% [sk,rk,Niter]=MV2surrogate_iaaft_transport_synth_vsignal(Y(1:2,:),30);

[sk,rk,Niter]=MV2surrogate_iaaft_transport_synth(ASk,PhSk,Ck_target,5000) ;
Niter

%%

check_display_synth_bivariate_wPDFjoint(Y(1:2,:),C,10)
disp('*----- Initial Gaussian Signal ------*')
for ii=11:14; figure(ii); title('Initial Gaussian Signal'); end
disp('in pause')
pause
check_display_synth_bivariate_wPDFjoint(sk0,C,20)
disp('*----- Surrogate Signal sk0 without Optimal Transport of MultiD-Hist ------*')
for ii=21:24; figure(ii); title('Classical IAAFT Surrogate'); end
disp('in pause')
pause
check_display_synth_bivariate_wPDFjoint(sk,C,30)
disp('*----- Surrogate Signal sk ------*')
for ii=31:34; figure(ii); title('IAAFT+Transport Surrogate sk'); end
disp('in pause')
pause
check_display_synth_bivariate_wPDFjoint(rk,C,40)
disp('*----- Surrogate Signal rk ------*')
for ii=41:44; figure(ii); title('IAAFT+Transport Surrogate rk'); end

figure(9)
disp('*----- Compare Target (fig 9) and Realized (fig 34 or 44) 2D-Histogram ------*')


%%

break


