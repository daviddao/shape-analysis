%% 
%   you do not need to run the whole script
%   remember you can use ctrl+Enter to execute one block at a time
%%


%##########################################################################
%              PREPARATIONS
%##########################################################################
%% Parameters

K = 1000
mdsDim = 2;
%%

%load mesh
M1 = meshload('shapes/lion-03_v1002.off');
M2 = meshload('shapes/lion-09_v1002.off');

% compute geodesic distance matrix (requires presence of file
% 'distmatrix.mexa64')
%D1 = distmatrix([M1.X M1.Y M1.Z]',M1.tri');
%D2 = distmatrix([M2.X M2.Y M2.Z]',M2.tri');
load('shapes/lions_distances.mat')

numberOfVertices1 = size(M1.X,1);
numberOfVertices2 = size(M2.X,1);
%%
%%compute FPS on the 
%%visualize FPS using metrics D1,D2

figure
subplot(1,2,1);
v1 = randi(numberOfVertices1);
S1 = metricfps(K, v1, D1);
f1 = metricvoronoi(S1,D1);
meshplot(M1,f1);
%cloudplot([M1.X M1.Y M1.Z],f1);
hold on
scatter3(M1.X(S1),M1.Y(S1),M1.Z(S1),25,[1 1 1],'o','filled');
hold off

subplot(1,2,2);
v2 = randi(numberOfVertices2);
S2 = metricfps(K, v2, D2);
f2 = metricvoronoi(S2,D2);
meshplot(M2,f2);
%cloudplot([M2.X M2.Y M2.Z],f2);
hold on
scatter3(M2.X(S2),M2.Y(S2),M2.Z(S2),25,[1 1 1],'o','filled');
hold off

%%
%##########################################################################
%              Matching
%##########################################################################

%metrics restricted to the FPS
D1S = D1(S1,S1);
D2S = D2(S2,S2);

n = size(D1S,1);
assert((n==size(D1S,2))&&(n==size(D2S,1))&&(n==size(D2S,2)));


[Z1, ~] = mds(D1S, mdsDim, 2e-4, 1e-5, 10000);
assert(isequal(size(Z1),[n,mdsDim]), 'Point matrix Z1 has wrong dimensions');
[Z2, ~] = mds(D2S, mdsDim, 2e-4, 1e-5, 10000);
assert(isequal(size(Z2),[n,mdsDim]), 'Point matrix Z2 has wrong dimensions');

[Zhat1, Zhat2] = alignpoints(Z1, Z2);
assert(isequal(size(Zhat1),[n,mdsDim]), 'Point matrix Zhat1 has wrong dimensions');
assert(isequal(size(Zhat2),[n,mdsDim]), 'Point matrix Zhat2 has wrong dimensions');

%%
%##########################################################################
%              Visualize aligned embeddings
%##########################################################################
%the aligned points can be mirror along some axis
%experiment with values of +1 or -1 to account for this
dimSigns = [1 -1 1];
if (mdsDim==2)
    figure();
    plot(Zhat1(:,1),Zhat1(:,2),'r.'); axis off, axis equal, drawnow
    hold on
    plot(dimSigns(1)*Zhat2(:,1),dimSigns(2)*Zhat2(:,2),'b.'); axis off, axis equal, drawnow
    hold off;
end
if (mdsDim>=3)
    figure();
    plot3(Zhat1(:,1),Zhat1(:,2),Zhat1(:,3),'r.'); axis off, axis equal, drawnow
    hold on
    plot3(dimSigns(1)*Zhat2(:,1),dimSigns(2)*Zhat2(:,2),dimSigns(3)*Zhat2(:,3),'b.'); axis off, axis equal, drawnow
    hold off;
end

