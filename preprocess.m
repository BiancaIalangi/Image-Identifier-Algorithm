function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
 
  %creare matrice imags/nimgs ce contine toate
  %imaginile din pathc/pathnc
  pathc = strcat (path_to_dataset, 'cats/');
  imgs = getImgNames(pathc);
  
  pathnc = strcat(path_to_dataset, 'not_cats/');
  nimgs = getImgNames(pathnc);
  
  [lc cc] = size(imgs);
  [ln nc] = size(nimgs);
  X = zeros(ln + lc, 3 * count_bins);

  %creare matrice X ce aplica functia
  %RGB/RGB2HSV fiecarei imagini din 
  %imgs(imagininle cu pisici si nimfs(imaginile fara pisici) 
  if histogram == 'HSV'
    for i = 1:lc
      X(i, :) = hsvHistogram(strcat(pathc, imgs(i, :)), count_bins);
    endfor
    for i = (lc + 1):(ln + lc)
       X(i, :) = hsvHistogram(strcat(pathnc, nimgs(i - lc, :)), count_bins);
    endfor
  elseif histogram == 'RGB'
    for i = 1:lc
      X(i, :) = rgbHistogram(strcat(pathc, imgs(i, :)), count_bins);
    endfor
    for i = (lc + 1):(lc + ln)
      X(i, :) = rgbHistogram(strcat(pathnc, nimgs(i - lc, :)), count_bins);
    endfor
  endif
  
  y(1:lc, 1) = 1;
  y((lc + 1):(lc + ln), 1) = -1;

endfunction
