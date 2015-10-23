function [ linea ] = MPAT_CIRC( muestra, umbral, signo )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Nrgb_c=struct('r',0,'g',0,'b',0);
    iLuv_c=struct('L',0,'u',0,'v',0);
    RGB_c=struct('R',0,'G',0,'B',0);
    HSV_c=struct('H',0,'S',0,'V',0);

    %Genera copias de la imagen original en LUV y Nrgb
    iLuv=RGB2Luv(muestra.imagen);
    Nrgb=normRGB(muestra.imagen);
    HSV=rgb2hsv(muestra.imagen);

    %Separa los canales
    iLuv_c.L=iLuv(:,:,1);
    iLuv_c.u=iLuv(:,:,2);
    iLuv_c.v=iLuv(:,:,3);
    Nrgb_c.r=Nrgb(:,:,1);
    Nrgb_c.g=Nrgb(:,:,2);
    Nrgb_c.b=Nrgb(:,:,3);
    RGB_c.R=muestra.imagen(:,:,1);
    RGB_c.G=muestra.imagen(:,:,2);
    RGB_c.B=muestra.imagen(:,:,3);
    HSV_c.H=HSV(:,:,1);
    HSV_c.S=HSV(:,:,2);
    HSV_c.V=HSV(:,:,3);

    %Selecciona los píxeles posiciones de los pixeles del área de
    %interés, por cada canal separado.
    alterno=muestra.suave(:,:,2);
    if(strcmp(signo, 'menor') == 1)
        mascara = (alterno<umbral);
    else
        mascara = (alterno>umbral);
    end

    RGB_wR=RGB_c.R(mascara);
    RGB_wG=RGB_c.G(mascara);
    RGB_wB=RGB_c.B(mascara);
    iLuv_wL=iLuv_c.L(mascara);
    iLuv_wu=iLuv_c.u(mascara);
    iLuv_wv=iLuv_c.v(mascara);
    Nrgb_wr=Nrgb_c.r(mascara);
    Nrgb_wg=Nrgb_c.g(mascara);
    Nrgb_wb=Nrgb_c.b(mascara);
    HSV_wH=HSV_c.H(mascara);
    HSV_wS=HSV_c.S(mascara);
    HSV_wV=HSV_c.V(mascara);
    
    %Estadísticas circulares
    [ cvarh ] = CirVar( HSV_wH );
    
    %Extraer caracteristicas de cada grupo y las registra en una
    %fila de la matriz de características
    linea=[extraerCaracteristicas(RGB_wR), extraerCaracteristicas(RGB_wG), extraerCaracteristicas(RGB_wB),extraerCaracteristicas(iLuv_wL),extraerCaracteristicas(iLuv_wu),extraerCaracteristicas(iLuv_wv),extraerCaracteristicas(Nrgb_wr),extraerCaracteristicas(Nrgb_wg),extraerCaracteristicas(Nrgb_wb),extraerCaracteristicas(HSV_wH),extraerCaracteristicas(HSV_wS),extraerCaracteristicas(HSV_wV), cvarh];


    

end

