% phasemodul_multivariate.m
%
%
% Multivariate surrogates 
% adapted from work  [Prichard, Theiler PRL 73-7 1994]
%
% Replaces the phase of different signals by a unique random one (uniform in [0 2*pi]).
%
% - input:  X    multivariate process (each process being a line)
%            [opt.] x2  second process, for compatibility with call of function:
%                   [z1,z2] = phasemodul(x1,x2,Nfft);
%            [opt] Nfft length of the FFT transform 
%                   (default:  Nfft=length(x))
%
% - output: Z   multivariate surrogate process (same amplitude in Fourier,
% random phase, Gaussian)
%
% Usage: Z = phasemodul_multivariate(X) ;
%
% Pierre Borgnat
% 08/2007, reprise 02/2008


function [Z,z2] = phasemodul_multivariate(X,x2,Nfft);


%% Put input arguments in proper form

[l,c]=size(X) ;
    
if l>c          % a priori: Number of variables (lines) < Number of samples (column)
    X = X.';    
    tmp=l ;l=c; c=tmp; 
end

if nargin>1     % for back-compatibility
   [l2,c2]=size(x2) ;
   if l~=1 
       x2 = x2.'; 
   end
   X(2,:) = x2 ;
   l=2;
end

if nargin<3
    Nfft = c ;
end

%% Random iid phase uniform in [0 2pi]

phase0 = rand(size(X(1,:))).*2.*pi;

%% Construct surrogate of each process

for ii=1:l
    z = phasemodul_monovariate(X(ii,:),phase0,Nfft) ;
    Z(ii,:)=z ;
end

return;

function z=phasemodul_monovariate(x,phase0,Nfft)

y = fft(x,Nfft);
A = zeros(size(y)) ; 
A(1:ceil(Nfft/2)) = abs(y(1:ceil(Nfft/2)));
phasex=angle(y);
z = real(ifft(2*A.*exp(1i.*(phasex+phase0))));

if size(z)~=size(x),
    z=z.';
end;

return;

    