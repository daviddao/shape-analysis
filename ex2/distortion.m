function [ d ] = distortion( p, D1, D2 )
%DISTORTION Compute the metric distortion of induced by p with respect to
%metrics D1 and D2
% - p is a n-by-1 vector, such that point i on shape 1 is mapped to point
%   p(i) on shape 2.
% - D1 is a n-by-n matrix representing the metric on shape 1
% - D2 is a n-by-n matrix representing the metric on shape 2
% Returns
% - d is the scalar value of the metric distortion induced by p

% get the number of points
n = size(p,1);

% distortion will be maximized
d = 0;

% iterate through all points
for i=1:n
    % look at all possible distances
    for j=1:n
        % calculate the distortion
        dist = abs(D1(i,j) - D2(p(i),p(j)));
        % is it larger than current d?
        d = max(d,dist); 
    end
end

end

