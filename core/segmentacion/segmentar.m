function [fimg, labels, modes, regsize, grad, conf]= segmentar(imagen_original,hs,hr,m)
[fimg, labels, modes, regsize, grad, conf]= edison_wrapper(imagen_original,@RGB2Luv,'SpatialBandWidth',hs,'RangeBandWidth',hr,'MinimumRegionArea',m,'speedup',3);
end