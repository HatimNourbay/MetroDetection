function [circleBound,imHSV] = ExtractHueCircle(im,MetroLine)

imHSV = im;
[imFiltered, newBound] = ApplyHueFilter(im,MetroLine);

imFiltered = myPrewittFilter(imFiltered);
% 
% figure;
% imshow(imFiltered);

[temprow, tempcolumn] = size(newBound);

% for k = 1 : temprow
%   rectangle('Position', [newBound(k,:)],...
%   'EdgeColor','r','LineWidth',2 )
% end

[H,W] = size(imFiltered);
[row,column] = size(newBound);

actualCircleBound = [];

if newBound ~= 0
    if row >= 1
        for k = 1 : row
        
            tempX1 = floor(newBound(k,1)); tempX2 = newBound(k,3);
            tempY1 = floor(newBound(k,2)); tempY2 = newBound(k,4);
        
            if (tempX1 - 20 > 0)
                newBound(k,1) = newBound(k,1) - 20;
            end
            if (tempX1 + tempX2 + 40 < W)
                newBound(k,3) = newBound(k,3) + 40;
            end
            if (tempY1 - 20 > 0)
                newBound(k,2) = newBound(k,2) - 20;
            end
            if (tempY1 + tempY2 + 40 < H)
                newBound(k,4) = newBound(k,4) + 40;
            end
        
        
            tempIm = imcrop(imFiltered,newBound(k,:));
        
            tempSize = size(tempIm);
            minRad = floor(min(tempSize)/5);
            maxRad = floor(min(tempSize)/1.5);
        
%         figure;
%         imshow(tempIm);
        
            [centers, radii] = imfindcircles(tempIm,[minRad, maxRad],'ObjectPolarity','dark', ...
            'Sensitivity',0.97);
     
            if (isempty(centers) && isempty(radii))
            else
                for s = 1:(length(radii))
                    XcircleBound = floor(centers(s,1) + tempX1 - 20 - radii(s));
                    YcircleBound = floor(centers(s,2) + tempY1 - 20 - radii(s));
                    Xcolumns = floor(radii(s)*2);
                    Yrows = floor(radii(s)*2);
                    actualCircleBound = [actualCircleBound; XcircleBound, YcircleBound, ...
                    Xcolumns,Yrows];
                end
            end
        end
    else
    end
else
%     [centers, radii] = imfindcircles(imFiltered,[50, 120],'ObjectPolarity','dark', ...
%             'Sensitivity',0.96);
%      
%             if (isempty(centers) && isempty(radii))
%             else
%                 for s = 1:(length(radii))
%                     XcircleBound = floor(centers(s,1) - radii(s));
%                     YcircleBound = floor(centers(s,2) - radii(s));
%                     Xcolumns = floor(radii(s)*2);
%                     Yrows = floor(radii(s)*2);
%                     actualCircleBound = [actualCircleBound; XcircleBound, YcircleBound, ...
%                     Xcolumns,Yrows];
%                 end
%             end
end

circleBound = actualCircleBound;