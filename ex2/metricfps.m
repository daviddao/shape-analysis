function [ S ] = metricfps( K, v1, D)
%METRICFPS Samples K vertices from V by using farthest point sampling.
% The farthest point sampling starts with vertex v1 and uses the metric
% given by matrix D
% -  K is the number of samples
% -  v1 is the index of the first vertex in the sample set. (1<=v1<=n)
% -  D is a n-by-n matrix, such that D(i,j) contains distance between
%    vertices i and j.
% Returns
% -  S is a K-dimensional vector that includes the indeces of the K sample
%    vertices.

% Initialise
S = zeros(K,1);
S(1) = v1;

for i = 1:(K-1)
    % get the pairwise distance matrix for the current sample with all vertices
    Vdist = D(S(1:i),:);
    % get the column (vertex id) with the largest max el of the matrix
    [~,midx] = max(min(Vdist));
    % store it inside S
    S(i+1) = midx; 
end


end

