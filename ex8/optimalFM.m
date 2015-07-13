function [ C ] = optimalFM( c, Phi1, M1, Phi2, M2 )
%A = Phi1'*M1(:,c(:,1));
%B = Phi2'*M2(:,c(:,2));
A = Phi1(c(:,1),:)';
B = Phi2(c(:,2),:)';


C = (B')\(A');
end

