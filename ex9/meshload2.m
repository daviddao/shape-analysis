function [ M ] = meshload2( filename, k )
%MESHLOAD Load a mesh in OBJ format from a file given by filename
%   Returns the mesh as a struct.
%   Vertex coordinates can be accessed by M.X, M.Y and M.Z .
%   Triangles are stored in the m-by-3 matrix M.tri .
%   Each row of M.tri contains three vertex indeces.

[V,F] = read_obj(filename);
V = V';
M.tri = F';
M.X = V(:,1);
M.Y = V(:,2);
M.Z = V(:,3);
%%
%##########################################################################
%              Create Laplacian
%##########################################################################
% compute the cotangent and mass matrices 
M.M = massmatrix([M.X, M.Y, M.Z],M.tri);
M.S = cotanmatrix([M.X, M.Y, M.Z],M.tri);

%%
%##########################################################################
% compute the eigenvalues
%##########################################################################
tic;
[M.phi,M.lambda] = eigs(M.S,M.M, k, -1e-5);
M.lambda = abs(diag(M.lambda));
toc;

end

