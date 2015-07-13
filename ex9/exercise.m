%% 
%   you do not need to run the whole script
%   remember you can use ctrl+Enter to execute one block at a time
%%


%##########################################################################
%              PREPARATIONS
%##########################################################################
%% Parameters

meshPath = '/usr/wiss/windheus/data/shapes/crane/meshes/';
%number of eigenvalues
k = 100;

meshIndex1 = 20;
meshIndex2 = 5;
meshIndex3 = 70;

%%
meshFilenames = strsplit(ls([meshPath '*.obj']));
meshFilenames = meshFilenames(~cellfun('isempty',meshFilenames));
meshFilename1 = meshFilenames{meshIndex1};
meshFilename2 = meshFilenames{meshIndex2};
meshFilename3 = meshFilenames{meshIndex3};

%load mesh
M1 = meshload2(meshFilename1,k);
M2 = meshload2(meshFilename2,k);
M3 = meshload2(meshFilename3,k);

numberOfVertices1 = size(M1.X,1);
numberOfVertices2 = size(M2.X,1);
numberOfVertices3 = size(M3.X,1);

%%
%##########################################################################
%              Look for analoguous shapes
%##########################################################################

meshIndex4 = findAnaloguousShape(M1, M2, M3, meshFilenames, k);
meshFilename4 = meshFilenames{meshIndex4};
M4 = meshload2(meshFilename4,k);


%%
%##########################################################################
% Visualize analoguous shapes
%##########################################################################


figure
subplot(2,2,1);
meshplot(M1,M1.X);
subplot(2,2,2);
meshplot(M2,M2.X);
subplot(2,2,3);
meshplot(M3,M3.X);
subplot(2,2,4);
meshplot(M4,M4.X);

