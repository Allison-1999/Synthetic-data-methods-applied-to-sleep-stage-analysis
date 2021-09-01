% Bivariate Synthesis of Non Gaussian Process with Surrogates
% VERSION THAT TAKES TARGETS (ASk, PhSk, Ck) AS INPUT
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
% [sk,rk,Niter]=surrogate_iaaft_bivariate_synth(ASk,PhSk,Ck,Nmaxiter);
%
% input:    ASk   values of amplitude of Fourier coefficient of original signal
%           PhSk  values of phase of Fourier coefficient of original signal
%               (if isempty(PhSk), surrogates will not keep interspectrum)
%           Ck    values of original signal
%           (opt) Nmaxiter  max. number of iteration (default=5000)
%
% output:   sk      output surrogate with correct amplitude of Fourier coefficient
%           rk      output surrogate with correct marginal distribution
%           Niter   number of iteration for convergence
%
% pborgnat 01/2007; new version 02/2008
%

function [sk,rk,Niter]=surrogate_iaaft_bivariate_synth(ASk,PhSk,Ck,Nmaxiter) ;


[Nmv,Nx]=size(Ck);      % Nmv = number of variables (should be 2!)
                        % Nx = length of signals

if prod(size(ASk))~=(Nmv*Nx) 
    error('Ck and ASk should be of same size');
end

if nargin<3
    Nmaxiter=5000;
end;

for ii=1:Nmv
    Ck(ii,:) = sort(Ck(ii,:)) ;
end 

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
    for ii=1:Nmv
        X(ii,:) = real(ifft(ASk(ii,:).*exp(1i*PhSk(ii,:)))) ;
    end

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
