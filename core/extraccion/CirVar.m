function [ cvarh ] = CirVar( HSV_wH )
%CIRCAR Summary of this function goes here
%   Detailed explanation goes here
alpha = circ_ang2rad(HSV_wH);
cvarh = circ_var(alpha);

end

