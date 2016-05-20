
function result = FindHSV(im)

%% Begin with HSV conversion

imHSV = rgb2hsv(im);
gray = rgb2gray(im);

%% Find real dimension image without mapping
[H,W] = size(gray);
imSize = H*W;


%% Find the Hue value of the color present through histo
histoH = zeros(1,10001);
histoS = zeros(1,10001);
histoV = zeros(1,10001);
hue = 0;
sat = 0;
val = 0;

for x = 1:H-1
    for y = 1:W-1
        hsv = imHSV(x,y,:);
        if hsv(1) ~= 0        
            % converting the value from 0 to 1 to 0 to 10000 to place it in
            % the histo
            i = floor(hsv(1)*10000);
            i = i + 1;
            histoH(i)= histoH(i) + 1;
        end
        if hsv(2) ~= 0        
            g = floor(hsv(2)*10000);
            g = g + 1;
            histoS(g)= histoS(g) + 1;
        end
        if hsv(3) ~= 1        
            a = floor(hsv(3)*10000);
            a = a + 1;
            histoV(a)= histoV(a) + 1;
        end
    end;
end;


%% Searching for probability 
%instead of just picking max value of the H channel, we take the max proba
%to be sure we are in the colour part of the image

p = zeros(1,10001);

for x = 1:H - 1
    for y = 1:W - 1
        i = imHSV(x,y,1);
        if i ~= 0
            i = floor(i*10000);
            p(i) = histoH(i) / (H * W);
        end
    end;
end;


%[Num,hue] = max(histoH);
%We are only interested in Hue value
[Num,hue] = max(p);
[Num,sat] = max(histoS);
[Num,val] = max(histoV);

figure, bar(0:10000,histoH);title ('My histogram');
% 
%         
% figure;
% imshow(imHSV);

figure, bar(0:10000,p);title ('Proba');

% recreating the value from 0 to 1
result = [hue/10000 sat/10000 val/10000 ];

%% Unused & Deprecated Code 

% 
% color = [];
% 
% HSVDiff = zeros(1,3);
% 
% for x = 1:H-1
%     for y = 1:W-1
%         color(1) = imHSV(x,y,1);
%         color(2) = imHSV(x,y,2);
%         color(3) = imHSV(x,y,3);
%             if ismember(color,HSVDiff) == 1 | imHSV(x,y,3) == 1
%             else
%                 HSVDiff = [HSVDiff; color];
%             
%         end
%     end
% end
