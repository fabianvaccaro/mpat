function [ matriz_entrenamiento, salidas_esperadas ] = entrenar_batch( hs, hr, minreg, umbral )
%entrenar_batch Genera los conjuntos de Entradas y Salidas para el etrenamiento supervisado de una red neuronal a partir de una base de
%datos de imágenes

%Añade al path
addpath('../../database/','../captura/','../estadistica/','../extraccion/','../interfaz/','../representacion/','../scripts/','../segmentacion/');
%Obtiene la lista de imagenes en el directorio
ImageList = getAllImages('../../database/*.jpg');
dime = size(ImageList);
total_muestras = dime(2);

%Declaración de variables

matriz_entrenamiento = zeros(total_muestras, 120);
salidas_esperadas = zeros(total_muestras,1);
estructura_imagen=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
%Por cada imagen en la base de datos
j = 0;
for i = ImageList
    %incremento
    j = j+1;
    %variable de asistencia
    temporal = i{1};
    %transforma cell array  -> char
    nombreImagen = char(temporal);
    %muestra el nombre
    %disp(nombreImagen);
    
    
    %separa el número de muestra del número de ciclos masticatorios
    temporal = strsplit(nombreImagen,'-');
    Muestra = str2num(char(temporal(1)));
    temporal = temporal(2);
    temporal = strsplit(char(temporal),'.');
    Ciclos = str2num(char(temporal(1)));
    
    %muestra el número de la muestra siendo procesada
    disp(Muestra);
    
    %Cargar la imagen
    ruta_imagen = strcat('../../database/',nombreImagen);
    estructura_imagen.imagen = imread(ruta_imagen);
    
    %redimensiona la imágen
    estructura_imagen.imagen = imresize(estructura_imagen.imagen, [300 NaN]);
    
    %Segmenta la imagen
    [estructura_imagen.suave, estructura_imagen.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen.imagen,hs,hr,minreg);
    
    %Extrae características
    linea_caracteristicas  = MPAT_SECOND( estructura_imagen, umbral );
    
    %registra la linea en la matriz de entrenamiento
    matriz_entrenamiento(j,:) = linea_caracteristicas;
    salidas_esperadas(j) = Ciclos;
end

%CAMBIAR ESTO
%matriz_entrenamiento = 0;
end

