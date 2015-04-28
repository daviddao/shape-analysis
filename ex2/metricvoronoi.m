function [ f ] = metricvoronoi( S,D )
%METRICVORONOI Computes the partition of vertices into voronoi cells
% -  S is a K dimensional vector storing the vertex-indices of the starting
%    vertices.
% -  D is a n-by-n matrix, such that D(i,j) contains distance between
%    vertices i and j.
% Returns
% -  f is a n-dimensional vector that maps the indeces of vertices onto the
%    set {1,...,K}, where n=number of vertices of the mesh

Vdist = D(S,:);
[~,idx] = min(Vdist);
f = S(idx);

end

