function [sol] = rgbHistogram(path_to_image, count_bins)

  image = imread(path_to_image);
  
  [r g b] = size(image);

  %extragerea matricilor red, green,
  %blue din matricea tridimensionala a
  %fiecarei imagini din path_to_image
  red_m = image(:, :, 1);
  red = red_m(:);
  green_m = image(:, :, 2);
  green = green_m(:);
  blue_m = image(:, :, 3);
  blue = blue_m(:);
  
  step = 256 / count_bins;
  range = 0:step:256;
  
  nr_red = histc(red, range);
  nr_red = nr_red';
  %stergere reziduu
  nr_red(end) = [];
  
  nr_green = histc(green, range);
  nr_green = nr_green';
  %stergere reziduu
  nr_green(end) = [];

  nr_blue = histc(blue, range);
  nr_blue = nr_blue';
  %stergere reziduu
  nr_blue(end) = [];
   
  sol = [nr_red nr_green nr_blue];
end