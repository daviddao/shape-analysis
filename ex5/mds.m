function [ Z, sigma ] = mds( D, m, alpha, epsilon, maxI)
%MDS Embeds n points into R^m such that the euclidean distance preserves D.
% Inputs:
% D       : Non-negative n-by-n matrix containing the distances between 
%           points. I.e. D(i,j) contains the distance between points i,j.
%           Parameter n is given implicitely by the dimension of D.
% m       : Natural number m specifies the dimension of the embedding
%           space. If m=2 or m=3 the progress will be plotted.
% alpha   : Stepsize of the gradient descent algorithm. A value of 1e-4
%           should be fine. Experiment with this: If the values are too
%           small, the algorithm will converge very slowly. If the values
%           are too large, the algorithm will not converge at all.
% epsilon : Gradient descent algorithm stops after relative progress drops
%           below epsilon.
% maxI    : Gradient descent algorithm stops after at most maxI iterations.
%
% Outputs:
% Z       : n-by-m matrix Z contains the coordinates of the points in the
%           embedding space upon termination of the algorithm.
% sigma   : value of the embedding error

n = size(D,1);
assert(size(D,2)==n);
assert(m>0);
Z = rand(n,m);
V = -ones(n)+n*eye(n);

currentProgress = epsilon+1;
currentI = 1;
lastSigma = -1;

if ((m==2)||(m>=3))
    figure();
end

sqsumD = sum(sum(D.^2));
while ((currentI<=maxI)&&(currentProgress>=epsilon))
    DZ = pdist(Z, 'euclidean');
    DZ = squareform(DZ);
    
    B = -D./DZ;
    B(isnan(B))=0;
    B = B + diag(-sum(B,2));
    
    Z = Z - 2*alpha * (V*Z - B*Z);
    
    
    if (m==2)
        plot(Z(:,1),Z(:,2),'r.'); axis off, axis equal, drawnow
    end
    if (m>=3)
        plot3(Z(:,1),Z(:,2),Z(:,3),'r.'); axis off, axis equal, drawnow
    end
    
    currentSigma = trace(Z'*V*Z)-2*trace(Z'*B*Z)+(sqsumD/2);
    if (lastSigma>0)
        currentProgress = 1-(currentSigma/lastSigma);
    end
    currentI = currentI+1;
    lastSigma = currentSigma;
    [currentI currentProgress lastSigma currentSigma]
end

sigma = currentSigma;
end

