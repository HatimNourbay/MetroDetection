clear all;
close all;

%% Stock the Hue value for each metro number

 load('Apprentissage.mat');

%% Initialize the metro number searched

metroNum = 12;
l = length(BD);

FilterBySubNum = [];


% histoHue = zeros(1,10001);
% 
% fd = figure;
% 
% 
% for x = 1:l    
%         if (BD(x,6) == metroNum)
%             [im,mask] = CreatePicto(num2str(BD(x,1)),x,BD);
%             %Create a table a values with the position in the database and
%             %the HSV values for the image. 
%             [CircIm NumIm] = ExtractImPart(im);            
%             [f,hue] = FindHSV(CircIm,mask);
%             histoHue = histoHue + f;
%             figure(fd);
%             plot((0:(length(histoHue)-1))/(length(histoHue)-1), histoHue);
%         end
%     end


FilterRange = 0.030;

for numSubway = 1:14
    tic;
    histoHue = zeros(1,10001);
    for x = 1:l    
        if (BD(x,6) == numSubway)
            [im,mask] = CreatePicto(num2str(BD(x,1)),x,BD);
            %Create a table a values with the position in the database and
            %the HSV values for the image. 
            [CircIm NumIm] = ExtractImPart(im);            
            [f,hue] = FindHSV(CircIm,mask);
            histoHue = histoHue + f;
        end
    end
    FilterBySubNum = [ FilterBySubNum; numSubway, max(histoHue) - FilterRange, max(histoHue) + FilterRange];
    toc
end


FilterBySubNum
%% Deprecated code 


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
