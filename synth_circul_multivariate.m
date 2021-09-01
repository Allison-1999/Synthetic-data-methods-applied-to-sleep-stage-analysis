function  [X,W,C,Xbis] = synth_circul_multivariate(Nx,C,opt) 

% function [xx,w,C] = synth_circul_multivariate(Nx,C) ;
% Synthesis of Multivariate Gaussian process with circulant matrix method
% [Wood & Chan 1994] ; [Chan & Wood, 1999]
%
% Inputs:
%          C    multivariate covariance function 
%               following the form for Bivariate: 
%                   C{1,1} = Cx ; C{2,2} = Cy ;  C{1,2} = Cxy ; 
%          Nx    number of samples
%          opt  placeholder for options
%               'exp2': then bivariate and C=[ax ay axy sxy] for model with exponential decay 
%
% Outputs:
%          X    output multivariate signal
%               Bivariate: X(1,:) = x ; X(2,:) = y ;
%          W2   colored gaussian noise generator (Fourier domain, complex)
%          C    covariance function (useful for pre-defined examples)
%          Xbis second independent multivariate realization

%%%%%
% pb 09/2009; repris 09/2011

%% Define Target Covariance

nn = 0:Nx-1 ;

% Default behaviour: exponential
if nargin == 1
    ax = 0.5 ;
    ay = 1 ;
    axy = 2 ;
    sxy = 0.2 ;
end

if nargin<3
    opt='none';
end 

% Pre-defined examples
if strcmp(opt,'exp')
    ax = C(1) ;
    ay = C(2) ;
    axy = C(3) ;
    sxy = C(4) ;
    clear C
end

if (nargin==1) | strcmp(opt,'exp')
    cx = exp(-ax*nn) ; 
    cy = exp(-ay*nn) ; 
    cxy = sxy * exp(-axy*nn) ; 
    
    C{1,1} = cx;
    C{1,2} = cxy;
    C{2,2} = cy ;
end

if strcmp(opt,'zero')
    sxy = C(1) ;
    clear C
    cx = zeros(1,Nx);    cx(1) = 1;
    cy = zeros(1,Nx);    cy(1) = 1;
    cxy = zeros(1,Nx);   cxy(1) = sxy;
    C{1,1} = cx;
    C{1,2} = cxy;
    C{2,2} = cy ;
end

if strcmp(opt,'test3')
%    sxy = C(1) ;
    clear C
    
    ax=0.5; ay=1; az=0.1 ;
    sxy = 0.7; axy = 1;
    sxz = 0.0 ; axz = 1.5;
    syz = 0.0 ; ayz = 1.2;
    cx = exp(-ax*nn) ; 
    cy = exp(-ay*nn) ; 
    cz = exp(-az*nn) ; 
    cxy = sxy * exp(-axy*nn) ; 
%    cxz = zeros(1,Nx);   cxz(1) = sxz;
    cxz = sxz * exp(-axz*nn) ; 
%    cyz = zeros(1,Nx);   cyz(1) = syz;
    cyz = syz * exp(-ayz*nn) ; 
    C{1,1} = cx;
    C{1,2} = cxy;
    C{2,2} = cy ;
    
    C{1,1} = cx;
    C{2,2} = cy ;
    C{3,3} = cz ;
    C{1,2} = cxy;
    C{1,3} = cxz;
    C{2,3} = cyz;
end


Nmv = length(C) ;   % Number or variables
N=length(C{1,1}) ;  % Length of Correlation sequences (WARNING: should all be equal)


% Nota Bene: we assume that all covariance are line vectors
%else: correct all cells as follow [TO DO]
% [nl,nc] = size(c) ;
% if nl~=1,
%        c = c.';
% end        
    
%% Embedding into circulant matrix

Rz = cell(Nmv,Nmv); 

for ii=1:Nmv
    for jj=ii:Nmv        
        rxy = C{ii,jj} ;
        ryx = C{jj,ii} ;
        if isempty(ryx)
            ryx=rxy;
        end
        if isempty(rxy)
            rxy=ryx;
        end
        Rz{ii,jj} = [rxy(1:N-1), fliplr(ryx(2:N))] ;
    end
end

Nemb = length(Rz{1,1});


%% Fourier Tranform of rz

L = cell(Nmv,Nmv); 

for ii=1:Nmv
  for jj=ii:Nmv
    L{ii,jj} = fft(Rz{ii,jj});
  end
end


%%  Square Root Matrix

Lsqrt = zeros(Nmv,Nemb);
Sxy = cell(Nmv,Nmv);

for ii=1:Nmv,
	Lsqrt(ii,:) = sqrt(real(L{ii,ii}));     
    if min(Lsqrt(ii,:))<0
        warning(['L is not truly positive for Variable ' num2str(ii)]) ;           
        Lsqrt(ii,:) = max(Lsqrt(ii,:),0) ;
    end 
end

% Cross-spectrum
for ii=1:Nmv
  for jj=ii+1:Nmv
    SxSysqrt = Lsqrt(ii,:).*Lsqrt(jj,:) ; 
    index = find(SxSysqrt) ;
    Sxy{ii,jj}=zeros(size( L{ii,jj} )) ;
    Sxy{ii,jj}(index) = L{ii,jj}(index)./SxSysqrt(index) ;
  end
end

%% White Noise Generation (in Fourier domain)

W2=zeros(Nmv,Nemb) ;

% Generation of Colored Noise by pxp block
for n=1:Nemb,
    % Factorization of each pxp block matrix
    Cp =eye(Nmv);
    for ii=1:Nmv
        for jj=ii+1:Nmv
            Cp(ii,jj) = Sxy{ii,jj}(n);
            Cp(jj,ii) = conj(Sxy{ii,jj}(n)) ;
        end
    end
    Ap = chol(Cp,'lower');
    % White Noise Generation (in Fourier domain)
    W = randn(Nmv,1) + 1i.*randn(Nmv,1);
    % Colored Noise w/ Cross-Spectrum
    W2(:,n) = Ap*W;
end; 


%% Colored Noise w/ Marginal Spectrum

W2 = Lsqrt .* W2 / sqrt(Nemb) ;


%% Invert Fourier Transform

Z = fft(W2,[],2) ;

X = real(Z(:,1:Nx)) ;

% Note: Astuce from PA/HH/VP work
Xbis = imag(Z(:,1:Nx)) ;


%%
return

%% initially from fbmcircul
% B = cumsum(x) ;

%% Graphical test
% figure
% plot(r); axis([-100 100 0 1]);
%
% [cx_est,lags] = xcorr(xx,'coeff') ;
%
% hold on
% plot(lags,cx_est,'r')


