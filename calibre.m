function imres = calibre(im)

minVal = min(im(:));
maxVal = max(im(:));
imres = (im-minVal) / (maxVal - minVal);