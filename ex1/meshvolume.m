function [ r ] = meshvolume( M )
%MESHVOLUME Computes the volume of mesh M.

r = 0;

% Get number of faces
m = size(M.tri,1);

for i=1:m
    
    % get the face 
    face = M.tri(i,:);
    p1 = face(1);
    p2 = face(2);
    p3 = face(3);
    
    % calculate the signed volume of a tetrahedron 
    v321 = M.X(p3)*M.Y(p2)*M.Z(p1);
    v231 = M.X(p2)*M.Y(p3)*M.Z(p1);
    v312 = M.X(p3)*M.Y(p1)*M.Z(p2);
    v132 = M.X(p1)*M.Y(p3)*M.Z(p2);
    v213 = M.X(p2)*M.Y(p1)*M.Z(p3);
    v123 = M.X(p1)*M.Y(p2)*M.Z(p3);
    
    r = r + (1/6)*(-v321 + v231 + v312 - v132 - v213 + v123);
end

r = abs(r);

end
