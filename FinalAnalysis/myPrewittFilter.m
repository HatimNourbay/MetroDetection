function imPrewitt = myPrewittFilter(im)

[H,W] = size(im);
imfin = zeros(H,W);

h = fspecial('prewitt');
imres = imfilter(im,h);
imres2 = imfilter(im,h');

for x = 1:H-1
    for y = 1:W-1
        imfin(x,y) = sqrt(imres(x,y)*imres(x,y) + imres2(x,y)*imres2(x,y));
        if imfin(x,y) > 0.21
            imfin(x,y) = 1;
        else
            imfin(x,y) = 0;
            
        end
    end
end

imPrewitt = imfin;