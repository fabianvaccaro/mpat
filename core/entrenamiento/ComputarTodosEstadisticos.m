function [ StRes ] = ComputarTodosEstadisticos( M3, M9, M15, M21, M27 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
StRes = struct('descriptivos', zeros(120,15),'KolmogorovSmirnov', zeros(120,1),'ANOVA_P', zeros(120,1),'ANOVA_TBL', zeros(120,6),'ANOVA_TBL_ORD', zeros(120,6), 'SP_RHO', zeros(120,1), 'SP_P', zeros(120,1),'BONFF', zeros(10,6,120), 'DES_ORD', zeros(120,15),'SP_RHO_TBL', zeros(120,1), 'SP_P_TBL', zeros(120,1));
descriptivos = zeros(120,15);
KolmogorovSmirnov =  zeros(120,1);
ANOVA_P = zeros(120,1);
ANOVA_TBL = zeros(120,6);
SP_RHO = zeros(120,1);
SP_P = zeros(120,1);
BONFF = zeros(10,6,120);

if isempty(gcp('nocreate'))
    parpool(6);
end
parfor i=1:120
    [p,tbl,~, results, ~, RHO,PVAL, Mmean, Mmed, Mstd] = analizarEstadisticos( M3, M9, M15, M21, M27, i );
    lDescr = [Mmean(1) Mmed(1) Mstd(1) Mmean(2) Mmed(2) Mstd(2) Mmean(3) Mmed(3) Mstd(3) Mmean(4) Mmed(4) Mstd(4) Mmean(5) Mmed(5) Mstd(5)];
    descriptivos(i,:) = lDescr;
    ANOVA_P(i,:) = p;
    lTbl = [cell2mat(tbl(2,2)) cell2mat(tbl(2,4)) cell2mat(tbl(3,2)) cell2mat(tbl(3,4)) cell2mat(tbl(2,5)) cell2mat(tbl(2,6))];
    ANOVA_TBL(i,:) = lTbl;
    BONFF(:,:,i) = results;
    SP_RHO(i,:) = RHO;
    SP_P(i,:) = PVAL;
    
end

StRes.descriptivos = descriptivos;
StRes.KolmogorovSmirnov = KolmogorovSmirnov;
StRes.ANOVA_P = ANOVA_P;
StRes.ANOVA_TBL = ANOVA_TBL;
StRes.SP_RHO = SP_RHO;
StRes.SP_P = SP_P;
StRes.BONFF = BONFF;

orden = [1 11 21 31 41 51 91 101 111 61 71 81   2 12 22 32 42 52 92 102 112 62 72 82   1 13 23 33 43 53 93 103 113 63 73 83   4 14 24 34 44 54 94 104 114 64 74 84   5 15 25 35 45 55 95 105 115 65 75 85   6 16 26 36 46 56 96 106 116 66 76 86   7 17 27 37 47 57 97 107 117 67 77 87   8 18 28 38 48 58 98 108 118 68 78 88   9 19 29 39 49 59 99 109 119 69 79 89   10 20 30 40 50 60 100 110 120 70 80 90 ];

cont = 0;
for j=orden
    disp(j);
    
    cont = cont+1;
    StRes.DES_ORD(cont, :) = descriptivos(j,:);
    StRes.ANOVA_TBL_ORD(cont,:) = ANOVA_TBL(j,:);
    StRes.SP_RHO_TBL(cont,:) = SP_RHO(j,:);
    StRes.SP_P_TBL(cont,:) = SP_P(j,:);
end

end

