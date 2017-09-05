function fit = Fitness(OF, indom)
% FITNESS evaluate the fitness for the current population
%
% USE:
% fit = Fitness(OF, indom)
%
% INPUT:
% 'OF': objective function of the current population
% 'indom': index of the non-dominated solutions (i.e. the Pareto set)
%
% OUTPUT:
% 'fit': fitness for the current population
%
% VERSION:
% Date: 03.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

idom = setdiff(1:size(OF,1), indom);
fit = zeros(size(OF,1),1);

% fitness for non dominates solutions
for k = 1:length(indom)
%     delta = OF(indom(k),:) - OF;
%     id = delta < 0;
    fit(indom(k)) = 0;% sum(all(id,2))/(1 + length(idom));
end

% fitness for dominates solutions
for k = 1:length(idom)
    delta = OF(idom(k),:) > OF;
    id = delta > 0;
    fit(idom(k)) = sum(all(id,2));
end
    
    

