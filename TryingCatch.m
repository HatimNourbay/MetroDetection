clear all;
close all;

addpath(genpath('PreAnalysis'));
addpath(genpath('FinalAnalysis'));
load('Test.mat');
load('FilterBySubNum');

BDLine = 72;
numberBD = num2str(BD(BDLine,1));
MetroLine = BD(BDLine,6);
%MetroLine = 1;

imStr = strcat('BD/IM (',numberBD,').JPG');

im = im2double(imread (imStr));

im = WhiteElimintation(im);

imHSV = rgb2hsv(im);
    

figure;
imshow(im);

tic;
getFinalBoundBox = ExtractHueCircle(im,MetroLine);
toc

[row, column] = size(getFinalBoundBox);

if (isempty(getFinalBoundBox))    
else
    tic;
    for d = 1:row
        croppedVerification = imcrop(imHSV,getFinalBoundBox(d,:));
        [imPart, numPart] = ExtractImPart(croppedVerification);
        figure;
        imshow(imPart);
    end 
    toc
end



