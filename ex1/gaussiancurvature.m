function [ f ] = gaussiancurvature( M )
%GAUSSIANCURVATURE Computes the gaussian curvature of each vertex of mesh M.
%   Returns vector f where f(i)== gaussian curvature of vertex i.

% get number of faces
m = size(M.tri,1);

% get number of vertices
n = size(M.X,1);

% create f
f = zeros(n,1);

% go through all faces
for i=1:m
    
    % get the face (triangle) 
    face = M.tri(i,:);
    p1 = face(1);
    p2 = face(2);
    p3 = face(3);
    
    % set the coordinates
    P1 = [M.X(p1),M.Y(p1),M.Z(p1)];
    P2 = [M.X(p2),M.Y(p2),M.Z(p2)];
    P3 = [M.X(p3),M.Y(p3),M.Z(p3)];
    
    % calculate the distances
    u12 = norm(P1 - P2);
    u13 = norm(P1 - P3);
    u32 = norm(P3 - P2);
    
    % calculate the triangle angles
    alpha = acos((u13^2 + u32^2 - u12^2)/(2*u13*u32));
    beta = acos((u12^2 + u32^2 - u13^2)/(2*u12*u32));
    gamma = acos((u12^2 + u13^2 - u32^2)/(2*u12*u13));
    
    % add the angles iterativly to f
    f(p3) = f(p3) + alpha;
    f(p2) = f(p2) + beta;
    f(p1) = f(p1) + gamma;
    
end    

end


