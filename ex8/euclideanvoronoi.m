function [ f ] = euclideanvoronoi( V, S )
%EUCLIDEANVORONOI Compute the partition of vertices into voronoi cells
% -  V is a n-by-3 matrix storing the positions of n vertices
% -  S is a K dimensional vector storing the vertex-indices of the starting
%    vertices.
% Returns
% -  f is a n-dimensional vector that maps the indeces of vertices onto the
%    set {1,...,K}, where n=number of vertices of the mesh

%Hint: matlab function pdist2 could be helpful
d = pdist2(V,V(S,:));
[~,f] = min(d,[],2);
end

