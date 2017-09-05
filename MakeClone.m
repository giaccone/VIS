function clone = MakeClone(abn, Nclone, beta, fit)
% MAKECLONE generate clones of the antibodies
%
% USE:
% clone = MakeClone(ab, Nclone, beta, fit)
%
% INPUT:
% 'abn': normalized antibodies
% 'Nclone': number of clones for each antibody
% 'beta': mutation factor
% 'fit': fitness
%
% OUTPUT:
% 'clone': clones
%
% VERSION:
% Date: 03.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

[PopSize, Nvars] = size(abn);

xold = repmat(abn.', Nclone, 1);
f = repmat(fit(:).', Nclone, 1);

xold = reshape(xold, Nvars, PopSize * Nclone)';
f = reshape(f, 1, PopSize * Nclone)';

alpha = beta*exp(-(f - min(f))./(max(f) - min(f)));
xrandom = normrnd(0,1,PopSize * Nclone,Nvars);

clone = xold + alpha .* xrandom;
clone(clone > 1) = 1;
clone(clone < 0) = 0;

