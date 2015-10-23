function MostrarContorno( imagenRGB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[fimg, labels, modes, regsize, grad, conf]= segmentar(imagenRGB,10,14,2);
alterno = fimg(:,:,2);
umbral = calcularUmbral(alterno);
imshow(imagenRGB);
hold on;
contour(abs(alterno)>umbral, 'LineWidth', 1.5, 'LineColor', 'blue' );
end

