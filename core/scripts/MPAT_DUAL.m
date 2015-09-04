function [ linea ] = MPAT_DUAL( EstImA, umbral_A, EstImB, umbral_B, signo )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    A_Nrgb_c=struct('r',0,'g',0,'b',0);
    A_iLuv_c=struct('L',0,'u',0,'v',0);
    A_RGB_c=struct('R',0,'G',0,'B',0);
    A_HSV_c=struct('H',0,'S',0,'V',0);
    
    B_Nrgb_c=struct('r',0,'g',0,'b',0);
    B_iLuv_c=struct('L',0,'u',0,'v',0);
    B_RGB_c=struct('R',0,'G',0,'B',0);
    B_HSV_c=struct('H',0,'S',0,'V',0);

    %Genera copias de la imagen original en LUV y Nrgb
    A_iLuv=RGB2Luv(EstImA.imagen);
    A_Nrgb=normRGB(EstImA.imagen);
    A_HSV=rgb2hsv(EstImA.imagen);
    B_iLuv=RGB2Luv(EstImB.imagen);
    B_Nrgb=normRGB(EstImB.imagen);
    B_HSV=rgb2hsv(EstImB.imagen);

    %Separa los canales
    A_iLuv_c.L=A_iLuv(:,:,1);
    A_iLuv_c.u=A_iLuv(:,:,2);
    A_iLuv_c.v=A_iLuv(:,:,3);
    A_Nrgb_c.r=A_Nrgb(:,:,1);
    A_Nrgb_c.g=A_Nrgb(:,:,2);
    A_Nrgb_c.b=A_Nrgb(:,:,3);
    A_RGB_c.R=EstImA.imagen(:,:,1);
    A_RGB_c.G=EstImA.imagen(:,:,2);
    A_RGB_c.B=EstImA.imagen(:,:,3);
    A_HSV_c.H=A_HSV(:,:,1);
    A_HSV_c.S=A_HSV(:,:,2);
    A_HSV_c.V=A_HSV(:,:,3);
    
    B_iLuv_c.L=B_iLuv(:,:,1);
    B_iLuv_c.u=B_iLuv(:,:,2);
    B_iLuv_c.v=B_iLuv(:,:,3);
    B_Nrgb_c.r=B_Nrgb(:,:,1);
    B_Nrgb_c.g=B_Nrgb(:,:,2);
    B_Nrgb_c.b=B_Nrgb(:,:,3);
    B_RGB_c.R=EstImB.imagen(:,:,1);
    B_RGB_c.G=EstImB.imagen(:,:,2);
    B_RGB_c.B=EstImB.imagen(:,:,3);
    B_HSV_c.H=B_HSV(:,:,1);
    B_HSV_c.S=B_HSV(:,:,2);
    B_HSV_c.V=B_HSV(:,:,3);

    %Selecciona los píxeles posiciones de los pixeles del área de
    %interés, por cada canal separado.
    alterno_A=EstImA.suave(:,:,2);
    alterno_B=EstImB.suave(:,:,2);
    if(strcmp(signo, 'menor') == 1)
        mascara_A = (alterno_A<umbral_A);
        mascara_B = (alterno_B<umbral_B);
    else
        mascara_A = (alterno_A>umbral_A);
        mascara_B = (alterno_B>umbral_B);
    end

    RGB_wR=[A_RGB_c.R(mascara_A);B_RGB_c.R(mascara_B)];
    RGB_wG=[A_RGB_c.G(mascara_A);B_RGB_c.G(mascara_B)];
    RGB_wB=[A_RGB_c.B(mascara_A);B_RGB_c.B(mascara_B)];
    iLuv_wL=[A_iLuv_c.L(mascara_A);B_iLuv_c.L(mascara_B)];
    iLuv_wu=[A_iLuv_c.u(mascara_A);B_iLuv_c.u(mascara_B)];
    iLuv_wv=[A_iLuv_c.v(mascara_A);B_iLuv_c.v(mascara_B)];
    Nrgb_wr=[A_Nrgb_c.r(mascara_A);B_Nrgb_c.r(mascara_B)];
    Nrgb_wg=[A_Nrgb_c.g(mascara_A);B_Nrgb_c.g(mascara_B)];
    Nrgb_wb=[A_Nrgb_c.b(mascara_A);B_Nrgb_c.b(mascara_B)];
    HSV_wH=[A_HSV_c.H(mascara_A);B_HSV_c.H(mascara_B)];
    HSV_wS=[A_HSV_c.S(mascara_A);B_HSV_c.S(mascara_B)];
    HSV_wV=[A_HSV_c.V(mascara_A);B_HSV_c.V(mascara_B)];
    
    %Estadísticas circulares
    [ cvarh ] = CirVar( HSV_wH );
    
    %Extraer caracteristicas de cada grupo y las registra en una
    %fila de la matriz de características
    linea=[extraerCaracteristicas(RGB_wR), extraerCaracteristicas(RGB_wG), extraerCaracteristicas(RGB_wB),extraerCaracteristicas(iLuv_wL),extraerCaracteristicas(iLuv_wu),extraerCaracteristicas(iLuv_wv),extraerCaracteristicas(Nrgb_wr),extraerCaracteristicas(Nrgb_wg),extraerCaracteristicas(Nrgb_wb),extraerCaracteristicas(HSV_wH),extraerCaracteristicas(HSV_wS),extraerCaracteristicas(HSV_wV), cvarh];


    

end

