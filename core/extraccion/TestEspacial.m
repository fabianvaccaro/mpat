function [ MatrizFiltrada, DistanciaTotal, DistanciaMedia, imagenRecortada, BW2 ] = TestEspacial( ImagenRGB )
%TESTESPACIAL Summary of this function goes here
%   Detailed explanation goes here
ImagenRGB = imresize(ImagenRGB, [300 NaN]);
%segmentacion
addpath('../segmentacion/');
[fimg, labels, modes, regsize, grad, conf]= segmentar(ImagenRGB,10,14,2);
alterno = fimg(:,:,2);
umbral = calcularUmbral(alterno);
BW = zeros(size(alterno));
BW(abs(alterno)>umbral)=1;
BW2 = bwareafilt(logical(BW),1);
S = FindLargestSquares(BW2);
[~, pos] = max(S(:));
[r c] = ind2sub(size(S), pos); %posición de la esquina superior izquierda del cuadrado más grande
lado = S(r,c); %tamaño del lado del cuadrado;

%Conformación del cuadrado
lab = rgb2lab(ImagenRGB);
a = lab(:,:,2);%Extrae la capa a

imagenRecortada = a(r:r+lado, c:c+lado);

[ MatrizFiltrada, DistanciaTotal, DistanciaMedia ] = Espacial( imagenRecortada);




end

