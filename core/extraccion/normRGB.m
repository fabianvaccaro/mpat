function imagen_normalizada=normRGB(imagenRGB)
compR=imagenRGB(:,:,1);
compG=imagenRGB(:,:,2);
compB=imagenRGB(:,:,3);
normR=0;
normG=0;
normB=0;
[culo1,culo2,culo3]=size(imagenRGB);
tamanio=culo1*culo2*culo3;
i=1;
j=1;
k=1;

    for i=1:culo1
        for j=1:culo2
            normR(i,j)=double(compR(i,j))/(double(compR(i,j))+double(compG(i,j))+double(compB(i,j)));
            normG(i,j)=double(compG(i,j))/(double(compR(i,j))+double(compG(i,j))+double(compB(i,j)));
            normB(i,j)=double(compB(i,j))/(double(compR(i,j))+double(compG(i,j))+double(compB(i,j)));
        end
        
        
    end

    

imagen_normalizada(:,:,1)=normR;
imagen_normalizada(:,:,2)=normG;
imagen_normalizada(:,:,3)=normB;

end