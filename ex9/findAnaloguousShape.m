function [meshIndex] = findAnaloguousShape(M1, M2, M3, meshFilenames, k);

numberOfShapes = numel(meshFilenames);

C13 = M3.phi'*M3.M*M1.phi;
[V12,R12] = shapeDiff(M1, M2);
C13V12 = C13*V12;
C13R12 = C13*R12;


bestScore = -1;
bestIndex = -1;

for i=1:numberOfShapes
    Mi = meshload2(meshFilenames{i},k);
    [V3i,R3i] = shapeDiff(M3, Mi);
    currentScore = sqrt(norm((V3i*C13-C13V12).^2,'fro'))+sqrt(norm((R3i*C13-C13R12).^2,'fro'));
    if bestIndex<0
        bestIndex = i;
        bestScore = currentScore;
    elseif bestScore>currentScore
        bestIndex = i;
        bestScore = currentScore;
    end
    [i currentScore]
end
meshIndex = bestIndex;
end


function [V,R] = shapeDiff(M1, M2)
    C = M2.phi'*M2.M*M1.phi;
    V = C'*C;
    R = diag(M1.lambda.^-1)*C'*diag(M2.lambda)*C;
end