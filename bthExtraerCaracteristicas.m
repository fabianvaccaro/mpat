function [caracteristicas,  tgres] = bthExtraerCaracteristicas()
addpath(genpath('./core/'));


Nrgb=[];
iLuv=[];
HSV=[];
lado = [];
imagen = [];
%Matriz de caracteristicas resultante
caracteristicas = [];
linea = [];



%Inicio y fin del batch
Inicio = 7;
Final = 300;

%Numero de muestras
NumMuestras = 8;

%Matriz de targets resultantes
tgres = [];
matlabpool(4);
parfor i=Inicio:Final
    Nrgb_c=struct('r',0,'g',0,'b',0);
    iLuv_c=struct('L',0,'u',0,'v',0);
    RGB_c=struct('R',0,'G',0,'B',0);
    HSV_c=struct('H',0,'S',0,'V',0);
    tgrow = 0;
    %Itera entre el número de muestras por paciente
    for j=1:NumMuestras
        
        
        if j==NumMuestras
            contador=25;
        else
            contador=j*3;
        end
        [i, contador]
        paciente= sprintf('%03d',i);
        
        cadenaA=strcat('./database/',paciente,'-',int2str(contador),'-A.mat');
        cadenaB=strcat('./database/',paciente,'-',int2str(contador),'-B.mat');
        
        %Carga las imagenes de ambas caras de una muestra
        ladoA=load(cadenaA);
        ladoB=load(cadenaB);
        
        %Resetea la linea a insertarse en la matriz de caracteristicas
        linea = [];
        
        
        %itera el procesamiento entre ambas caras
        for lado=1:2
            if lado==1
                muestra = ladoA;
            else
                muestra = ladoB;
            end 
            %Genera copias de la imagen original en LUV y Nrgb
            iLuv=RGB2Luv(muestra.echicle.imagen);
            Nrgb=normRGB(muestra.echicle.imagen);
            HSV=rgb2hsv(muestra.echicle.imagen);
            
            %Separa los canales
            iLuv_c.L=iLuv(:,:,1);
            iLuv_c.u=iLuv(:,:,2);
            iLuv_c.v=iLuv(:,:,3);
            Nrgb_c.r=Nrgb(:,:,1);
            Nrgb_c.g=Nrgb(:,:,2);
            Nrgb_c.b=Nrgb(:,:,3);
            RGB_c.R=muestra.echicle.imagen(:,:,1);
            RGB_c.G=muestra.echicle.imagen(:,:,2);
            RGB_c.B=muestra.echicle.imagen(:,:,3);
            HSV_c.H=HSV(:,:,1);
            HSV_c.S=HSV(:,:,2);
            HSV_c.V=HSV(:,:,3);
                        
            %Selecciona los píxeles posiciones de los pixeles del área de
            %interés, por cada canal separado.
            alterno=muestra.echicle.fimg(:,:,2);
            
            RGB_wR=RGB_c.R(alterno>3.1);
            RGB_wG=RGB_c.G(alterno>3.1);
            RGB_wB=RGB_c.B(alterno>3.1);
            iLuv_wL=iLuv_c.L(alterno>3.1);
            iLuv_wu=iLuv_c.u(alterno>3.1);
            iLuv_wv=iLuv_c.v(alterno>3.1);
            Nrgb_wr=Nrgb_c.r(alterno>3.1);
            Nrgb_wg=Nrgb_c.g(alterno>3.1);
            Nrgb_wb=Nrgb_c.b(alterno>3.1);
            HSV_wH=HSV_c.H(alterno>3.1);
            HSV_wS=HSV_c.S(alterno>3.1);
            HSV_wV=HSV_c.V(alterno>3.1);
            
            %Extraer caracteristicas de cada grupo y las registra en una
            %fila de la matriz de características
            linea=[linea, extraerCaracteristicas(RGB_wR), extraerCaracteristicas(RGB_wG), extraerCaracteristicas(RGB_wB),extraerCaracteristicas(iLuv_wL),extraerCaracteristicas(iLuv_wu),extraerCaracteristicas(iLuv_wv),extraerCaracteristicas(Nrgb_wr),extraerCaracteristicas(Nrgb_wg),extraerCaracteristicas(Nrgb_wb),extraerCaracteristicas(HSV_wH),extraerCaracteristicas(HSV_wS),extraerCaracteristicas(HSV_wV)];
            
        end
        
        %Inserta la linea en la matriz de características
        caracteristicas = [caracteristicas; linea];
        
        %limpia la linea
        linea = [];
        
        
        %Inserta una fila en la matriz de targets
        tgrow = tgrow + 1;
        exarow = [0,0,0,0,0,0,0,0];
        exarow(j) = 1;
        tgres = [tgres;exarow];
 
    end
    
end
matlabpool close
end