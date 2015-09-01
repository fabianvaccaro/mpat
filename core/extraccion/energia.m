function ener=energia(histograma)
i=1;
suma=0;
for i=1:length(histograma)
    suma=double(suma)+(double(histograma(i)))^2;
end
ener=suma;
end
