function [PS,  ips] = FindPareto(OF)
% FINDPARETO determines the Pareto Set in the objective space
%
% USE:
% [PS,  ips] = FindPareto(OF)
%
% INPUT:
% 'OF': objective function of the current population
%
% OUTPUT:
% 'PS': pareto set
% 'ips': index of the pareto set ==> PS = OF(ips,:)
%
% VERSION:
% Date: 03.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

% get dimensions
PopSize = size(OF,1);

% build all possible OF pairs
idx = GenPairs(PopSize);


% compare pairs
delta = OF(idx(:,2), : ) - OF(idx(:,1), : );

% bolean index 1=lower 0=higher
ineg = delta < 0;

% find all non dominates solutions
ips = idx(all(ineg,2),:);
ips = [ips; fliplr(idx(all(not(ineg),2),:))];
indom = setdiff(ips(:,2),ips(:,1));

% add solutions that neither dominates not are dominated
ips = sort([indom; setdiff((1:PopSize)',ips(:))]);

% build Pareto set reordered along the first objective
PS = OF(ips,:);
[~, isort] = sort(PS(:,1));
PS = PS(isort,:);
ips = ips(isort);

