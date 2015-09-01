function [X,Y,T,AUC, vectorScores, vectorDeseadas, vectorClasificadas, vectorPositivos,CP] = obtenerROC( scores, labels, posLabel )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%vectorScores = zeros(length(scores), 1);
vectorDeseadas = zeros(1, length(scores));
vectorClasificadas = zeros(1, length(scores));
vectorPositivos = zeros(1, length(scores));
vectorReales = zeros(1, length(scores));
vectorScores = scores(posLabel,:);
[totalClases, totalSamples] = size(scores);
labelClases = 1:totalClases;

for i = 1:length(labels)
    indiceLabel = find(labels(:,i)==1);
    vectorDeseadas(i) = indiceLabel;

    %Construir VectorClasificadas
    clamp=scores(:,i);
    valmax = max(clamp);
    indiceClasificada = find(clamp == valmax);
    vectorClasificadas(i) = indiceClasificada;
    if(indiceClasificada == indiceLabel)
        vectorPositivos(i)= 1;
    end

    if(indiceLabel == posLabel)
        vectorReales(i) = 1;
    end

end
[X,Y,T,AUC] = perfcurve(vectorDeseadas',vectorScores',posLabel, 'XVals',[0:0.02:1]);

figure('position',[300 300 250 250])
plot(X,Y, 'LineWidth',2)
xlabel('False positive rate')
ylabel('True positive rate')
title(strcat('ROC for Class #',num2str(posLabel)));

%analisis de sensibilidad y especificidad
negativos = labelClases;
negativos(posLabel)=[];
CP = classperf(vectorDeseadas, vectorClasificadas,'Positive', posLabel,'Negative', negativos);
end

