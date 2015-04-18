function [ A ] = adjacency( M )
%ADJACENCY Build adjacency matrix A from mesh M
%   M is a struct containing the m-by-3 matrix M.tri
%   Returns n-by-n adjacency matrix A, where n is the number of vertices.
%   A(i,j)==1 iff vertex i is adjacent to vertex j.

% get the number of vertices of M
n = max(max(M.tri));
% get the number of faces of M
[m,d] = size(M.tri);

% initialize a adjacency matrix
A = sparse(n,n);

% iterate through all faces
for i = 1:m 
    face = M.tri(i,:);
    % iterate through each V in face
    for j = 1:d
        % get the start vertex v_s
        v_s = face(j);
        for k = 1:d
            % we ignore reflexiv adjacency
            if(k ~= j)
                % get the connected vertices v_t
                v_t = face(k);  
                % set adjacency matrix to 1
                A(v_s,v_t) = 1;
            end
        end
    end 
end

end

