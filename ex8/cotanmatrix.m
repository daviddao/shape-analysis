function [ C ] = cotanmatrix( V, F )
%COTANMATRIX generates an n-by-n matrix according to the cotangent scheme.
%  Input:
%   - V : n-by-3 matrix contains the 3D coordinates of the n vertices in
%         each of it's rows.
%   - F : m-by-3 matrix contains the indeces of the triangles' vertices.
%
%  Output:
%   - C : n-by-n matrix contains the values as described by the cotangent
%         scheme.

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

%A stores the triangles angle at the vertex
A = zeros(m,3);
for i=1:3
    a = mod(i-1,3)+1;
    b = mod(i,3)+1;
    c = mod(i+1,3)+1;
    ab = V(F(:,b),:) - V(F(:,a),:);
    ac = V(F(:,c),:) - V(F(:,a),:);
    %normalize edges
    ab = ab ./ (sqrt(sum(ab.^2,2))*[1 1 1]);
    ac = ac ./ (sqrt(sum(ac.^2,2))*[1 1 1]);
    % normalize the vectors
    % compute cotangens of angles
    A(:,a) = cot(acos(sum(ab.*ac,2)));
    %cotangens can also be computed by x/sqrt(1-x^2)
end

indecesI = [F(:,1);F(:,2);F(:,3);F(:,3);F(:,2);F(:,1)];
indecesJ = [F(:,2);F(:,3);F(:,1);F(:,2);F(:,1);F(:,3)];
values   = [A(:,3);A(:,1);A(:,2);A(:,1);A(:,3);A(:,2)]*0.5;
C = sparse(indecesI, indecesJ, values,n,n);
C = C-sparse(1:n,1:n,sum(C));

%check symmetry
if (~isequal(sparse([],[],[],n,n),C-C'))
    fprintf('WARNING, internal error in cotanmatrix: C is not symmetric.\n');
end
end

