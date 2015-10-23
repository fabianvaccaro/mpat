function [ fvect ] = extraerCaracteristicas( input_image )
%EXTRAERCARACTERISTICAS Extrae un set de caracteristicas de una imagen de
%escalas de valor
addpath(genpath('./core/'));

%media
fvect(1)= mean(input_image);

%varianza
fvect(2)=var(double(input_image));

%picos más altos del histograma
[pmax1,vmax1,pmax2,vmax2]=dosmax(hist(smooth(double(input_image),256)));
%primer pico más alto
fvect(3) = pmax1;
fvect(4) = vmax1;
%segundo pico más alto
fvect(5) = pmax2;
fvect(6) = vmax2;

%computo del histograma
HISTO = hist(double(input_image),100);

%varianza del histograma
fvect(7) = var(HISTO);

%skewness del histograma
fvect(8) = skewness(HISTO);

%Entropía del histograma
fvect(9) = entropy(HISTO);

%energía del histograma
fvect(10) = energia(HISTO);
end

