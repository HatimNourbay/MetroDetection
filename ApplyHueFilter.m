function result = ApplyHueFilter(imgSrc,MetroLine)

addpath(genpath('PreAnalysis'));
load('Test.mat');
load('FilterBySubNum');

im = im2double(imgSrc);
imHSV = rgb2hsv(im);
imGray = rgb2gray(im);

[H, W, map] = size(im);
imCopy = zeros(H,W);

for x = 1:H
    for y = 1:W
        if (imHSV(x,y,1) > FilterBySubNum(MetroLine,2)) && (imHSV(x,y,1) < FilterBySubNum(MetroLine,3))
            imCopy(x,y) = imGray(x,y);
        end
    end
end

figure;
imshow(imCopy);


L = bwlabel(imCopy);
stats = regionprops('table',L,'BoundingBox');
BoundB = stats.BoundingBox;

newBound = zeros();
i = 1;
for x = 1:length(BoundB)
    if (BoundB(x,3) > 50 && BoundB(x,3) < 1500 && BoundB(x,4) > 50 && BoundB(x,4) < 1500)
        newBound(i,1:4) = BoundB(x,:);
        i = i + 1;
    end
end

result = newBound;

