function [p,tbl,stats, results, means, RHO,PVAL, Mmean, Mmed, Mstd, CI] = EstadisticosEVFs( EVFs_Divided, EVF_index, Clases )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%Numero de clases
CS = size(EVFs_Divided);
NC = CS(3);
%Numero de muestras
NM = CS(1);
MatrizAnalisis = [];
for i=1:NC
    MatrizAnalisis = [MatrizAnalisis  EVFs_Divided(:,EVF_index,i)];
end
hold on;
[p,tbl,stats] = anova1(MatrizAnalisis,[],'off');

[results,means] = multcompare(stats,'CType','bonferroni','Display','off');

%Correlacion de Spearman y Confidence Interval
MatrizCorrelacion = [];
CI = [];
cont = 1;
for i=Clases'
    MatrizCorrelacion = [MatrizCorrelacion; MatrizAnalisis(:,cont) ones(NM,1)*i];
    SEM = std(MatrizAnalisis(:,cont))/sqrt(length(MatrizAnalisis(:,cont)));               % Standard Error
    ts = tinv([0.025  0.975],length(MatrizAnalisis(:,cont))-1);      % T-Score
    ci = mean(MatrizAnalisis(:,cont)) + ts*SEM;
    CI = [CI;ci];
    cont = cont+1;
end


[RHO,PVAL] = corr(MatrizCorrelacion(:,1),MatrizCorrelacion(:,2),'Type','Spearman');
Mmean = mean(MatrizAnalisis);
Mmed = median(MatrizAnalisis);
Mstd = std(MatrizAnalisis);

end

