function [ p, d ] = ghdistance( D1, D2 )
%GHDISTANCE Computes the Gromov-Hausdorff distance between metric spaces
%represented by the metrics D1 and D2.
% - D1 is a n-by-n matrix representing the metric on shape 1
% - D2 is a n-by-n matrix representing the metric on shape 2
% Returns
% - p is the n-by-1 vector representing the map where the minimum
%   distortion is attained
% - d is the scalar value of the Gromov-Hausdorff distance

%Hint: matlab function perms could be useful

% we want to minimize d
d = Inf;
n = size(D1,1);
v = 1:n;
%All possible permutations of vertices indices
P = perms(v);
%get all the rows
k = size(P,1);

for i=1:k
    p_tmp = P(i,:);
    % reshape the permutation array into a vector
    p_vector = reshape(p_tmp,[size(p_tmp,2),1]);
    % calculate the distortion
    d_tmp = distortion(p_vector,D1,D2);
    % if its smaller than current d, save p and d
    if d_tmp < d
       d = d_tmp;
       p = p_vector;
    end
end
    
end

