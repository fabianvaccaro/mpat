function [p,tbl,stats, results, means, RHO,PVAL, Mmean, Mmed, Mstd] = analizarEstadisticos( M3, M9, M15, M21, M27, COLUMNA )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%Numero de muestras a considerar
N = 200;

MatrizAnalisis = [M3(1:N,COLUMNA) M9(1:N,COLUMNA) M15(1:N,COLUMNA) M21(1:N,COLUMNA) M27(1:N,COLUMNA)];
[p,tbl,stats] = anova1(MatrizAnalisis,[],'off');
[results,means] = multcompare(stats,'CType','bonferroni','Display','off');
MatrizCorrelacion = [MatrizAnalisis(:,1) ones(200,1)*3; MatrizAnalisis(:,2) ones(200,1)*9; MatrizAnalisis(:,3) ones(200,1)*15; MatrizAnalisis(:,4) ones(200,1)*21;MatrizAnalisis(:,5) ones(200,1)*27];
[RHO,PVAL] = corr(MatrizCorrelacion(:,1),MatrizCorrelacion(:,2),'Type','Spearman');
Mmean = mean(MatrizAnalisis);
Mmed = median(MatrizAnalisis);
Mstd = std(MatrizAnalisis);
end

