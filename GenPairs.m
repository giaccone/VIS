function pairs = GenPairs(n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
% 7/3/17

[ii, jj] = meshgrid(1:n,1:n);
i = ii(ii > jj);
j = jj(ii > jj);

pairs = [j i];

