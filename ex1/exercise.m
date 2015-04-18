%% 
%   you do not need to run the whole script
%   remember you can use ctrl+Enter to execute one block at a time
%% 

%load mesh
M = meshload('bouncing_0044.off');
numberOfFaces = size(M.tri,1);
numberOfVertices = max(max(M.tri));

%%
A = adjacency(M);
B = incidence(M);

numberOfVertices = size(A,1);
numberOfHalfedges = size(B,1);
numberOfEdges = numberOfHalfedges/2;

%graph laplacian
L = (B'*B)./2;

%% checks
%check number of half edges
if (mod(numberOfHalfedges,2)~=0)
    error('Incidence matrix indicates wrong number of half-edges.');
end

%check Euler Characteristic
if (numberOfVertices-numberOfEdges+numberOfFaces~=2)
    error('Euler Characteristic must be 2.');
end

%rows of the laplacian should add up to 0
if (nnz(sum(L))~=0)
    error('Rows of the laplacian should add up to 0.');
end

%off-diagonals of the Laplacian should form the negative adjacency matrix
if (nnz(L+A-diag(diag(L)))~=0)
    error('Off-diagonals of the Laplacian should form the negative adjacency matrix.');
end

%if no error occurred the adjacency and incidence matrices should be fine

%%
% compute and display the triangle's areas
f_area = facearea(M);
figure
meshplot(M, f_area);

%%
% compute the mesh's volume
meshvolume(M)
%%
% compute and plot gaussian curvature
f_gc = gaussiancurvature(M);
figure
subplot(1,2,1);
meshplot(M, f_gc);
subplot(1,2,2);
meshplot(M, min(max(f_gc,-0.1),0.1));
%meshplot(M, log(abs(f_gc)));
