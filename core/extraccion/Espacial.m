function [ MatrizFiltrada, DistanciaTotal, DistanciaMedia ] = Espacial( ImagenDeValores)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
tama = size(ImagenDeValores);
CantidadPixeles = tama(1) * tama(2);
%Matriz de filtro resultante
MatrizFiltrada = zeros(tama(1), tama(2));
%Calcula el umbral
I = im2double(ImagenDeValores);
L = medfilt2(I,[3 3]);
db = double(L);
media = mean2(db);
desviacion = std2(db);
umbral = desviacion/2;


%Genera la Matriz Filtrada

fun = @(x) (calcular(x, umbral));
MatrizFiltrada = nlfilter(I,[5 5],fun);



%Computa la distancia total
DistanciaTotal = sum(sum(MatrizFiltrada));
DistanciaMedia = DistanciaTotal/CantidadPixeles;

end
function distancia = calcular(matriz, umbral)
distancia = 0;
media = mean2(matriz);
desviacion = std2(matriz);
for i = 1:5%itera entre las columnas
    for j = 1:5 %itera entre las filas
        if(i == 3 && j ==3)
            %no hace nada
        elseif(matriz(i,j)~=0)
            if(abs(matriz(i,j)- matriz(3,3)) > umbral)
                distancia = distancia + 1;
            end
        end
    end
end


end

