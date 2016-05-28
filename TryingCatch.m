%clear all;
%close all;


%load('Test.mat');
load('Apprentissage.mat');
load('FilterBySubNum');

numberBD = num2str(BD(29,1));

imStr = strcat('BD/IM (',numberBD,').JPG');
im = im2double(imread (imStr));
imHSV = rgb2hsv(im);

[H, W, map] = size(im);
imCopy = zeros(H,W);

for x = 1:H
    for y = 1:W
        if (imHSV(x,y,1) > FilterBySubNum(11,2)) && (imHSV(x,y,1) < FilterBySubNum(11,3))
            imCopy(x,y) = imHSV(x,y);
        end
    end
end

imCrop = zeros();

h = 1;
for x = 1:H - 7 
    for y = 1:W - 7
        h = 1;
        if (imCopy(x,y) ~= 0)
            while (sum(any(imCopy(x:x+7,y:y+7))) ~= 0) && x+7 < H && y+7 < W 
                imCrop(h,1:3) = [h,x,y];
                imCopy(x,y) = 0;
                x = x+1;
                y = y + 1;
                h = h+1;
            end
            break;
        end
    end
end



