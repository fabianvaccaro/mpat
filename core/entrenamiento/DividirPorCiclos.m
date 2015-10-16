function [ M3, M9, M15, M21, M27 ] = DividirPorCiclos( MatrizEntradas, VectorSalidasEsperadas)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
M3 = zeros(1,120);
M9 = zeros(1,120);
M15 = zeros(1,120);
M21 = zeros(1,120);
M27 = zeros(1,120);
cont3 = 0;
cont9 = 0;
cont15 = 0;
cont21 = 0;
cont27 = 0;
recon= MatrizEntradas';
largo = length(VectorSalidasEsperadas);
disp(largo)
for i=1:largo
    switch VectorSalidasEsperadas(i)
        
        case 3
            cont3 = cont3 + 1;
            M3(cont3,:) = recon(i,:);
        case 9
            cont9 = cont9 + 1;
            M9(cont9,:) = recon(i,:);
        case 15
            cont15 = cont15 + 1;
            M15(cont15,:) = recon(i,:);
        case 21
            cont21 = cont21 + 1;
            M21(cont21,:) = recon(i,:);
        case 27
            cont27 = cont27 + 1;
            M27(cont27,:) = recon(i,:);
    end
end

end

