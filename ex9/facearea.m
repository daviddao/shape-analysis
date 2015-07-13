function [ f ] = facearea( V, F )
%FACEAREA Computes the area of each face (triangle) of mesh M.
%   Returns vector f where f(i)==area of triangle i.


V1 = V(F(:,2),:)-V(F(:,1),:);
V2 = V(F(:,3),:)-V(F(:,1),:);
f = cross(V1,V2,2);
f = sqrt(sum(f.^2,2)).*0.5;
end

