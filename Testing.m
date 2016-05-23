clear all;
close all;

%% Begin with black and white

im = im2double(imread('BD/IM (6).JPG'));
imHSV = rgb2hsv(im);
gray = rgb2gray(im);

[H,W] = size(gray);

hello = [];
tic;
for x = 1:H - 1
    for y = 1:W - 1
        temp = imHSV(x,y,1);
        if ( (0.82< temp) && (temp < 0.83))
            hello = [hello imHSV(x,y)];
            imHSV(x,y,1) = 0;
        end
    end
end
toc


% gray = rgb2gray(im);
% 
% [H,W] = size(gray);
% imfin = zeros(H,W);
% 
% h = fspecial('prewitt');
% 
% imres = imfilter(gray,h);


%% Trying profile
% for y = 1:W
%     profV(y) = sum(im(:,y));
% end;
% 
% plot(profV,'LineWidth',1.5); title 'Profil vertical';grid on

%% Trying normal plot
% imres2 = imfilter(gray,h');
% 
% %imres2 = myFilter(imres2,'symmetric');
% 
% for x = 1:H-1
%     for y = 1:W-1
%         imfin(x,y) = sqrt(imres(x,y)*imres(x,y) + imres2(x,y)*imres2(x,y));
%         if imfin(x,y) > 0.21
%             imfin(x,y) = 1;
%         else
%             imfin(x,y) = 0;
%             
%         end
%     end
% end

%%for each white, circle of changing radius 
% before circle detect pixels around angle and trace arc and cord
% trace the circle, and find  if edges are white +/- 10 pixels difference.
% With a theta difference as the circle goes around. Each time detected
% eliminate white from the list of detection. And 50% of detection of white
% in the edges means it is a circle



figure,
imshow(imHSV);

% [centers, radii] = imfindcircles(imfin,[20 50],'ObjectPolarity','dark', ...
%     'Sensitivity',0.95)
% 
% [centersM, radiiM] = imfindcircles(imfin,[50 100],'ObjectPolarity','dark', ...
%     'Sensitivity',0.95)
% 
% [centersB, radiiB] = imfindcircles(imfin,[100 170],'ObjectPolarity','dark', ...
%     'Sensitivity',0.95)
