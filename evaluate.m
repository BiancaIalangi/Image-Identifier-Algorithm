function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  
  %creare matrice imags/nimgs ce contine toate
  %imaginile din pathc/pathnc
  pathc = strcat (path_to_testset, 'cats/');
  imgs = getImgNames(pathc);
  
  pathnc = strcat(path_to_testset, 'not_cats/');
  nimgs = getImgNames(pathnc);
  
  [lc cc] = size(imgs);
  [ln nc] = size(nimgs);
  
  count_cats = 0;
  count_nocats = 0;
  
  %creare matrice X ce aplica functia
  %RGB/RGB2HSV fiecarei imagini din 
  %imgs(imagininle cu pisici si nimfs(imaginile fara pisici) 
  X = zeros(ln + lc, 3 * count_bins);
  X(:, 3 * count_bins + 1)  = 1;
  
  if histogram == 'HSV'
    for i = 1:lc
      X(i, 1:(3 * count_bins)) = hsvHistogram(strcat(pathc, imgs(i, :)), count_bins);
      y = w' * X(i, 1:(3 * count_bins))';
      %in cazul in care imaginea este cu pisici
      if (y >= 0)
        count_cats++;
      endif
    endfor
    for j = (i + 1):(ln + lc)
      X(j, 1:(3 * count_bins)) = hsvHistogram(strcat(pathnc, nimgs(j-i, :)), count_bins);
      y = w' * X(j, 1:(3 * count_bins))';
      %in cazul in care imaginea nu este cu pisici
      if (y < 0)
        count_nocats++;
      endif
    endfor
  elseif histogram == 'RGB'
    for i = 1:lc
      X(i, 1:(3 * count_bins)) = rgbHistogram(strcat(pathc, imgs(i, :)), count_bins);
      y = w' * X(i, 1:(3 * count_bins))';
      %in cazul in care imaginea este cu pisici
      if (y >= 0)
        count_cats++;
      endif
    endfor
    for j=(i + 1):(lc + ln)
      X(j, 1:(3 * count_bins)) = rgbHistogram(strcat(pathnc, nimgs(j - i, :)), count_bins);
      y = w' * X(j, 1:(3 * count_bins))';
      %in cazul in care imaginea nu este cu pisici
      if (y < 0)
        count_nocats++;
      endif
    endfor
  endif
  
  percentage = (count_cats+count_nocats)/(lc+ln);
  
endfunction