% Bivariate Synthesis of Non Gaussian Process with Surrogates
% VERSION THAT TAKES A SIGNAL AS INPUT
%
% Combination of two works on surrogates:
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
%
% [sk,rk,Niter]=surrogate_iaaft_bivariate_synth_vsignal(X,Nmaxiter);
%
% input:    X    original bivariate signal
%           (opt) Nmaxiter  max. number of iteration (default=5000)
%
% output:   sk      output surrogate with correct amplitude of Fourier coefficient
%           rk      output surrogate with correct marginal distribution
%           Niter   number of iteration for convergence
%
% pborgnat 01/2007; new version 02/2008
%

function [sk,rk,Niter]=surrogate_iaaft_bivariate_synth(X,Nmaxiter) ;


[Nmv,Nx]=size(X);       % Nmv = number of variables (should be 2!)
                        % Nx = length of signals
                        
for ii=1:Nmv
    ASk(ii,:) = abs(fft(X(ii,:))) ;
    PhSk(ii,:) = angle(fft(X(ii,:))) ;
    Ck(ii,:) = sort(X(ii,:)) ;
end    
                       
if nargin<2
    Nmaxiter=5000;
end;

% %% Originally in surrogate_iaaft
%
%[ck,ind]=sort(x);                     % rank ordering of x (data sorted in ascending order)
%[blah,indinv]=sort(ind);              % inversion of the permutation
%
%ASk=abs(fft(x));
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

jj=0;
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
        [blah,indsk]=sort(sk(ii,:));
        [blah,indskinv]=sort(indsk);                 
        rk(ii,:)=Ck(ii,indskinv);                          % rank ordered data with correct pdf
%    norm(rk-sk) ;
        if indskinv==indskinvold(ii,:) 
            cvg(ii)=1;
        else
            indskinvold(ii,:)=indskinv;                % Convergence si on reclasse tjs de la meme maniere 
            cvg(ii)=0;
        end
    end
    
    if sum(cvg)==Nmv
        nocvg=0 ;
    end
    if jj>=Nmaxiter
        nocvg=0;
    end
    jj=jj+1 ;
end

Niter=jj;

return
