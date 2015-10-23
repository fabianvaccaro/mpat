function [ scores ] = verificarRed( entradas, salidas, redNeuronal )
%REENTRENAR Summary of this function goes here
%   Detailed explanation goes here
[m,n]= size(entradas);
[k,l] = size(salidas);
verificadas = zeros(k,l);
%Matlab Pool
if matlabpool('size') == 0 % checking to see if my pool is already open
    matlabpool open 4
end
parfor i=1:length(entradas)
    i
    linea = entradas(:,i);
    verificadas(:,i) = redNeuronal(linea);
    
end

%matlabpool close
scores = verificadas;
end
