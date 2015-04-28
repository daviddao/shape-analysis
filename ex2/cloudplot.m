function cloudplot( V, f )
%CLOUDPLOT Display point cloud in 3D.
%   V is a N-by-3 matrix containing the point position
%   f specifies a real valued function on the set of point.
%   The values of f are used to color the plot.
colormap(hsv)
numberOfPoints = size(V,1);
scatter3(V(:,1),V(:,2),V(:,3),30,f,'o','filled');
axis equal
axis off
end

