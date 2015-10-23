function [ umbral ] = calcularUmbral( alterno )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
L = medfilt2(alterno,[3 3]);
db = double(L);
media = mean2(db);
desviacion = std2(db);

ratio = desviacion/media;

tamano = size(db);

H = tamano(1);
W = tamano(2);
centroH = fix(H/2);
centroW = fix(W/2);

r = 10;

ventana = db(centroH-r:centroH+r, centroW-r:centroW+r);
mediaVentana = mean2(ventana);
%mediaVentana = abs(mean2(ventana));
desviacionVentana = std2(ventana);
%desviacionVentana = abs(std2(ventana));

p1 = db(1:r,1:r);
p2 = db(1:r,W-r:W);
p3 = db(H-r:H, W-r:W);
p4 = db(H-r:H,1:r);

mediaEsquina = (mean2(p1)+mean2(p2)+mean2(p3)+mean2(p4))/4;
desviacionEsquina = std2([p1(:) ; p2(:) ; p3(:) ; p4(:)]);
%mediaEsquina = abs((mean2(p1)+mean2(p2)+mean2(p3)+mean2(p4))/4)

% tM = mediaVentana + desviacionVentana
% tL = mediaVentana - desviacionVentana
% if(mediaEsquina>tL && mediaEsquina<tM)
%     umbral = min(min(db));
% else
%     umbral = mediaEsquina+2*ratio;
% end
umbral = abs(mediaEsquina) + 2*abs(desviacionEsquina);


end

