function [ matriz_entrenamiento, salidas_esperadas, nombresArchivos ] = ProcesarDirectorio(dataPath )
%limpia pantalla
clc
%Toma en cuenta ambos lados de la muestra
hs = 20;
hr = 10;
minreg = 4;
signo = 'mayor';
formato = 'tif';

%Añade al path
dataPath = strcat(dataPath, '\');
addpath(dataPath, '../../captura/','../../estadistica/','../../extraccion/','../../interfaz/','../../representacion/','../../scripts/','../../segmentacion/','../../extraccion/circular/');
%Obtiene la lista de imagenes en el directorio
rutaGenerica = strcat(dataPath,'*.',formato);
ImageList = getAllImages(rutaGenerica);
MuestrasPares = [];
dime = size(ImageList);

%Verificar que las muestras sean pares
for j =1:dime(2)
    temporal = ImageList(j);
    %transforma cell array  -> char
    nombreImagen = char(temporal);
    %separa el número de muestra
    temporal = strsplit(nombreImagen,'-');
    Muestra = str2num(char(temporal(1)));
    %separa el numero de ciclos
    Ciclos = str2num(char(temporal(2)));
    %separa el lado
    temporal = temporal(3);
    temporal = strsplit(char(temporal),'.');
    Lado = char(temporal(1));
    
    %verifica si existe la pareja
    if(Lado=='A')
        pareja_N = strcat(int2str(Muestra),'-',int2str(Ciclos),'-B.tif');
        pareja_H = strcat(sprintf('%03d',Muestra),'-',int2str(Ciclos),'-B.tif');
        if exist(pareja_N, 'file') == 2 || exist(pareja_H, 'file') == 2
            %añade la muestra a la lista para su analisis
            MuestrasPares = [MuestrasPares ; Muestra, Ciclos];
        end
    end
    
    
end

%el total de muestras es la cantidad de parejas existentes
total_muestras = size(MuestrasPares);
total_muestras = total_muestras(1);

%Declaración de variables

matriz_entrenamiento = zeros(total_muestras, 121);
salidas_esperadas = zeros(total_muestras,1);
nombresArchivos = cell(total_muestras,1);


%Por cada imagen en la base de datos


%Matlab Pool
if isempty(gcp('nocreate'))
    parpool(4);
end
i= 1;
parfor i = 1:total_muestras
    
    estructura_imagen_A=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    estructura_imagen_B=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    
    S = MuestrasPares(i,:);
    N= S(1);
    C = S(2);
    
    %muestra el número de la muestra siendo procesada
    disp(N);
    %Cargar las imagenes
    nombreImagenA = strcat(int2str(N),'-',int2str(C),'-A.tif');
    nombreImagenB = strcat(int2str(N),'-',int2str(C),'-B.tif');
    
    nombreImagenA_H = strcat(sprintf('%03d',N),'-',int2str(C),'-A.tif');
    nombreImagenB_H = strcat(sprintf('%03d',N),'-',int2str(C),'-B.tif');
    
    try
        ruta_imagenA = strcat(dataPath, nombreImagenA);
        ruta_imagenB = strcat(dataPath, nombreImagenB);
        ImgInicial_A = imread(ruta_imagenA);
        ImgInicial_B = imread(ruta_imagenB);
    catch
        ruta_imagenA = strcat(dataPath, nombreImagenA_H);
        ruta_imagenB = strcat(dataPath, nombreImagenB_H);
        ImgInicial_A = imread(ruta_imagenA);
        ImgInicial_B = imread(ruta_imagenB);
    end
    

    
    ComponenteR = ImgInicial_A(:,:,1);
    ComponenteG = ImgInicial_A(:,:,2);
    ComponenteB = ImgInicial_A(:,:,3);
    estructura_imagen_A.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);
    
    
    ComponenteR = ImgInicial_B(:,:,1);
    ComponenteG = ImgInicial_B(:,:,2);
    ComponenteB = ImgInicial_B(:,:,3);
    estructura_imagen_B.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);
    
    %redimensiona las imagenes
    estructura_imagen_A.imagen = imresize(estructura_imagen_A.imagen, [300 NaN]);
    estructura_imagen_B.imagen = imresize(estructura_imagen_B.imagen, [300 NaN]);
    
    %Segmenta las imagenes
    [estructura_imagen_A.suave, estructura_imagen_A.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen_A.imagen,hs,hr,minreg);
    [estructura_imagen_B.suave, estructura_imagen_B.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen_B.imagen,hs,hr,minreg);
    
    %Extrae características
    %linea_caracteristicas=zeros(1,120);
    umbral_A = calcularUmbral( estructura_imagen_A.suave(:,:,2) );
    umbral_B = calcularUmbral( estructura_imagen_B.suave(:,:,2) );
    
    linea_caracteristicas  = MPAT_DUAL( estructura_imagen_A, umbral_A,estructura_imagen_B, umbral_B, signo );
    tama = size(linea_caracteristicas);
    
    %registra la linea en la matriz de entrenamiento
    matriz_entrenamiento(i,:) = linea_caracteristicas(1,1:tama(2));
    salidas_esperadas(i) = C;
    
end

%CAMBIAR ESTO
%matriz_entrenamiento = 0;

%matlabpool close
end

