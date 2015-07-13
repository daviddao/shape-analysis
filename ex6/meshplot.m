function meshplot( varargin )
%MESHPLOT Display mesh M as a 3D plot.
%   f specifies a real valued function on the set of vertices or triangles.
%   The values of f are used to color the plot.
%   f is either a m-by-1 or n-by-1 matrix, where m is the number of
%   triangles and n is the number of vertices.
if (nargin==2)
    M = varargin{1};
    f = varargin{2};
    assert(isstruct(M));
    numberOfFaces = size(M.tri,1);
    trisurf(M.tri,M.X,M.Y,M.Z,f)
    axis equal
    if (numberOfFaces==size(f,1))
        shading faceted
    else
        shading interp
    end
    axis off
elseif (nargin==3)
    V = varargin{1};
    F = varargin{2};
    f = varargin{3};
    if  (size(V,2)~=3)
        V = V';
    end
    assert(size(V,2)==3);
    if  (size(F,2)~=3)
        F = F';
    end
    assert(size(F,2)==3);
    m = size(F,1);
    %n = size(V,1);

    trisurf(F,V(:,1),V(:,2),V(:,3),f)
    axis equal
    if (m==size(f,1))
        shading faceted
    else
        shading interp
    end
    axis off
end
end

