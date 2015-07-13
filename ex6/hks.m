function [ S ] = hks( V, F, Phi, Lambda, T)
%HKS returns the heat kernel signature of all points on a given manifold.
% Input arguments:
%   V:       n-by-3 matrix representing the vertex coordinates
%   F:       m-by-3 matrix containing the triangles. Each row holds three vertex
%            indeces.
%   Phi:     n-by-k matrix containing the first k eigenfunctions of the
%            Laplace-Beltrami operator.
%   Lambda:  k-dmensional vector containing the first k eigenvalues of the
%            Laplace-Beltrami operator.
%   T:       t-dimenstional vector containing the time points where the HKS
%            should be evaluated.
% Returns:
%   S:       |T|-by-n matrix. The i-th column of matrix S conatins the
%            t-dimensional heat kernels signature of vertex i.

if  (size(V,2)~=3)
    V = V';
end
assert(size(V,2)==3);
if  (size(F,2)~=3)
    F = F';
end
assert(size(F,2)==3);
m = size(F,1);
n = size(V,1);
k = size(Phi,2);
assert(size(Lambda,1)==k);
if (size(T,2)~=1)
    T = T';
end
assert(size(T,2)==1);

PhiTSqr = (Phi').*(Phi');
size(PhiTSqr)
S = exp(-T*Lambda')*(PhiTSqr);
end