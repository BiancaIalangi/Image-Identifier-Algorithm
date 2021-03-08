function [w] = learn(X, y)
  
  [nl nc] = size(X);
  %adaugare pe coloana 3*count_bins+1
  %valoarea 1
  X(nc+1, :) = 1;
  [Q R] = Householder(X);
  w = SST(R, Q'*y);
  
end
