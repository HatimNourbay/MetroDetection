%% Find the picto thanks to the database


function result = CreatePicto(numberBD, lign, BD)

imStr = strcat('BD/IM (',numberBD,').JPG');

im = im2double(imread (imStr));

imTemp = zeros(BD(lign,3) - BD(lign,2), BD(lign,5) - BD(lign,4),3);
H = BD(lign,3) - BD(lign,2);
W = BD(lign,5) - BD(lign,4);


for x = 1:H
    for y = 1:W
        imTemp(x,y,1) = im(x+BD(lign,2),y+BD(lign,4),1);
        imTemp(x,y,2) = im(x+BD(lign,2),y+BD(lign,4),2);
        imTemp(x,y,3) = im(x+BD(lign,2),y+BD(lign,4),3);
    end
end

imageSize = size(imTemp);
r = min(imageSize(1:2))/2;

ci = [r, r, r];     % center and radius of circle ([c_row, c_col, r])
[xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
mask = ((xx.^2 + yy.^2)<ci(3)^2);
croppedImage = (zeros(size(imTemp)));
croppedImage(:,:,1) = imTemp(:,:,1).*mask;
croppedImage(:,:,2) = imTemp(:,:,2).*mask;
croppedImage(:,:,3) = imTemp(:,:,3).*mask;
%imshow(croppedImage);

imSymbHSV = rgb2hsv(croppedImage);
result = imSymbHSV;