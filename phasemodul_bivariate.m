% phasemodul_bivariate.m
%
%
% Multivariate surrogates (limited to bivariate case)
% adapted from work  [Prichard, Theiler PRL 73-7 1994]
%
% Replaces the phase of different signals by a unique random one (uniform in [0 2*pi]).
%
% - input:  x1, x2     signals
%           [opt] Nfft length of the FFT transform 
%              (default:  Nfft=length(x))
%
% - output: z   signal with the same amplitude of signal x but an random phase
%
% Usage: [z1,z2] = phasemodul_bivariate(x1,x2,Nfft);
%
% Pierre Borgnat
% 08/2007, reprise 02/2008


function [z1,z2] = phasemodul_bivariate(x1,x2,Nfft);
 
if nargin==2,
    Nfft=length(x1);
end;

phase0 = rand(size(x1)).*2.*pi;

z1 = phasemodul_monovariate(x1,phase0,Nfft) ;
z2 = phasemodul_monovariate(x2,phase0,Nfft) ;

return;

function z=phasemodul_monovariate(x,phase0,Nfft);

y = fft(x,Nfft);
A = zeros(size(y)) ; 
A(1:ceil(Nfft/2)) = abs(y(1:ceil(Nfft/2)));
phasex=angle(y);
z = real(ifft(2*A.*exp(i.*(phasex+phase0))));

if size(z)~=size(x),
    z=z.';
end;

return;

    