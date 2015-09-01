function [ matriz_entrenamiento, salidas_esperadas, nombresArchivos ] = entrenar_batchPARCIRCU(dataPath, hs, hr, minreg, umbral, signo, formato )
%entrenar_batch Genera los conjuntos de Entradas y Salidas para el etrenamiento supervisado de una red neuronal a partir de una base de
%datos de imágenes

%Añade al path
addpath(dataPath,'../../database/','../../databaseEcu2/A/','../captura/','../estadistica/','../extraccion/','../interfaz/','../representacion/','../scripts/','../segmentacion/','../extraccion/circular/');
%Obtiene la lista de imagenes en el directorio
rutaGenerica = strcat(dataPath,'*.',formato);
ImageList = getAllImages(rutaGenerica); %'../../databaseEcu2/A/*.tif');
dime = size(ImageList);
total_muestras = dime(2);

%Declaración de variables

matriz_entrenamiento = zeros(total_muestras, 121);
salidas_esperadas = zeros(total_muestras,1);
nombresArchivos = cell(total_muestras,1);


%Por cada imagen en la base de datos
j = 0;

%Matlab Pool
if isempty(gcp('nocreate'))
    parpool(2);
end
parfor i = 1:total_muestras
    
    estructura_imagen=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    %incremento
    % = j+1;
    %variable de asistencia
    temporal = ImageList(i);
    %transforma cell array  -> char
    nombreImagen = char(temporal);
    %muestra el nombre
    nombresArchivos{i}=nombreImagen
    
        
    %separa el número de muestra del número de ciclos masticatorios
    temporal = strsplit(nombreImagen,'-');
    Muestra = str2num(char(temporal(1)));
    temporal = temporal(2);
    temporal = strsplit(char(temporal),'.');
    Ciclos = str2num(char(temporal(1)));
    
    %muestra el número de la muestra siendo procesada
    disp(Muestra);
    
    %Cargar la imagen
    ruta_imagen = strcat(dataPath, nombreImagen);%'../../databaseEcu2/A/'
    
    ImgInicial = imread(ruta_imagen);
    ComponenteR = ImgInicial(:,:,1);
    ComponenteG = ImgInicial(:,:,2);
    ComponenteB = ImgInicial(:,:,3);
    estructura_imagen.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);

    
    %redimensiona la imágen
    estructura_imagen.imagen = imresize(estructura_imagen.imagen, [300 NaN]);
    
    %Segmenta la imagen
    [estructura_imagen.suave, estructura_imagen.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen.imagen,hs,hr,minreg);
    
    %Extrae características
    %linea_caracteristicas=zeros(1,120);
    linea_caracteristicas  = MPAT_CIRC( estructura_imagen, umbral, signo );
    tama = size(linea_caracteristicas);
    
    %registra la linea en la matriz de entrenamiento
    matriz_entrenamiento(i,:) = linea_caracteristicas(1,1:tama(2));
    salidas_esperadas(i) = Ciclos;
    
end

%CAMBIAR ESTO
%matriz_entrenamiento = 0;

%matlabpool close
end

