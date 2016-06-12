function tableBounds = FindBoundsByColor(im, MetroLine)


addpath(genpath('PreAnalysis'));
addpath(genpath('FinalAnalysis'));

load('FilterBySubNum');

%MetroLine = BD(BDLine,6);

im = WhiteElimintation(im);    

figure;
imshow(im);

%initTable = [];

    tic;
    [getFinalBoundBox, imHSVTreated] = ExtractHueCircle(im,MetroLine);
    toc

    [row, column] = size(getFinalBoundBox);

    if (isempty(getFinalBoundBox))    
    else
        tic;
        for d = 1:row
            croppedVerification = imcrop(imHSVTreated,getFinalBoundBox(d,:));
            [imPart, numPart] = ExtractImPart(croppedVerification);
            
            [H, W, numCol] = size(imPart);
            %initTable = [initTable, imPart];
            if H < 40 || W < 40        
            else
                imPart = rgb2gray(imPart);
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
                figure;
                imshow(imPart);
                L = bwlabel(imPart,8);
                stats = regionprops('table',L,'BoundingBox');
                BoundB = stats.BoundingBox;
                [temprow, tempcolumn] = size(BoundB);
                
                for k = 1 : temprow
                    rectangle('Position', [BoundB(k,:)],...
                        'EdgeColor','r','LineWidth',2 )
                end
            end
        end
        toc
    end
tableBounds = 0;


