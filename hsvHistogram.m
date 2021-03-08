function [sol] = hsvHistogram(path_to_image, count_bins)

  image = imread(path_to_image);

  %gasirea valorilor maxime/minime din
  %matricea tridimensionala
  Cmax = max(image, [], 3);
  Cmax = Cmax(:);
  Cmin = min(image, [], 3);
  Cmin = Cmin(:);
  
  %extragerea matricilor red, green,
  %blue din matricea tridimensionala a
  %fiecarei imagini din path_to_image
  red_m = image(:, :, 1);
  red = red_m(:);
  green_m = image(:, :, 2);
  green = green_m(:);
  blue_m = image(:, :, 3);
  blue = blue_m(:);
  
  step = 1.01 / count_bins;
  range = 0:step:1.02;
  
  red = double(red);
  green = double(green);
  blue = double(blue);
  Cmax = double(Cmax);
  Cmin = double(Cmin);
  
  Cmax = Cmax' / 255;
  Cmin = Cmin' / 255;
  red = red' / 255;
  green = green' / 255;
  blue = blue' / 255;

  H = 0;
  ind0 = find(Cmax == Cmin);
  H(ind0) = 0;
  ind = find(Cmax == red & (Cmax != Cmin));
  H(ind) = 60 .* mod((green(ind) .- blue(ind)) ./ (Cmax(ind) - Cmin(ind)), 6);
  ind1 = find(Cmax == green  & (Cmax != Cmin));
  H(ind1) = 60 .* (((blue(ind1) .- red(ind1)) ./ (Cmax(ind1) - Cmin(ind1))) .+ 2);
  ind2 = find(Cmax == blue & (Cmax != Cmin));
  H(ind2) = 60 .* (((red(ind2) .- green(ind2)) ./ (Cmax(ind2) - Cmin(ind2))) .+ 4);
  H = H / 360; 
  V = Cmax;
  S = 0;
  ind3 = find(Cmax != 0);
  S(ind3) = (Cmax(ind3) .- Cmin(ind3)) ./ Cmax(ind3);


  nr_h = histc(H, range);
  %stergere reziduu
  nr_h(end) = [];
  
  nr_s = histc(S, range);
  %stergere reziduu
  nr_s(end) = [];
  
  nr_v = histc(V, range);
  %stergere reziduu
  nr_v(end) = [];

  sol = [nr_h nr_s nr_v];
end