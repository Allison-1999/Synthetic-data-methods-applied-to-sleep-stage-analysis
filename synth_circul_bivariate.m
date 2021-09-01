function [X,W2,C,Xbis] = synth_circul_bivariate(Nx,C,opt) 

% function [xx,w,C] = synth_circul_bivariate(Nx,C) ;
% Synthesis of Bivariate Gaussian process with circulant matrix method
% [Wood & Chan 1994] ; [Chan & Wood, 1999]
%
% Inputs:
%          Nx   number of desired samples
%          C    bivariate covariance function 
%               Bivariate: C{1,1} = Cx ; C{2,2} = Cy ;  C{1,2} = Cxy ;
%          opt  placeholder for options
%               'exp': then C=[ax ay axy sxy] for model with exponential decay 
%
% Outputs:
%          X    output multivariate signal
%               Bivariate: X(1,:) = x ; X(2,:) = y ;
%          W2   colored gaussian noise generator (Fourier domain, complex)
%          C    covariance function (useful for pre-defined examples)
%          Xbis second independent multivariate realization


%%%%%
% pb 09/2009

%% Define Target Covariance

nn = 0:Nx-1 ;

% Default behaviour: exponential
if nargin == 1
    ax = 0.5 ;
    ay = 1 ;
    axy = 2 ;
    sxy = 0.2 ;
end

if nargin<3,
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

Nmv = length(C) ;  % should be 2 !!!
N=length(C{1,1}) ; % Length of Correlation sequences (WARNING: should all be equal)


% Nota Bene: we assume that all covariance are line vectors
%else: correct all cells as follow [TO DO]
% [nl,nc] = size(c) ;
% if nl~=1,
%        c = c.';
% end        
    
%% Embedding into circulant matrix

Rz = cell(2,2); 

for ii=1:2
    for jj=ii:2        
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

L = cell(2,2); 

for ii=1:2
  for jj=ii:2
    L{ii,jj} = fft(Rz{ii,jj});
  end
end


%%  Square Root Matrix

Lxsqrt=sqrt(real(L{1,1})) ;
Lysqrt=sqrt(real(L{2,2})) ;

if min(Lxsqrt)<0
    warning('Lx is not truly positive') ;           
    Lxsqrt = max(Lxsqrt,0) ;
end
if min(Lysqrt)<0
    warning('Ly is not truly positive') ;           
    Lysqrt = max(Lxsqrt,0) ;
end

% Cross-spectrum
SxSysqrt = Lxsqrt.*Lysqrt ;
index = find(SxSysqrt) ;
Sxy=zeros(size( L{1,2} )) ;
Sxy(index) = L{1,2}(index)./SxSysqrt(index) ; 

    
%% White Noise Generation (in Fourier domain)

W2=zeros(2,Nemb) ;

% Generation of Colored Noise by 2x2 block
for n=1:Nemb,
    % Factorization of each 2x2 block matrix
    Cp = [[1 Sxy(n)]; [Sxy(n)' 1]] ;
    Ap = chol(Cp,'lower');
    % White Noise Generation (in Fourier domain)
    W = randn(2,1) + 1i.*randn(2,1);
    % Colored Noise w/ Cross-Spectrum
    W2(:,n) = Ap*W;
end;    
        
%% Colored Noise w/ Marginal Spectrum

W2(1,:) = Lxsqrt.*W2(1,:) / sqrt(Nemb) ;
W2(2,:) = Lysqrt.*W2(2,:) / sqrt(Nemb) ;


%% Invert Fourier Transform

Z = fft(W2,[],2) ;

xx = real(Z(1,1:Nx)) ;
yy = real(Z(2,1:Nx)) ;

X(1,:) = xx ;
X(2,:) = yy ;

% Note: Astuce from PA/HH/VP work
Xbis(1,:) = imag(Z(1,1:Nx)) ;
Xbis(2,:) = imag(Z(2,1:Nx)) ;



%%
return



%% Graphical display to check result

figure
subplot 211
plot(X(1,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);
subplot 212
plot(X(2,:)); 
lesaxes=axis ; lesaxes(2) = Nx ; axis(lesaxes);

[cx_est,lags] = xcorr(X(1,:)) ;
[cy_est,lags] = xcorr(X(2,:)) ;
[cxy_est,lags] = xcorr(X(1,:),X(2,:)) ;


cx = C{1,1};
cy = C{2,2};
cxy = C{1,2};
cyx = C{2,1};
if length(cyx)==0, cyx=cxy; end

Nc=length(cx);

figure
subplot 311
plot([-(Nc-1):(Nc-1)], [fliplr(cx(2:Nc)) cx]); 
hold on
plot(lags,cx_est/Nx,'r')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);

subplot 312
plot([-(Nc-1):(Nc-1)], [fliplr(cy(2:Nc)) cy]); 
hold on
plot(lags,cy_est/Nx,'r')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);

subplot 313
plot([-(Nc-1):(Nc-1)], [fliplr(cxy(2:Nc)) cyx]); 
hold on
plot(lags,cxy_est/Nx,'r')
lesaxes=axis; lesaxes(1)=-200; lesaxes(2)=200; axis(lesaxes);
% axis([-200 200 -0.3 1]);


