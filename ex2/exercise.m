%% 
%   you do not need to run the whole script
%   remember you can use ctrl+Enter to execute one block at a time
%%

%##########################################################################
%              PART 1
%##########################################################################

%%
%parameters

K = 9;

w = 3;
h = 1;

%%

%load mesh
M = meshload('kid1.off');
numberOfFaces = size(M.tri,1);
numberOfVertices = size(M.X,1);

%%

figure
k = 1;
for i=1:w
    for j=1:h
        subplot(h,w,k);
        v1 = randi(numberOfVertices);
        S = euclideanfps( [M.X M.Y M.Z] , K, v1);
        f = euclideanvoronoi([M.X M.Y M.Z] ,S);
        meshplot(M,f);
        %cloudplot([M.X M.Y M.Z],f);
        hold on
        scatter3(M.X(S),M.Y(S),M.Z(S),25,[1 1 1],'o','filled');
        hold off
        k = k+1;
    end
end

%%

%##########################################################################
%              PART 2 A
%##########################################################################
%% Parameters
K = 9;
%%

%load mesh
M1 = meshload('crane_0017_v602.off');
M2 = meshload('crane_0049_v602.off');

% compute geodesic distance matrix (requires presence of file
% 'distmatrix.mexa64')
%D1 = distmatrix([M1.X M1.Y M1.Z]',M1.tri');
%D2 = distmatrix([M2.X M2.Y M2.Z]',M2.tri');
load('cranes_distances.mat')

numberOfVertices1 = size(M1.X,1);
numberOfVertices2 = size(M2.X,1);
%%
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
%              PART 2 B
%##########################################################################
% run Part 2 A first to initialize

%metrics restricted to the FPS
D1S = D1(S1,S1);
D2S = D2(S2,S2);
[p,d] = ghdistance(D1S,D2S);

%% visualize

figure
subplot(1,2,1);
%meshplot(M1,p(f1));
%cloudplot([M1.X M1.Y M1.Z],p(f1));
hold on
scatter3(M1.X(S1),M1.Y(S1),M1.Z(S1),25,[1 1 1],'o','filled');
hold off

subplot(1,2,2);
%meshplot(M2,f2);
%cloudplot([M2.X M2.Y M2.Z],f2);
hold on
scatter3(M2.X(S2),M2.Y(S2),M2.Z(S2),25,[1 1 1],'o','filled');
hold off
