function [ entradas, salidas, numcyclos ] = CrearMatricesEntrenamiento( features, cycles )

numcyclos = count_unique(cycles);

diferentes = size(numcyclos);
diferentes = diferentes(1);

nummuestras = size(features);
nummuestras = nummuestras(1);

salidas = zeros(diferentes, nummuestras);

for i = 1:nummuestras
    posicion = find(numcyclos == cycles(i));
    salidas(posicion,i) = 1;
    
end

entradas = features';

end

