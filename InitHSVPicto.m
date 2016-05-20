clear all;
close all;


BD = load('Apprentissage.mat');

%% We are searching for the HSV of PICTO folder
% We can have a basis of comparison between the apprentissage database and
% the real values of original PICTO

HSVPicto = [];

files = dir('PICTOCOLOUR/*.png');
i = 1;
for file = files'
    im = im2double(imread (strcat('PICTOCOLOUR/',file.name)));
    HSVPicto = [HSVPicto; i FindHSV(im)];
    i = i + 1;
end

    



