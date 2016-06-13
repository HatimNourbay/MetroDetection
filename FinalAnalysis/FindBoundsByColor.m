function tableBounds = FindBoundsByColor(im, MetroLine)

% numberBD = '56';
% imStr = strcat('BD/IM (',numberBD,').JPG'); 
% im = im2double(imread (imStr));
% MetroLine = 8;


addpath(genpath('PreAnalysis'));
addpath(genpath('FinalAnalysis'));

load('FilterBySubNum');

im = WhiteElimintation(im);    

% figure;
% imshow(im);

initTable = [];

tic;
[getFinalBoundBox, imHSVTreated] = ExtractHueCircle(im,MetroLine);
toc

[row, column] = size(getFinalBoundBox);

if (isempty(getFinalBoundBox))
else
    tic;
    for d = 1:row
        croppedVerification = imcrop(imHSVTreated,getFinalBoundBox(d,:));        
        [H, W, numCol] = size(croppedVerification);
        if H < 40 || W < 40
        else
            initTable = [initTable; MetroLine, getFinalBoundBox(d,:)];
        end
    end
    toc
end
tableBounds = initTable;


