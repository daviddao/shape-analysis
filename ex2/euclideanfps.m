function [ S ] = euclideanfps( V, K, v1)
%EUCLIDEANFPS Samples K vertices from V by using farthest point sampling.
% The farthest point sampling starts with vertex v1 and uses the euclidean
% metric of the 3-dimensional embedding space.
% -  V is a n-by-3 matrix storing the positions of n vertices
% -  K is the number of samples
% -  v1 is the index of the first vertex in the sample set. (1<=v1<=n)
% Returns
% -  S is a K-dimensional vector that includes the indeces of the K sample
%    vertices.

%Hint: matlab function pdist2 could be helpful

% Initialise
S = zeros(K,1);
S(1) = v1;

for i = 1:(K-1)
    % get the pairwise distance matrix for the current sample with all vertices
    Vdist = pdist2(V(S(1:i),:),V);
    % get the column (vertex id) with the largest max el of the matrix
    [~,midx] = max(min(Vdist));
    % store it inside S
    S(i+1) = midx; 
end


end

