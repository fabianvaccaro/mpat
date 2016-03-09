function [ mascara, distancias, rgb, fimg, c, f2, locs, pks ] = MostrarContorno( imagenRGB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rgb = [];
rgb(:,:,1) = imagenRGB(:,:,1);
rgb(:,:,2) = imagenRGB(:,:,2);
rgb(:,:,3) = imagenRGB(:,:,3);

rgb = imresize(rgb, [300 NaN]);

[fimg, labels, modes, regsize, grad, conf]= segmentar(rgb,10,4,2);

%fimg = RGB2Luv(rgb);
%fimg = imgaussfilt(fimg, 2);


[ mascara, distancias ] = GenerarMascara( fimg );
rgb = uint8(rgb);
imshow(rgb);
hold on;
contour(mascara, 'LineWidth', 1.5, 'LineColor', 'magenta' );

c = unique(distancias(:));
c = sort(c);

f2 = diff(c);
if(length(c)>3)
    [pks,locs]=findpeaks(f2,'SORTSTR','descend');
else
    pks = max(f2);
    locs = -1;
end

end

