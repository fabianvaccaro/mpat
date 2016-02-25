function [ mascara, densit] = recortarNuevo( fimg )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

lab = rgb2lab(mLuv2RGB(fimg));
uL = calcularUmbral(lab(:,:,1));
ua = calcularUmbral(lab(:,:,2));
ub = calcularUmbral(lab(:,:,3));

len = size(fimg);
mascara = zeros(len(1),len(2));
densit = zeros(len(1),len(2));
for i=1:len(1)
    for j=1:len(2)
        d = sqrt((fimg(i,j,1)-uL)^2+(fimg(i,j,2)-ua)^2+(fimg(i,j,3)-ub)^2);
        densit(i,j)=d;
        if(d>10)
            mascara(i,j) = 1;
        end
    end
end


end

