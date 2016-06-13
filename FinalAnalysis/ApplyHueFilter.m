function [imFiltered, result] = ApplyHueFilter(imgSrc,MetroLine)

addpath(genpath('PreAnalysis'));
load('Test.mat');
load('FilterBySubNum');

im = imgSrc;
imHSV = rgb2hsv(im);
imGray = rgb2gray(im);

[H, W, map] = size(im);
imCopy = zeros(H,W);

for x = 1:H
    for y = 1:W
        if (MetroLine ~= 7)
            if (imHSV(x,y,1) > FilterBySubNum(MetroLine,2)) && (imHSV(x,y,1) < FilterBySubNum(MetroLine,3))
                imCopy(x,y) = imGray(x,y);
            end
        else
            if (imHSV(x,y,1) > FilterBySubNum(MetroLine,2)) && (imHSV(x,y,1) < FilterBySubNum(MetroLine,3))...
                    || (imHSV(x,y,1) > FilterBySubNum(MetroLine,4)) && (imHSV(x,y,1) < FilterBySubNum(MetroLine,5))
                imCopy(x,y) = imGray(x,y);
            end
        end
    end
end

imFiltered = imCopy;
% figure;
% imshow(imCopy);

L = bwlabel(imCopy,8);
stats = regionprops('table',L,'BoundingBox');
BoundB = stats.BoundingBox;

newBound = zeros();
i = 1;
for x = 1:length(BoundB)
    if (BoundB(x,3) > 50 && BoundB(x,3) < 1500 && BoundB(x,4) > 50 && BoundB(x,4) < 350)
        newBound(i,1:4) = BoundB(x,:);
        i = i + 1;
    end
end

result = newBound;

