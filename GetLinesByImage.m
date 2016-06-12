close all;
clear all;

load('Test.mat');
addpath(genpath('FinalAnalysis'));

% BDLine = 72;
% numberBD = num2str(BD(BDLine,1));

numberBD = '61';
imStr = strcat('BD/IM (',numberBD,').JPG');

im = im2double(imread (imStr));

tableImages = FindBoundsByColor(im,8);