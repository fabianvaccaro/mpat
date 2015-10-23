function procesar_chicles()
estructura_imagen=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
est=struct('mean',0,'var',0,'entropy',0,'wave1',0,'wave2',0,'hist',0,'skewness',0,'kurtosis',0,'pmax1',0,'pmax2',0);
contador=1;
cadena=0;
origen='.JPG';
joder='consej';
principio='chicle';
archivo=0;
archivo2=0;
histogramaRGB=struct('R',0,'G',0,'B',0);
histogramaNrgb=struct('r',0,'g',0,'b',0);
histogramaLuv=struct('L',0,'u',0,'v',0);
Nrgb=0;
Nrgb_c=struct('r',0,'g',0,'b',0);
iLuv=0;
iLuv_c=struct('L',0,'u',0,'v',0);
RGB_c=struct('R',0,'G',0,'B',0);

% en caso de tener un set de imagenes diferente al original, cambiar el
% valor de contador
for contador=1:461
    cadena=strcat(joder,int2str(contador), origen);
    estructura_imagen.imagen=imread(cadena);
    [estructura_imagen.suave, estructura_imagen.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen.imagen,20,10,4);
    
    i=1;
    
%     iLuv=RGB2Luv(estructura_imagen.imagen);
    chancro=estructura_imagen.suave;

    
%     histogramaLuv.L=hist(single(iLuv(:,:,1)));
%     histogramaLuv.u=hist(single(iLuv(:,:,2)));
%     histogramaLuv.v=hist(single(iLuv(:,:,3)));
%     iLuv_c.L=iLuv(:,:,1);
%     iLuv_c.u=iLuv(:,:,2);
%     iLuv_c.v=iLuv(:,:,3);
    
    Nrgb=normRGB(estructura_imagen.imagen);
    
%     histogramaNrgb.r=hist(single(Nrgb(:,:,1)));
%     histogramaNrgb.g=hist(single(Nrgb(:,:,2)));
%     histogramaNrgb.b=hist(single(Nrgb(:,:,3)));
%     Nrgb_c.r=Nrgb(:,:,1);
%     Nrgb_c.g=Nrgb(:,:,2);
%     Nrgb_c.b=Nrgb(:,:,3);
%     
    histogramaRGB.R=hist(single(estructura_imagen.imagen(:,:,1)));
    histogramaRGB.G=hist(single(estructura_imagen.imagen(:,:,2)));
    histogramaRGB.B=hist(single(estructura_imagen.imagen(:,:,3)));
    RGB_c.R=estructura_imagen.imagen(:,:,1);
    RGB_c.G=estructura_imagen.imagen(:,:,2);
    RGB_c.B=estructura_imagen.imagen(:,:,3);
    
    for i=1:max(max(estructura_imagen.regiones))
    
%     iLuv_wL=iLuv_c.L(estructura_imagen.regiones==i);
%     iLuv_wu=iLuv_c.u(estructura_imagen.regiones==i);
%     iLuv_wv=iLuv_c.v(estructura_imagen.regiones==i);
%     
%     
%     Nrgb_wr=Nrgb_c.r(estructura_imagen.regiones==i);
%     Nrgb_wg=Nrgb_c.g(estructura_imagen.regiones==i);
%     Nrgb_wb=Nrgb_c.b(estructura_imagen.regiones==i);
    
    RGB_wR=RGB_c.R(estructura_imagen.regiones==i);
    RGB_wG=RGB_c.G(estructura_imagen.regiones==i);
    RGB_wB=RGB_c.B(estructura_imagen.regiones==i);
    
%     
%     %mean Luv    
%     estructura_imagen.features(i,1)=mean(iLuv_wL);
%     estructura_imagen.features(i,2)=mean(iLuv_wu);
%     estructura_imagen.features(i,3)=mean(iLuv_wv);
%     
%     %variance Luv
%     estructura_imagen.features(i,4)=var(iLuv_wL);
%     estructura_imagen.features(i,5)=var(iLuv_wu);
%     estructura_imagen.features(i,6)=var(iLuv_wv);
%     
%     %mean Nrgb
%     estructura_imagen.features(i,7)=mean(Nrgb_wr);
%     estructura_imagen.features(i,8)=mean(Nrgb_wg);
%     estructura_imagen.features(i,9)=mean(Nrgb_wb);
%     
%     %variance Nrgb
%     estructura_imagen.features(i,7)=var(Nrgb_wr);
%     estructura_imagen.features(i,8)=var(Nrgb_wg);
%     estructura_imagen.features(i,9)=var(Nrgb_wb);
%     
%     
%     %picos RGB
%     [pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(single(RGB_wR),256)));
%     estructura_imagen.features(i,10)=pmax1;
%     estructura_imagen.features(i,11)=vmax1;
%     estructura_imagen.features(i,12)=pmax2;
%     estructura_imagen.features(i,13)=vmax2;
%     
%     [pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(single(RGB_wG),256)));
%     estructura_imagen.features(i,14)=pmax1;
%     estructura_imagen.features(i,15)=vmax1;
%     estructura_imagen.features(i,16)=pmax2;
%     estructura_imagen.features(i,17)=vmax2;
%     
%     [pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(single(RGB_wB),256)));
%     estructura_imagen.features(i,18)=pmax1;
%     estructura_imagen.features(i,19)=vmax1;
%     estructura_imagen.features(i,20)=pmax2;
%     estructura_imagen.features(i,21)=vmax2;
%     
    %mean RGB    
    estructura_imagen.features(i,1)=mean(RGB_wR);
    estructura_imagen.features(i,2)=mean(RGB_wG);
    estructura_imagen.features(i,3)=mean(RGB_wB);
%     
%     %picos Nrgb
%     [pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(single(Nrgb_wr),256)));
%     estructura_imagen.features(i,22)=pmax1;
%     estructura_imagen.features(i,23)=vmax1;
%     estructura_imagen.features(i,24)=pmax2;
%     estructura_imagen.features(i,25)=vmax2;
%     
%     [pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(single(Nrgb_wg),256)));
%     estructura_imagen.features(i,26)=pmax1;
%     estructura_imagen.features(i,27)=vmax1;
%     estructura_imagen.features(i,28)=pmax2;
%     estructura_imagen.features(i,29)=vmax2;
%     
%     [pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(single(Nrgb_wb),256)));
%     estructura_imagen.features(i,30)=pmax1;
%     estructura_imagen.features(i,31)=vmax1;
%     estructura_imagen.features(i,32)=pmax2;
%     estructura_imagen.features(i,33)=vmax2;
%     
%     %variance hist RGB
%     estructura_imagen.features(i,34)=var(hist(single(RGB_wR),100));
%     estructura_imagen.features(i,35)=var(hist(single(RGB_wG),100));
%     estructura_imagen.features(i,36)=var(hist(single(RGB_wB),100));
%     
%     %variance hist Nrgb
%     estructura_imagen.features(i,37)=var(hist(single(Nrgb_wr),100));
%     estructura_imagen.features(i,38)=var(hist(single(Nrgb_wg),100));
%     estructura_imagen.features(i,39)=var(hist(single(Nrgb_wb),100));
%     
%     
%     %skewness hist RGB
%     estructura_imagen.features(i,40)=skewness(hist(single(RGB_wR),100));
%     estructura_imagen.features(i,41)=skewness(hist(single(RGB_wG),100));
%     estructura_imagen.features(i,42)=skewness(hist(single(RGB_wB),100));
%     
%     %skewness hist Nrgb
%     estructura_imagen.features(i,43)=skewness(hist(single(Nrgb_wr),100));
%     estructura_imagen.features(i,44)=skewness(hist(single(Nrgb_wg),100));
%     estructura_imagen.features(i,45)=skewness(hist(single(Nrgb_wb),100));
%     
%     %entropy hist RGB
%     estructura_imagen.features(i,46)=entropy(hist(single(RGB_wR),100));
%     estructura_imagen.features(i,47)=entropy(hist(single(RGB_wG),100));
%     estructura_imagen.features(i,48)=entropy(hist(single(RGB_wB),100));
%     
%     %entropy hist Nrgb
%     estructura_imagen.features(i,49)=entropy(hist(single(Nrgb_wr),100));
%     estructura_imagen.features(i,50)=entropy(hist(single(Nrgb_wg),100));
%     estructura_imagen.features(i,51)=entropy(hist(single(Nrgb_wb),100));
%     
%     
%     %energy hist RGB
%     
%     estructura_imagen.features(i,52)=energia(hist(single(RGB_wR),100));
%     estructura_imagen.features(i,53)=energia(hist(single(RGB_wG),100));
%     estructura_imagen.features(i,54)=energia(hist(single(RGB_wB),100));
%     
%     
%     %energy hist Nrgb
%     
%     estructura_imagen.features(i,55)=energia(hist(single(Nrgb_wr),100));
%     estructura_imagen.features(i,56)=energia(hist(single(Nrgb_wg),100));
%     estructura_imagen.features(i,57)=energia(hist(single(Nrgb_wb),100));
%     
%     
%     %wavelet analysis
%     
%     
%     [enerR,detalR]=wavener(hist(single(RGB_wR)));
%     [enerG,detalG]=wavener(hist(single(RGB_wG)));
%     [enerB,detalB]=wavener(hist(single(RGB_wB)));
%     
%     
%     [enerr,detalr]=wavener(hist(single(Nrgb_wr)));
%     [energ,detalg]=wavener(hist(single(Nrgb_wg)));
%     [enerb,detalb]=wavener(hist(single(Nrgb_wb)));
%     
%     
%     %wavelet energy RGB abs
%     estructura_imagen.features(i,58)=enerR;
%     estructura_imagen.features(i,59)=enerG;
%     estructura_imagen.features(i,60)=enerB;
%     
%     %wavelet energy RGB detail 1
%     estructura_imagen.features(i,61)=detalR(1);
%     estructura_imagen.features(i,62)=detalG(1);
%     estructura_imagen.features(i,63)=detalB(1);
%         
%     
%     %wavelet energy RGB detail 2
%     estructura_imagen.features(i,64)=detalR(2);
%     estructura_imagen.features(i,65)=detalG(2);
%     estructura_imagen.features(i,66)=detalB(2);
%     
%     
%     
%     %wavelet energy Nrgb abs
%     estructura_imagen.features(i,67)=enerr;
%     estructura_imagen.features(i,68)=energ;
%     estructura_imagen.features(i,69)=enerb;
%     
%     %wavelet energy Nrgb detail 1
%     estructura_imagen.features(i,70)=detalr(1);
%     estructura_imagen.features(i,71)=detalg(1);
%     estructura_imagen.features(i,72)=detalb(1);
%         
%     
%     %wavelet energy Nrgb detail 2
%     estructura_imagen.features(i,73)=detalr(2);
%     estructura_imagen.features(i,74)=detalg(2);
%     estructura_imagen.features(i,75)=detalb(2);
%     
%     
     
     
    end
    
    [r2,c2]=find(estructura_imagen.features(:,3)>155);
    regiones=estructura_imagen.regiones;
    segmento=clasificar_chicle(regiones,r2);
    I=estructura_imagen.imagen(:,:,1);
    histolo=hist(smooth(single(I(segmento==1))),100);

    est.mean(contador)=mean(I(segmento==1));
    est.var(contador)=var(single(I(segmento==1)));
    est.entropy(contador)=entropy(I(segmento==1));
    
    [enerR,detalR]=wavener(histolo);
    est.wave1(contador)=detalR(1);
    est.wave2(contador)=detalR(2);
    
    est.hist(contador)=max(findpeaks(histolo));
    
    est.skewness(contador)=skewness(histolo);
    est.kurtosis(contador)=kurtosis(histolo);
    [pmax1,vmax1,pmax2,vmax2]=dosmax(histolo);
    est.pmax1(contador)=pmax1;
    est.pmax2(contador)=pmax2;
    
    archivo=strcat(principio,int2str(contador));
    save(archivo,'I','segmento');
    
end
archivo2='resultados';
save(archivo2,'est');
end