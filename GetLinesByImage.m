%close all;
%clear all;

load('Test.mat');
addpath(genpath('FinalAnalysis'));

% BDLine = 72;
% numberBD = num2str(BD(BDLine,1));

numberBD = '203';
imStr = strcat('BD/IM (',numberBD,').JPG');

im = im2double(imread (imStr));
figure;
imshow(im);


% tableColorsBound = [];
% 
% for x = 1:14
%     tableImages = FindBoundsByColor(im,x);
%     tableColorsBound = [tableColorsBound; tableImages];
% end

finalTable = [];

for x = 1:length(tableColorsBound)
    imCropped = imcrop(im,tableColorsBound(x,2:5));
    %figure;
    %imshow(imCropped);
    if (tableColorsBound(x,1)>=1 & tableColorsBound(x,1)<10)
        if NumEvaluation(imCropped,tableColorsBound(x,1)) == 1
            finalTable = [finalTable; tableColorsBound(x,:)];
        end
    end
end
    

