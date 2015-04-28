function meshplot( M, f )
%MESHPLOT Display mesh M as a 3D plot.
%   f specifies a real valued function on the set of vertices or triangles.
%   The values of f are used to color the plot.
%   f is either a m-by-1 or n-by-1 matrix, where m is the number of
%   triangles and n is the number of vertices.
numberOfFaces = size(M.tri,1);
trisurf(M.tri,M.X,M.Y,M.Z,f)
axis equal
if (numberOfFaces==size(f,1))
    shading faceted
else
    shading interp
end
axis off
end

