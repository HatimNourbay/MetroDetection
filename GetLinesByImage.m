close all;
clear all;

load('Test.mat');
addpath(genpath('FinalAnalysis'));

% BDLine = 72;
% numberBD = num2str(BD(BDLine,1));

numberBD = '56';
imStr = strcat('BD/IM (',numberBD,').JPG');

im = im2double(imread (imStr));
figure;
imshow(im);


tableColorsBound = [];

for x = 1:14
    tableImages = FindBoundsByColor(im,x);
    tableColorsBound = [tableColorsBound; tableImages];
end

for x = 1:length(tableColorsBound)
    imCropped = imcrop(im,tableColorsBound(x,2:5));
    imCropped = rgb2hsv(imCropped);
    figure;
    imshow(imCropped);
    NumEvaluation(imCropped);
end
    

