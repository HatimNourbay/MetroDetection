%  Fonction de filtrage d'une image im par un noyau de convolution h

function imres = myFilter(im,TypeFilter)

[H,W] = size(im);

im2 = padarray(im,[1 2],TypeFilter);
[Hb,Wb] = size(im2);

h = ones(3,5)/15;
[H2,W2] = size(h);
N = floor(H2/2);
M = floor(W2/2);

tmp = zeros(Hb,Wb);  
for x = N+1:H+N 
    for y = M+1:W+M 
        % Filtrer le pixel de coordonnées (x,y)
        tmp(x,y) =  sum(sum(im2(x - N:x+N ,y - M: y + M).*h));
    end
end

imres = tmp(N+1 : Hb - N, M+1 : Wb - M);