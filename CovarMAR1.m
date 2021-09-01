function R = CovarMAR1(N,Phi,Sigmae)
% Covariance generation for multivariate AR(1) series
%
% Usage:
%   R = CovarMAR1(N,Phi,Sigmae)
% Inputs:
%   N      length of the covariance sequence
%   Phi    matrix of size P-by-P, see "Comments" below
%   Sigmae matrix of size P-by-P, see "Comments" below
% Output
%   R     generated covariance structure
%
% Comments:
%   P-variate AR(1) series are defined by
%     X(n) = [X1(n) ... XP(n)]^T = Phi*X(n-1) + e(n)
%   where e(n) are i.i.d. Gaussian with mean zero and
%   covariance matrix E e(n)e(n)^T = Sigmae
%   
%   Stability condition for the series: all eigenvalues of Phi should
%   have modulus < 1.
%
% Copyright 2009, Hannes Helgason

% Check stability condition
evPhi = eig(Phi);
tmp = max(abs(evPhi));
if tmp>=1,
    error(sprintf('All eigenvalues of Phi should have modulus < 1\nMaximum modulus of eigenvalues is %0.4f',tmp));
end

% the dimension
P = size(Phi,1);

% initialize output variables
RR = zeros(P,P,N);
%r1 = zeros(1,N);
%r2 = zeros(1,N);
%r12 = zeros(1,N);
%r21 = zeros(1,N);


% Letting R(h)=EX(0)X(h)^T, one has (see Lutkepohl "New Introduction to
% Multiple Time Series Analysis", p. 27)
%   vec(R(0)) = inv(eye(4)-kron(Phi,Phi))*vec(Sigma0)
% where "kron(A,B)" is the Kronecker tensor product of A and B, also
% vec([r11 r12;r21 r22])= [r11 r12 r21 r22]
tmp = eye(P^2)-kron(Phi,Phi);
vecSigmae = reshape(Sigmae.',P^2,1); % "vec" operation
vecR0 = tmp\vecSigmae;
R0 = reshape(vecR0.',P,P); % inverse "vec" operation

% Calculate the covariance
RR(:,:,1) = R0;
for k=2:N,
    RR(:,:,k) = Phi*RR(:,:,k-1);
end

% write the result in a cell array of size P-by-P

R = cell(P,P);
for k=1:P,
    for j=1:P,
        R{k,j} = squeeze(RR(k,j,:)).'; % take transpose to get a row vector
    end
end

if P==1,
    % return vector, not cell array
    R = R{1,1};
end