function imResult = WhiteElimintation(im)

[H,W,nCan] = size(im);

whiteThreshold = 0.057;

for x = 1:H - 1
    for y = 1:W - 1
        tempR = im(x,y,1);
        tempG = im(x,y,2);
        tempB = im(x,y,3);
        if (abs(tempR-tempG)<whiteThreshold) && (abs(tempR-tempB)<whiteThreshold)...
                && (abs(tempB-tempG)<whiteThreshold)
            im(x,y,:) = 0;
        end
    end
end

imResult = im;