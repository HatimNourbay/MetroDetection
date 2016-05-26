clear all;
close all;

%% Stock the Hue value for each metro number

 load('Apprentissage.mat');

% lignNumber = 98;
% 
% 
% [im,mask] = CreatePicto(num2str(BD(lignNumber,1)),lignNumber,BD);
% [CircIm NumIm] = ExtractImPart(im);
% figure;
% imshow(CircIm);



%% Initialize the metro number searched

metroNum = 13;
l = length(BD);


histoHue = zeros(1,10001);
fd = figure;
for x = 1:l
        if (BD(x,6) == metroNum)
            [im,mask] = CreatePicto(num2str(BD(x,1)),x,BD);
            %Create a table a values with the position in the database and
            %the HSV values for the image. 
            [CircIm NumIm] = ExtractImPart(im);
            
            [f,hue] = FindHSV(CircIm,mask);
            histoHue = histoHue + f;
            figure(fd);
            %subplot(1,3,1);imshow(im);
            %subplot(1,3,2);imshow(hue);
            plot((0:(length(histoHue)-1))/(length(histoHue)-1), histoHue);
            %pause
        end
end
    




% ResultMeanHue = [];
% 
% for numSubway = 1:14
%     MeanHue = [];
%     for x = 1:l
%         if (BD(x,6) == numSubway)
%             im = CreatePicto(num2str(BD(x,1)),x,BD);
%             %[x FindHSV(im)]
%             f = FindHSV(im);
%             MeanHue = [MeanHue f(1,1)];
%         end
%     end
%     ResultMeanHue = [ResultMeanHue; numSubway (sum(MeanHue))/size(MeanHue,2)];
% end
% 
% ResultMeanHue
