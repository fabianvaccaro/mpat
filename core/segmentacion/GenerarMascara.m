function [ mascara, distancias ] = GenerarMascara( fimg )
%GENERARMASCARA Summary of this function goes here
%   Detailed explanation goes here
lab = rgb2lab(nLuv2RGB(fimg));
db = double(lab);
tamano = size(db);
r = fix(tamano(1)/10);
k = 40;
H = tamano(1);
W = tamano(2);
centroH = fix(H/2);
centroW = fix(W/2);

pLab = zeros(1,3);

%Encuentra el color medio de las esquinas
for i=1:3
    dbp = db(:,:,i);
    w1 = dbp(1:r,1:r);
    w2 = dbp(1:r,W-r:W);
    w3 = dbp(H-r:H, W-r:W);
    w4 = dbp(H-r:H,1:r);
    
    m = (mean2(w1)+mean2(w2)+mean2(w3)+mean2(w4))/4;
    pLab(i) = m;
end


%Genera la matriz de distancias euclideas
euclideas = zeros(tamano(1), tamano(2));
for i = 1:tamano(1)
   for j = 1:tamano(2)
       d = sqrt((lab(i,j,1)-pLab(1))^2+(lab(i,j,2)-pLab(2))^2+(lab(i,j,3)-pLab(3))^2);
       euclideas(i,j) = d;
   end
end

%Calcula la desviaci�n de las ventanas
w1 = euclideas(1:r,1:r);
w2 = euclideas(1:r,W-r:W);
w3 = euclideas(H-r:H, W-r:W);
w4 = euclideas(H-r:H,1:r);
w = [w1(:) ; w2(:) ; w3(:) ; w4(:)];
s = std2(w);
m = mean2(w);

disp(s);
disp(m);

if(abs(s)>0)
    zwt = (euclideas - m) / s;
    %Genera la matriz de distancias relativas
    distancias = zeros(tamano(1), tamano(2));
    for i = 1:tamano(1)
       for j = 1:tamano(2)

           d = zwt(i,j);

           if(d > s)
               g = log(4*s*d);

           else
               g = d;
           end


           distancias(i,j) = g;

       end
    end
else
%     zwt = euclideas;
    distancias = euclideas;
    distancias(abs(distancias)>0) = 1;
end



%Calcular el umbral????

%Genera la matriz de m�scara
nrows = size(distancias,1);
ncols = size(distancias,2);
ab = reshape(distancias,nrows*ncols,1);
[clusters_idx, cluster_center] = kmeans(ab, 2, 'distance', 'sqeuclidean','Replicates',3);
mascara = reshape(clusters_idx,nrows,ncols);


%selecciona la regi�n central
BW = im2bw(mascara,1);
BW = ~BW;
BW2 = bwselect(BW);
mascara = BW2;

