function [ B, dev, stats ] = RegresionMultivariada( MisEntradas, MisCategorias, MiIndexColumna  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
MI_X = MisEntradas(MiIndexColumna,:)';
[B,dev,stats] = mnrfit(MI_X,MisCategorias, 'Model', 'ordinal');

end

