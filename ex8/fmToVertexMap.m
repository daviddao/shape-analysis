function [ c ] = fmToVertexMap( C, Phi1, Phi2 )

tree = KDTreeSearcher(Phi2);
c = knnsearch(tree,Phi1*C'); % L2-similarity

end

