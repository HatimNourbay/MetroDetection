function result = NumEvaluation(croppedVerification, numToEvaluate)

load('tableRegions.mat');
imSprites = im2double(imread('PICTOBW/chiffresArial.png'));
result = 0;
[imPart, numPart] = ExtractImPart(croppedVerification);
if (isempty(imPart)) | (imPart == 0)
else
    
    imPart = rgb2gray(imPart);
    
    [H,W] = size(imPart);
    
    for x = 1:H
        for y = 1:W
            if imPart(x,y) == 0
                imPart(x,y) = 1;
            else
                imPart(x,y) = 0;
            end
        end
    end
    
    ci = [H/2, W/2, H/2 - 7];     % center and radius of circle ([c_row, c_col, r])
    [xx,yy] = ndgrid((1:H)-ci(1),(1:W)-ci(2));
    mask = ((xx.^2 + yy.^2)<ci(3)^2);
    croppedImage = imPart.*mask;
    
    imPart = croppedImage;
   
    L = bwlabel(imPart,8);
    stats = regionprops('table',L,'BoundingBox');
    BoundB = stats.BoundingBox;
    
    
    [temprow, tempcolumn] = size(BoundB);    
    
    for k = 1 : temprow
        imBounds = imcrop(imPart,BoundB(k,:));
        
        sizing = [tableRegions(numToEvaluate,5)+1, tableRegions(numToEvaluate,4)+1];
        imBounds = imresize(imBounds,sizing);
        imref = imcrop(imSprites,tableRegions(numToEvaluate,2:5));
        correl = corr2(imref,imBounds);
        if correl > 0.7
            result = 1;
            break;
        end;        
        %figure;
        %imshow(imBounds);
        
    end
    
end