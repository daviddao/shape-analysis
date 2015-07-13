function [ Zhat1, Zhat2 ] = alignpoints( Z1, Z2 )
%ALIGNPOINTS Align points Z1 and Z2 by a rigid transformation.
%Input:
%   Z1, Z2   : n-by-m matrices storing n points of dimension m.
%Output:
%   Zhat1, Zhat2   : n-by-m matrices storing n transformed points of 
%                    dimension m.


mZ1= bsxfun(@minus, Z1', mean(Z1)')';
mZ2= bsxfun(@minus, Z2', mean(Z2)')';

Zhat1 = (pca(mZ1)'*(mZ1'))';
Zhat2 = (pca(mZ2)'*(mZ2'))';

end

