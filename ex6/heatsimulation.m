function  heatsimulation( V, F, M, Phi, Lambda, u0, T)
%HEATSIMULATION visualizes heat diffusion on a manifold starting at a given
%   heat distribution.
% Input arguments:
%   V:       n-by-3 matrix representing the vertex coordinates
%   F:       m-by-3 matrix containing the triangles. Each row holds three vertex
%            indeces.
%   M:       n-by-n sparse mass matrix.
%   Phi:     n-by-k matrix containing the first k eigenfunctions of the
%            Laplace-Beltrami operator.
%   Lambda:  k-dmensional vector containing the first k eigenvalues of the
%            Laplace-Beltrami operator.
%   u0:      n-dmensional vector containing the start distribution of the
%            heat at time 0.
%   T:       Vector containing the time points that should be animated.


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

figure;
hold off;

for i = 1:numel(T)
    %place your code here:
    %vector "ut" should contain the heat distribution at time T(i).
    ut = heatdiffusion(Phi, Lambda, M, u0, T(i));
    %Optionally you can uncomment the next two lines. This will prevent
    %matlab from changing the scale during animation
    ut(1)=max(u0)/1000;
    ut(2)=min(u0);
    meshplot(V,F,ut);
    drawnow;
end

end

function ut = heatdiffusion(Phi, Lambda, M, u0, t)
k = size(Phi,2);
PhiTMu0 = Phi'*M*u0;
ut = exp(-1*Lambda(1)*t)*Phi(:,1)*PhiTMu0(1);
for i=2:k
    ut = ut+exp(-1*Lambda(i)*t)*Phi(:,i)*PhiTMu0(i);
end
end