clear all;
close all;

%% Init by creating pictos of every number in BD

load('Apprentissage.mat');

l = length(BD);

% im = CreatePicto(num2str(BD(23,1)),23,BD);
% FindHSV(im)

for x = 1:l
        if (BD(x,6) == 2)
            im = CreatePicto(num2str(BD(x,1)),x,BD);
            [x FindHSV(im)]
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
