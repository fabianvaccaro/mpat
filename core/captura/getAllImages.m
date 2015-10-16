function [ ImageList ] = getAllImages(directory)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dirData = dir(directory);
ImageList = {dirData.name};


end

