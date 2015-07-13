function [ C ] = spectralFM( P , phi1, phi2, M2 )
%SPECTRALFM Summary of this function goes here
%   Detailed explanation goes here

C = phi2'*M2*P*phi1;

end

