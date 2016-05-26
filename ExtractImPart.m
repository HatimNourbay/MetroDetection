function [imCirclePart, imNumberPart] = ExtractImPart(im)


cform = makecform('srgb2lab');
convIm = applycform(im,cform);

% Take the channels that are not based on luminosity and converting to
% double
ab = double(convIm(:,:,2:3));
NumRows = size(ab,1);
NumCols = size(ab,2);
ab = reshape(ab,NumRows*NumCols,2);

nColors = 2;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);                                  
                                  
pixel_labels = reshape(cluster_idx,NumRows,NumCols);
%imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

%% Creating a circle with several points
tempX = size(im);
% Taking the minimum of the size of image to avoid out of index
tempX = min(tempX(1),tempX(2));
% a R a little bit smaller than the real size of the image to be sure to be
% placed inside
r = floor(tempX/2) - 7;
ang=0:0.1:2*pi; 
% Tracing circle and recentering the circle on image to avoid out of index
circle = [floor(r*cos(ang'))+r+7 floor(r*sin(ang'))+r+7];


%% Selecting the good cluster of pixel

SegmentAnalyse = zeros();
GoodSegment = zeros();

% We are going to test if the points of the circle corresponds to a real
% value or if it is empty, to select the cluster with the color instead of
% the number inside. 

for k = 1:nColors
    color = im;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;   
    for x = 1:length(circle)
        hello = rgb2hsv(segmented_images{k});
        SegmentAnalyse(x) = hello(circle(x,1),circle(x,2),1);
        numberZeros = sum(SegmentAnalyse(1,:) == 0);
    end
    
    if (((numberZeros*100)/length(SegmentAnalyse)) < 40)
        GoodSegment = segmented_images{k};
    end
end

if (GoodSegment == segmented_images{1})
    imNumberPart = segmented_images{2};
else
    imNumberPart = segmented_images{1};
end


imCirclePart = GoodSegment;
