clear all;
close all;

%% Stock the Hue value for each metro number

load('Apprentissage.mat');

l = length(BD);

% im = CreatePicto(num2str(BD(23,1)),23,BD);
% FindHSV(im)

%Initialize the metro number searched
metroNum = 4;

histoHue = zeros(1,10001);

for x = 1:l
        if (BD(x,6) == metroNum)
            im = CreatePicto(num2str(BD(x,1)),x,BD);
            %Create a table a values with the position in the database and
            %the HSV values for the image. 
            %[x FindHSV(im)]
            f = FindHSV(im);
            histoHue = histoHue + f;
            
        end
end

figure, bar(0:10000,histoHue);title ('My histogram');
    




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
