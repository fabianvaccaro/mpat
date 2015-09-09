function [ StRes ] = BernchmarkEVFs( EVFs_Matrix, DesiredOutputs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%determina la cantidad de clases o salidas diferentes
clases = unique(DesiredOutputs);
CantidadDeClases = length(clases);
tm = size(EVFs_Matrix);
CantidadDeEVFs = tm(2);
tm = size(DesiredOutputs);
CantidadDeSalidas = tm(1);

%Numero mínimo de muestras por clase
minimal = CantidadDeSalidas;
for i=clases'
    m = size(EVFs_Matrix(DesiredOutputs==i,:));
    if(m(1)<minimal)
        minimal = m(1);
    end
end

%divide la matriz de EVFs en clases y verifica que todas las clases tengan el mismo número de muestras

EVFs_Divided = [];
cont = 1;
for i=clases'
    tmp = EVFs_Matrix(DesiredOutputs==i,:);
    EVFs_Divided(:,:,cont)= tmp(1:minimal,:);
    cont = cont+1;
end




%Declaración de estructura
StRes = struct('descriptivos', [],'KolmogorovSmirnov', [],'ANOVA_P', [],'ANOVA_TBL', [],'ANOVA_TBL_ORD', [], 'SP_RHO', [], 'SP_P', [],'BONFF', [], 'DES_ORD',[],'SP_RHO_TBL', [], 'SP_P_TBL', []);
descriptivos = zeros(CantidadDeClases,3,CantidadDeEVFs);
KolmogorovSmirnov =  zeros(CantidadDeEVFs,1);
ANOVA_P = zeros(CantidadDeEVFs,1);
ANOVA_TBL = zeros(CantidadDeEVFs,6);
SP_RHO = zeros(CantidadDeEVFs,1);
SP_P = zeros(CantidadDeEVFs,1);
tm = size(combnk(clases,2));
BONFF = zeros(tm(1),6,CantidadDeEVFs);
ci = zeros(CantidadDeClases,2,CantidadDeEVFs);

for i=1:CantidadDeEVFs
    [p,tbl,~, results, ~, RHO,PVAL, Mmean, Mmed, Mstd, CI] = EstadisticosEVFs( EVFs_Divided, i, clases );
    lDescr = zeros(CantidadDeClases,3);
    for j=1:CantidadDeClases
        lDescr(j,1) = Mmean(j);
        lDescr(j,2) = Mmed(j);
        lDescr(j,3) = Mstd(j);
    end
    descriptivos(:,:,i) = lDescr;
    ANOVA_P(i,:) = p;
    lTbl = [cell2mat(tbl(2,2)) cell2mat(tbl(2,4)) cell2mat(tbl(3,2)) cell2mat(tbl(3,4)) cell2mat(tbl(2,5)) cell2mat(tbl(2,6))];
    ANOVA_TBL(i,:) = lTbl;
    BONFF(:,:,i) = results;
    SP_RHO(i,:) = RHO;
    SP_P(i,:) = PVAL;
    ci(:,:,i)=CI;
    
end

StRes.descriptivos = descriptivos;
StRes.KolmogorovSmirnov = KolmogorovSmirnov;
StRes.ANOVA_P = ANOVA_P;
StRes.ANOVA_TBL = ANOVA_TBL;
StRes.SP_RHO = SP_RHO;
StRes.SP_P = SP_P;
StRes.BONFF = BONFF;
StRes.CI = ci;

end