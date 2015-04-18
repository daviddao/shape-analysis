function [ f ] = facearea( M )
%FACEAREA Computes the area of each face (triangle) of mesh M.
%   Returns vector f where f(i)==area of triangle i.

% Get number of faces
m = size(M.tri,1);
f = zeros(m,1);

for i=1:m
    
    % get the face 
    face = M.tri(i,:);
    p1 = face(1);
    p2 = face(2);
    p3 = face(3);
    
    % set the coordinates
    P1 = [M.X(p1),M.Y(p1),M.Z(p1)];
    P2 = [M.X(p2),M.Y(p2),M.Z(p2)];
    P3 = [M.X(p3),M.Y(p3),M.Z(p3)];
    
    % calculate the distance vectors
    u1 = P1 - P2;
    u2 = P1 - P3;
    u3 = P3 - P2;
    
    % get the distances
    a = norm(u1);
    b = norm(u2);
    c = norm(u3);

    % sort the elements
    v = sort([a b c]);
    a = v(3);
    b = v(2);
    c = v(1);
    
    % calculate the area using stabilized Heron formula
    temp = b + c;
    v1 = a + temp;
    temp = a - b;
    v2 = c - temp;
    v3 = c + temp;
    temp = b - c;
    v4 = a + temp;
    A = 0.25 * sqrt(v1*v2*v3*v4);
    
    % now save it into f
    f(i) = A;

end

end

