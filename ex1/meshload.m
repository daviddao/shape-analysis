function [ M ] = meshload( filename )
%MESHLOAD Load a mesh in OFF format from a file given by filename
%   Returns the mesh as a struct.
%   Vertex coordinates can be accessed by M.X, M.Y and M.Z .
%   Triangles are stored in the m-by-3 matrix M.tri .
%   Each row of M.tri contains three vertex indeces.

[V,F] = read_off(filename);
V = V';
M.tri = F';
M.X = V(:,1);
M.Y = V(:,2);
M.Z = V(:,3);

end

