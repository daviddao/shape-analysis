function [ M ] = massmatrix( V, F )
%MASSMATRIX generates an n-by-n mass matrix.
%  Input:
%   - V : n-by-3 matrix contains the 3D coordinates of the n vertices in
%         each of it's rows.
%   - F : m-by-3 matrix contains the indeces of the triangles' vertices.
%
%  Output:
%   - M : n-by-n mass matrix contains the values as described in the
%         lecture.
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

%triangle areas
A = facearea(V, F);

indecesI = [F(:,1);F(:,2);F(:,3);F(:,3);F(:,2);F(:,1)];
indecesJ = [F(:,2);F(:,3);F(:,1);F(:,2);F(:,1);F(:,3)];
values   = [A(:)  ;A(:)  ;A(:)  ;A(:)  ;A(:)  ;A(:)  ]*(1/12);
M = sparse(indecesI, indecesJ, values,n,n);
M = M+sparse(1:n,1:n,sum(M));

%check symmetry
if (~isequal(sparse([],[],[],n,n),M-M'))
    fprintf('WARNING, internal error in massmatrix: M is not symmetric.\n');
end

end

