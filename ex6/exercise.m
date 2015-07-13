%% 
%   you do not need to run the whole script
%   remember you can use ctrl+Enter to execute one block at a time
%%


%##########################################################################
%              PREPARATIONS
%##########################################################################
%% Parameters

%number of eigenvalues
K = 100;
%%

%load mesh
%M1 = meshload('shapes/lion-03_v1002.off');
%M2 = meshload('shapes/lion-09_v1002.off');
M1 = meshload('shapes/michael0.off');
M2 = meshload('shapes/michael1.off');

numberOfVertices1 = size(M1.X,1);
numberOfVertices2 = size(M2.X,1);

%%
%##########################################################################
%              Create Laplacian
%##########################################################################
% compute the cotangent and mass matrices 
M1.M = massmatrix([M1.X, M1.Y, M1.Z],M1.tri);
M1.C = cotanmatrix([M1.X, M1.Y, M1.Z],M1.tri);

M2.M = massmatrix([M2.X, M2.Y, M2.Z],M2.tri);
M2.C = cotanmatrix([M2.X, M2.Y, M2.Z],M2.tri);

%%
%##########################################################################
% compute the eigenvalues
%##########################################################################
tic;
[M1.phi,M1.lambda] = eigs(M1.C,M1.M, K, -1e-5);
%[M1.phi,M1.lambda] = eigs(M1.C,[], K, -1e-5);
M1.lambda = abs(diag(M1.lambda));
toc;
tic;
[M2.phi,M2.lambda] = eigs(M2.C,M2.M, K, -1e-5);
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
% Simulate heat diffusion
%##########################################################################

%factor should be tuned to the shapes
T = 100*(1:100);
f = zeros(numberOfVertices1,1);
f(5837) = 1;
heatsimulation([-M1.X, M1.Y, M1.Z],M1.tri, M1.M, M1.phi, M1.lambda, f,T);

%%
%##########################################################################
% Heat Kernel Signature
%##########################################################################
%factor should be tuned to the shapes
T = 0.1*(1:1000);
S1 = hks([M1.X, M1.Y, M1.Z],M1.tri, M1.phi, M1.lambda,T);
S2 = hks([M1.X, M1.Y, M1.Z],M1.tri, M1.phi, M1.lambda,T);
%S2 = hks([M2.X, M2.Y, M2.Z],M2.tri, M2.M, M2.phi, M2.lambda,T);

%%
%##########################################################################
% Visualize Heat Kernel Signature
%##########################################################################
refVertex = 2578; %head
refVertex = 5837; %left thumb
refVertex = 6107; %left small finger
refVertex = 8916; %left knee
refVertex = 2718; %left ear
figure
%plot the distance between the hks of the selected vertex and the hks of
%all other vertices on the same shape
subplot(2,2,1);
meshplot(M1,(pdist2(S1(:,refVertex)',S1')));
subplot(2,2,2);
%same plot but with log scaling
meshplot(M1,log(pdist2(S1(:,refVertex)',S1')));
%plot the distance between the hks of the selected vertex and the hks of
%all other vertices on the second shape
subplot(2,2,3);
meshplot(M2,(pdist2(S1(:,refVertex)',S2')));
subplot(2,2,4);
%same plot but with log scaling
meshplot(M2,log(pdist2(S1(:,refVertex)',S2')));
%%
%##########################################################################
% Visualize Heat Kernel Signature
%##########################################################################
refVertex = 2578; %head
refVertex = 5837; %left thumb
refVertex = 6107; %left small finger
refVertex = 8916; %left knee
refVertex = 2718; %left ear
refVertex = 18; %left ear
figure
%plot the distance between the hks of the selected vertex and the hks of
%all other vertices on the same shape
subplot(2,2,1);
meshplot(M1,(pdist2(S1(:,refVertex)',S1')));
subplot(2,2,2);
%same plot but with log scaling
meshplot(M1,log(pdist2(S1(:,refVertex)',S1')));
%plot the distance between the hks of the selected vertex and the hks of
%all other vertices on the second shape
subplot(2,2,3);
meshplot(M1,(pdist2(S2(:,refVertex)',S2')));
subplot(2,2,4);
%same plot but with log scaling
meshplot(M1,log(pdist2(S2(:,refVertex)',S2')));
