function [ pixel_labels ] = SimpleKmeans( imagenRGB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

rgb = [];
rgb(:,:,1) = imagenRGB(:,:,1);
rgb(:,:,2) = imagenRGB(:,:,2);
rgb(:,:,3) = imagenRGB(:,:,3);
rgb = imresize(rgb, [300 NaN]);

[fimg, labels, modes, regsize, grad, conf]= segmentar(rgb,10,4,2);
%fimg = RGB2Luv(rgb);

lab = rgb2lab(nLuv2RGB(fimg));
ab = double(lab(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 2;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', 'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
%imshow(pixel_labels,[]), title('image labeled by cluster index');
BW = im2bw(pixel_labels,1);
BW = ~BW;
%BW2 = bwselect(BW,150,150);
BW2 = bwselect(BW);
pixel_labels = BW2;


rgb = uint8(rgb);
imshow(rgb);
hold on;
contour(pixel_labels, 'LineWidth', 1.5, 'LineColor', 'magenta' );
end

