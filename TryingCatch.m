clear all;
close all;

addpath(genpath('PreAnalysis'));
load('Test.mat');
load('FilterBySubNum');

BDLine = 110;
numberBD = num2str(BD(BDLine,1));
%MetroLine = BD(BDLine,6);
MetroLine = 10;

imStr = strcat('BD/IM (',numberBD,').JPG');

im = im2double(imread (imStr));

newBound = ApplyHueFilter(im,MetroLine);


%figure;
%imshow(im);impixelinfo;

[row,column] = size(newBound);

if row > 1
    for k = 1 : length(newBound)
        rectangle('Position', [newBound(k,1),newBound(k,2),newBound(k,3),newBound(k,4)],...
        'EdgeColor','r','LineWidth',2 )
    end
else
    rectangle('Position', [newBound(1,1),newBound(1,2),newBound(1,3),newBound(1,4)],...
        'EdgeColor','r','LineWidth',2 )
end

