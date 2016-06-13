close all;
clear all;

imSprites = im2double(imread('PICTOBW/chiffresArial.png'));
[label, nbobjets] = bwlabel(imSprites,8);

tableRegions = [];

for i=1:nbobjets 
    x = bwlabel((label == i),8);
    
    c = regionprops(x,'BoundingBox');
    y1= round(c.BoundingBox(1)); 
    x1= round(c.BoundingBox(2));
    W = c.BoundingBox(3);
    H = c.BoundingBox(4);
    ratio = H/W;
    
    tableRegions = [tableRegions;nbobjets, c.BoundingBox(1:4)];
end

figure;
imshow(imSprites);
for k = 1 : 10
    rectangle('Position', tableRegions(k,2:5),...
        'EdgeColor','r','LineWidth',2 )
end
    










%function result = ImageRefLoading(imref ,path)

% imref = imread(path);
% 
% [Hr,Wr] = size(imref);
% [label, nbobjets] = bwlabel(imref,8);
% 
% for i=1:nbobjets 
%     x = bwlabel((label == i),8);
%     
%     c = regionprops(x,'BoundingBox');
%     y1= round(c.BoundingBox(1)); 
%     x1= round(c.BoundingBox(2));
%     W = c.BoundingBox(3);
%     H = c.BoundingBox(4);
%     
%     decL = round((Wr-W)/2);
%     decH = round((Hr-H)/2);
%     y0 = y1-decL;
%     x0 = x1-decH;
%     
%     maxcorr = -100;
%     maxr = -1;
%     for k=x0-delta:x0+delta                              % Boucle sur voisinage
%         for l=y0-delta:y0+delta
%             test = x(k:k+Hr-1,l:l+Wr-1);           % extraire l'image testée (meme taille que les images de référence
%             for r=1:10                                     % boucle sur les images de référence
%                 correl = corr2(imref(:,:,r),test);           % corrélation
%                 if correl > maxcorr                        % retenir le max
%                     maxcorr = correl;                        % varie entre -1 et 1
%                     maxr = r;                     % maxr: classe num image qui ressemble
%                 end;
%              end;                  
%         end;
%     end
% end



