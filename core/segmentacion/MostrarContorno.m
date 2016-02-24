function [ mascara, distancias, rgb, fimg ] = MostrarContorno( imagenRGB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rgb = [];
rgb(:,:,1) = imagenRGB(:,:,1);
rgb(:,:,2) = imagenRGB(:,:,2);
rgb(:,:,3) = imagenRGB(:,:,3);

rgb = imresize(rgb, [300 NaN]);

[fimg, labels, modes, regsize, grad, conf]= segmentar(rgb,20,14,2);
[ mascara, distancias ] = GenerarMascara( fimg );
rgb = uint8(rgb);
imshow(rgb);
hold on;
contour(mascara, 'LineWidth', 1.5, 'LineColor', 'blue' );
end

