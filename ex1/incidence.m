function [ B ] = incidence( M )
%INCIDENCE Builds signed vertex-to-halfedge incidence matrix of mesh M
%   Returns m-by-n matrix B, where m is the number of halfedges edges
%   and n is the number of vertices.
%   B(i,j)==1 iff halfedge i is positively incident with vertex j,
%   B(i,j)==-1 iff halfedge i is negatively incident with vertex j and
%   B(i,j)==0 otherwise.

% get the number of vertices and the number of halfedges (=3 * number of faces)
n = max(max(M.tri));
[m,D] = size(M.tri);
numberOfHalfEdges = m*3;

% create the INCIDENCE matrix with mxn entries
B = sparse(numberOfHalfEdges,n);
% iterate through all faces
for i = 0:(m-1) 
    face = M.tri(i+1,:);
    
    for j = 1:D
        % permutate face to get all half edges
        face_shift = circshift(face,[0,j-1]);
        % get the indices of vertex v_s and v_t where (v_s,.) and (.,v_t)
        v_s = face_shift(1);
        v_t = face_shift(2);
        % set the INCIDENCE matrix entries 
        B(3*i+j,v_s) = -1;
        B(3*i+j,v_t) = 1;
    end
    
end

end

