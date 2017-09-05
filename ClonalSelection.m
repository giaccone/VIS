function ab_update = ClonalSelection(clone, fit, PopSize, Nclone)
% CLONALSELECTION select for the new generation the best clone related to each parent
%
% USE:
% ab_update = ClonalSelection(clone, fit, PopSize, Nclone)
%
% INPUT:
% 'clone': clones (real valued)
% 'fit': fitness
% 'PopSize': population size
% 'Nclone': number of clones
%
% OUTPUT:
% 'ab_update': new antibodies
%
% VERSION:
% Date: 03.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

fit = reshape(fit(PopSize+1:end),Nclone,PopSize);
[~, irow] = min(fit);
ind = irow + Nclone*((1:PopSize) -1);
ab_update = clone(ind,:);

