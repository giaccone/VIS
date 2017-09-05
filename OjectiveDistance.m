function [ParetoFiltered, idel] = OjectiveDistance(ParetoSet, Nmax)
% OBJECTIVEDISTANCE remove solutions too close to each other
%
% USE:
% [ParetoFiltered, idel] = OjectiveDistance(ParetoSet, Nmax)
%
% INPUT:
% 'ParetoSet': Pareto set
% 'Nmax': max number of allowed points in the Pareto set
%
% OUTPUT:
% 'ParetoFiltered': Pareto set satisfying minimum distance among solutions
% 'idel': Pareto set satisfying minimum distance among solutions
%
% VERSION:
% Date: 06.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

[PopDim, Nobj] = size(ParetoSet);


% normalize objectives
Omin = min(ParetoSet);
Omax = max(ParetoSet);
NormSet = (ParetoSet - Omin)./(Omax - Omin);

% build all possible pairs
idx = GenPairs(PopDim);


% compute distances
dist = NormSet(idx(:,2), : ) - NormSet(idx(:,1), : );
dist = sqrt(sum(dist.^2,2));

dmin = sqrt(Nobj)/Nmax;

% find too close solution
iclose = idx(dist < dmin , :);

index = 1;
idel = [];
while index <= size(iclose,1)
    ikeep = iclose(index,1);
    irem = iclose(index,2);
    idel = [idel; irem];
    iclose(iclose(:,1) == irem,:) = [];
    iclose(iclose(:,2) == irem,:) = ikeep;
    index = index + 1;
end

ParetoFiltered = ParetoSet;
ParetoFiltered(idel,:) = [];


