% Bivariate Synthesis of Non Gaussian Process with Surrogates
% VERSION THAT TAKES A SIGNAL AS INPUT
%
% Combination of two works on surrogates + Histogram matching with Sliced Wasserstein Gradient
%
% - IAAFT: Iterative Amplitude Adjusted Fourier Transform surrogate
% [Schreiber & Schmitz, Physica D 2000]
% Used for synthesis of process with prescribed marginal distribitions and
% covariances
%
% - Bivariate surrogates
% following work of work of [Prichard, Theiler PRL 73-7 1994] 
% Put inside the loop of the IAAFT algorithm
%
% - Multi-D Histogram Matching using Sliced Wasserstein Gradient
% [Rabin, Peyre, Delon, Bernot, preprint 2010]
%
%
% [sk,rk,Niter]=MV2surrogate_iaaft_transport_synth_vsignal(X,Nmaxiter,Nmaxiter2) ;
%
% input:    X    original bivariate signal
%           (opt) Nmaxiter   max. number of iteration IAAFT (default=5000)
%           (opt) Nmaxiter2  max. number of iteration Sliced Wasserstein Gradient (default=1000)
%
% output:   sk      output surrogate with correct amplitude of Fourier coefficient
%           rk      output surrogate with correct marginal distribution
%           Niter   number of iteration for convergence
%
% pborgnat 09/2011
%

function [sk,rk,Niter]=MV2surrogate_iaaft_transport_synth_vsignal(X,Nmaxiter,Nmaxiter2) ;


[Nmv,Nx]=size(X);       % Nmv = number of variables (should be 2!)
                        % Nx = length of signals
                        
for ii=1:Nmv
    ASk(ii,:) = abs(fft(X(ii,:))) ;
    PhSk(ii,:) = angle(fft(X(ii,:))) ;
%    Ck(ii,:) = sort(X(ii,:)) ;
    Ck(ii,:)  = X(ii,:) ;   % DO NOT RE-ORDER THE POINTS SEPARATELY !!!
end    
                       
if nargin<2
    Nmaxiter=5000;
end;

if nargin<3
    Nmaxiter2=1000;
end;

%  Convergence Criterium for Sliced Wasserstein Gradient
DiffCv = 1e-4 ;  % eps
NormCv = 0.01 ;
tau = 0.2 ;                     % pas fixe car marche en pratique


% %% Originally in surrogate_iaaft: 1D optimal transport of histogram
%
%[ck,ind]=sort(x);                     % rank ordering of x (data sorted in ascending order)
%[blah,indinv]=sort(ind);              % inversion of the permutation
%
% %%%

% %% Initialization

indshuffle=randperm(Nx)';
indskinvold=zeros(Nmv,Nx);

if isempty(PhSk)
    for ii=1:Nmv
        rk(ii,:)=Ck(ii,indshuffle);                      % random shuffle of data (initialization)
        indskinvold(ii,:)=indshuffle;
    end
else
%    for ii=1:Nmv
%        X(ii,:) = real(ifft(ASk(ii,:).*exp(1i*PhSk(ii,:)))) ;
%    end
    [z1,z2] = phasemodul_bivariate(X(1,:),X(2,:));
    rk = [z1 ; z2] ;
%    indskinvold(ii,:)=indshuffle;
end;


% %% Loop to correct amplitude & marginal

jj=1;
cvg=zeros(1,Nmv);
nocvg=1;

%while ~(prod(cvg))
while nocvg
disprog(jj,Nmaxiter,20)
    for ii=1:Nmv
%    Rk1 = fft(rk);
%    psik=angle(Rk1);
        psik=angle(fft(rk(ii,:)));
%    norm(abs(Rk1)-abs(Sk))
        sk(ii,:) = real(ifft(ASk(ii,:).*exp(1i.*psik)));       % data with correct amplitude
%    [sksorted,indsk]=sort(sk);

% Following part remplaced by MultiD optimal assignement (hence, outside loop from 1 to Nmv
%        [blah,indsk]=sort(sk(ii,:));
%        [blah,indskinv]=sort(indsk);                 
%        rk(ii,:)=Ck(ii,indskinv);                          % rank ordered data with correct pdf
     
    end
    
% Inner Loop: Sliced Wasserstein Gradient
    % initialisation
    nocvg1 = 1;
    mm=0;
    x1new=sk;    
    while nocvg1
        % disprog(mm,Nmaxiter2,20);
        % Vecteur 2D aleatoire
        [Urand,Rrand] = qr(randn(Nmv)) ;    % Urand is the unitary projection matrix
        % Projection sur ce vecteur
        x0U = Urand*Ck ;
        x1U = Urand*x1new ;
        % Egalisation des histogrammes
        for ii=1:size(sk,1)
            x1U(ii,:) = perform_hist_eq(x1U(ii,:),x0U(ii,:)) ;
        end
        % Critere de convergence sur la difference de deplacement
        if mean(sum((tau*(Urand'*x1U-x1new)).^2,1))< DiffCv
            nocvg1=0;
        end
        % Une iteration du gradient
        x1new = (1-tau)*x1new + tau*Urand'*x1U;
        % Critere de convergence sur distance a la cible
        if mean(sum((x1new-Ck).^2,1))< NormCv
            nocvg1=0;
        end
        mm=mm+1 ;
        if mm==Nmaxiter2
            nocvg1=0;
        end
    end
% End of Inner Loop: Sliced Wasserstein Gradient
    rk = x1new ;
        
% TODO: Convergence Criteria for the permutation 
%    norm(rk-sk) ;
%         if indskinv==indskinvold(ii,:) 
%             cvg(ii)=1;
%         else
%             indskinvold(ii,:)=indskinv;                % Convergence si on reclasse tjs de la meme maniere 
%             cvg(ii)=0;
%         end
    
    if sum(cvg)==Nmv
        nocvg=0 ;
    end
    if jj>=Nmaxiter
        nocvg=0;
    end
    jj=jj+1 ;
%    disp(' ') ;
end

Niter=jj;

return
