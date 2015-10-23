function [ nuevasEntradas, nuevasSalidas ] = reducirConjuntos( entradas, verificadas, salidas )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n]= size(entradas);
nuevasEntradas = zeros(m,1);
[m,n]= size(salidas);
nuevasSalidas = zeros(m,1);
for i=1:length(entradas)
    clamp=verificadas(:,i);
    valmax = max(clamp);
    indiceVerificadas = find(clamp == valmax);
    deseada = salidas(:,i);
    indiceDeseadas= find(deseada == 1);
    if(indiceDeseadas == indiceVerificadas)
        nuevasEntradas = [nuevasEntradas, entradas(:,i)];
        nuevasSalidas = [nuevasSalidas, salidas(:,i)];
    end
    
end
nuevasEntradas(:,1) = [];
nuevasSalidas(:,1)=[];

end

