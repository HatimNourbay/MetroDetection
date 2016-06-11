clear all;
close all;

%% Stock the Hue value for each metro number

 load('Apprentissage.mat');
 addpath(genpath('PreAnalysis'));
 
 histoHue = zeros(1,10001);
 l = length(BD);

%% Initialize the metro number searched

% metroNum = 7;
% 
% imPicto = rgb2hsv(im2double(imread ('PICTOCOLOUR/04.png')));
% 
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
%             %histoHue = histoHue > 0.05;
%             figure(fd);
%             plot((0:(length(histoHue)-1))/(length(histoHue)-1), histoHue);
%         end
% end
% 
% histoHue = histoHue(1:5000);
% 
% ifirst = find (histoHue > 0,1,'first')
% ilast = find (histoHue > 0,1,'last')


% figure;
% imshow(imPicto);


FilterBySubNum = [];

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
            histoHue = histoHue > 0.03;
        end
    end
    if (numSubway ~= 7 && numSubway ~= 11)
        FilterBySubNum = [ FilterBySubNum; numSubway, (find(histoHue > 0,1,'first') - 300)/10000, (find(histoHue > 0,1,'last') + 300)/10000,0,0];
    elseif (numSubway == 11)
        FilterBySubNum = [ FilterBySubNum; numSubway, (find(histoHue > 0,1,'first') - 150)/10000, (find(histoHue > 0,1,'last') + 150)/10000,0,0];
    else
        % 7 has the odd behavior of having two Hue present in the photos.
        % We are separating the graph in two to find all the possible hues.
        FilterBySubNum = [ FilterBySubNum; 7, (find(histoHue(1:5000) > 0,1,'first'))/10000,...
            (find(histoHue(1:5000) > 0,1,'last'))/10000,...
            (find(histoHue(5001:10000) > 0,1,'first')+5000)/10000,...
            (find(histoHue(5001:10000) > 0,1,'last')+5000)/10000];
        
    end
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
