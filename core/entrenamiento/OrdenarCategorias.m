function [ MisCategorias ] = OrdenarCategorias( MisSalidasEsperadas )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[ MisCategorias ] = zeros(length(MisSalidasEsperadas),1);
for i=1:length(MisSalidasEsperadas)
    switch MisSalidasEsperadas(i)
        case 3
            MisCategorias(i) = 1;
        case 9
            MisCategorias(i) = 2;
        case 15
            MisCategorias(i) = 3;
        case 21
            MisCategorias(i) = 4;
        case 27
            MisCategorias(i) = 5;
    end
end

end

