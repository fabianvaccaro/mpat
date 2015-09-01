function [ predicho ] = clasificarChicle ( imagen_muestra, RNA, correspondenciClases )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
addpath('../../database/','../captura/','../estadistica/','../extraccion/','../interfaz/','../representacion/','../scripts/','../segmentacion/');

estructura_imagen=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
%extraer caracteristicas de la muestra

%resize image
imagen_muestra = imresize(imagen_muestra, [300 NaN]);
estructura_imagen.imagen = imagen_muestra;
[estructura_imagen.suave, estructura_imagen.regiones, modes, regsize, grad, conf]= segmentar(imagen_muestra,20,10,4);
linea_caracteristicas  = MPAT_SECOND( estructura_imagen, -6 );
linea_caracteristicas = linea_caracteristicas';

%clasificar con la RNA
xdf  = RNA(linea_caracteristicas);
mejorProbamilidad = max(xdf);
posicion = find(xdf == mejorProbamilidad);
predicho = correspondenciClases(posicion);

end

