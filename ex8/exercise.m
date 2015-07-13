%% 
%   you do not need to run the whole script
%   remember you can use ctrl+Enter to execute one block at a time
%%


%##########################################################################
%              PREPARATIONS
%##########################################################################
%% Parameters

%number of eigenvalues
k = 100;
%number of sample vertices
K = 5;
%%

%load mesh
M1 = meshload('shapes/crane_0022.off');
M2 = meshload('shapes/crane_0126.off');

numberOfVertices1 = size(M1.X,1);
numberOfVertices2 = size(M2.X,1);

%%
%##########################################################################
%              Create Laplacian
%##########################################################################
% compute the cotangent and mass matrices 
M1.M = massmatrix([M1.X, M1.Y, M1.Z],M1.tri);
M1.S = cotanmatrix([M1.X, M1.Y, M1.Z],M1.tri);

M2.M = massmatrix([M2.X, M2.Y, M2.Z],M2.tri);
M2.S = cotanmatrix([M2.X, M2.Y, M2.Z],M2.tri);

%%
%##########################################################################
% compute the eigenvalues
%##########################################################################
tic;
[M1.phi,M1.lambda] = eigs(M1.S,M1.M, k, -1e-5);
M1.lambda = abs(diag(M1.lambda));
toc;
tic;
[M2.phi,M2.lambda] = eigs(M2.S,M2.M, k, -1e-5);
M2.lambda = abs(diag(M2.lambda));
toc;
%%
%##########################################################################
% Visualize several eigen functions
%##########################################################################

figure
nPlots = 7;
maxf = max(max(M1.phi(:,1:nPlots)));
minf = min(min(M1.phi(:,1:nPlots)));
for i=1:nPlots
    subplot(1,nPlots,i);
    f = M1.phi(:,i);
    f(1) = maxf;
    f(2) = minf;
    meshplot(M1,f);
end

%%
%##########################################################################
% testing spectralFM.m
%##########################################################################

%set P to the ground-truth permutation matrix (which is the identity in the
%case of the 'micheal' shapes)
P = sparse(1:numberOfVertices1, 1:numberOfVertices1, 1);
% TODO: add appropriate additional parameters to the spectralFM(...) call.
C = spectralFM(P, M1.phi, M2.phi, M2.M);
%C = spectralFM(P, additionalparameters);

%%
%##########################################################################
% Visualize Functional Map
%##########################################################################

s = euclideanfps([M1.X M1.Y M1. Z], K , 1);
voronoiF = euclideanvoronoi([M1.X M1.Y M1. Z], s);

refVertex = 2718; 
f = zeros(numberOfVertices1,1);
f(refVertex) = 1;


spectralF = M1.phi'*M1.M*f;
spectralCF = C*spectralF;

spectralX = M1.phi'*M1.M*M1.X;
spectralCX = C*spectralX;

spectralVoronoiF = M1.phi'*M1.M*voronoiF;
spectralVoronoiCF = C*spectralVoronoiF;

figure
colormap default
subplot(2,3,1);
meshplot(M1,M1.phi*spectralF);
colormap default
subplot(2,3,4);
meshplot(M2,M2.phi*spectralCF);
subplot(2,3,2);
meshplot(M1,M1.phi*spectralX);
subplot(2,3,5);
meshplot(M2,M2.phi*spectralCX);
subplot(2,3,3);
meshplot(M1,M1.phi*spectralVoronoiF);
colormap jet
subplot(2,3,6);
meshplot(M2,M2.phi*spectralVoronoiCF);
colormap jet

%%
%##########################################################################
% testing fmToVertexMap
%##########################################################################

c = fmToVertexMap( C, M1.phi, M2.phi);
figure
spy(sparse(c,1:numberOfVertices1,1));
%%
%##########################################################################
% Visualize fmToVertexMap
%##########################################################################

s = euclideanfps([M1.X M1.Y M1. Z], K , 1);
voronoiF = euclideanvoronoi([M1.X M1.Y M1. Z], s);

refVertex = 2718; 
f = zeros(numberOfVertices1,1);
f(refVertex) = 1;


f2 = f(c);
X2 = M1.X(c);
voronoiF2 = voronoiF(c);


figure
colormap jet
subplot(2,3,1);
meshplot(M1,f);
subplot(2,3,4);
meshplot(M2,f2);
subplot(2,3,2);
meshplot(M1,M1.X);
subplot(2,3,5);
meshplot(M2,X2);
subplot(2,3,3);
meshplot(M1,voronoiF);
subplot(2,3,6);
meshplot(M2,voronoiF2);
%%
%##########################################################################
% testing optimalFM
%##########################################################################

numberOfSamples = 2*k;
%generating samples
s = euclideanfps([M1.X M1.Y M1. Z], numberOfSamples , 1);
optC = optimalFM([s s], M1.phi, M1.M, M2.phi, M2.M);
%%
optc = fmToVertexMap( optC, M1.phi, M2.phi);
figure
spy(sparse(optc,1:numberOfVertices1,1));
%%
%##########################################################################
% Visualize optimalFM
%##########################################################################

refVertex = 2718; 
f = zeros(numberOfVertices1,1);
f(refVertex) = 1;


f2 = f(optc);
X2 = M1.X(optc);
voronoiF2 = voronoiF(optc);


figure
colormap jet
subplot(2,3,1);
meshplot(M1,f);
subplot(2,3,4);
meshplot(M2,f2);
subplot(2,3,2);
meshplot(M1,M1.X);
subplot(2,3,5);
meshplot(M2,X2);
subplot(2,3,3);
meshplot(M1,voronoiF);
subplot(2,3,6);
meshplot(M2,voronoiF2);


