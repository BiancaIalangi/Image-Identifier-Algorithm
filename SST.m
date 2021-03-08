function [x] = SST(A, b)

    [l c] = size(A);
    x = zeros(c, 1);
    
    % calculare x(i) in ordine
  	% descrescatoare (de la ultima valoare)
    for i = (c): -1 : 1
        sum_of_xs = A(i, (i + 1) : c) * x((i + 1) : c);
        x(i) = (b(i) - sum_of_xs) / A(i, i);
    endfor

endfunction
    