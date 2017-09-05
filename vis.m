function [mem, PF] = vis(fun, Nvar, lb, ub, PopSize, Nclone, beta, pnew, Nint, Next, Nmax)

% VIS performs multiobjactive optimization using Vector Immune Systems
%
% USE:
% [mem, PF] = vis(fun, Nvar, lb, ub, PopSize, Nclone, beta, pnew, Nint, Next, Nmax)
%
% INPUT:
% 'fun': handle to function thet returns the objectives to be minimized
% 'Nvar': number of variables (optmization paramenters)
% 'lb': lower bounds for the optmization paramenters
% 'ub': upper bounds for the optmization paramenters
% 'PopSize': population size
% 'Nclone': number of clones
% 'beta': mutation factor
% 'pnew': percentage of newcomers at each new generations
% 'Nint': number of inner loops
% 'Next': number of outer loops
%
% OUTPUT:
% 'mem': non dominated solution in the memory (variables)
% 'PF': pareto front (objectives)
%
% NOTE:
% Based on: Freschi F. and Repetto M., "VIS: An artificial immune network
% for multi-objective optimization", Engineering Optimization, Vol. 38, No.8,
% December 2006, DOI: 10.1080/03052150600880706
%
% VERSION:
% Date: 07.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:


%% initial population
abn = rand(PopSize, Nvar);
% convert to real value
abr = Norm2Real(abn, lb, ub);
% evaluate function
OF = fun(abr);
% find pareto set
[PS, indom] = FindPareto(OF);
% evaluate fitness
fit = Fitness(OF, indom);

%% initialize temporary figure
if size(PS,2) < 4
    hf1 = figure(); set(gcf, 'color', [1 1 1])
    hold on;
    grid on;
    set(gca, 'fontsize',18)
end
if size(PS,2) == 3
    view(3);
    xlabel('O1','fontsize',18)
    ylabel('O2','fontsize',18)
    zlabel('O3','fontsize',18)
elseif size(PS,2) == 2
    xlabel('O1','fontsize',18)
    ylabel('O2','fontsize',18)
end

%% initialize memory and waitbar
mem = [];
OF_mem = [];
hwb = waitbar(0,'Please wait...');

% Outer loop
for h=1:Next
    
    % Inner loop
    for k = 1:Nint
        
        % make clones
        clonen = MakeClone(abn, Nclone, beta, fit);
        cloner = Norm2Real(clonen, lb, ub);
        
        % ab + clones
        CurrentPop = [abr; cloner];
        % evaluate function
        OF = fun(CurrentPop);
        % find pareto set
        [PS, indom] = FindPareto(OF);
        % evaluate fitness
        fit = Fitness(OF, indom);
        
        if k < Nint % (code not necessary at the end of the inner loop)
            % clonal selection
            abr = ClonalSelection(cloner, fit, PopSize, Nclone);
            abn = Real2Norm(abr, lb, ub);
            % evaluate function
            OFtemp = fun(abr);
            % find pareto set
            [PStemp, indom] = FindPareto(OFtemp);
            % evaluate fitness
            fit = Fitness(OFtemp, indom);
        end
        
    end % ( end of the inner loop)
    
    % apply affinity operator
    [PF, idel] = OjectiveDistance(PS, Nmax);
    
    if size(PF,2) == 3
        plot3(PF(:,1),PF(:,2),PF(:,3),'o','markerfacecolor','None','markersize',8,'linewidth',2)
    elseif size(PF,2) == 2
        plot(PF(:,1),PF(:,2),'o','markerfacecolor','None','markersize',8,'linewidth',2)
        xlabel('O1','fontsize',18)
        ylabel('O2','fontsize',18)
    end
    drawnow
    
    % delete too close solutions
    NDomSol = CurrentPop(indom,:);
    NDomSol(idel, :) = [];
    
    % delete related OF
    OF_NDom = OF(indom,:);
    OF_NDom(idel, :) = [];
    
    % update memory
    mem = [mem; NDomSol];
    OF_mem = [OF_mem; OF_NDom];
    
    % filter out dominated solutions in the memory
    [OF_mem, indom] = FindPareto(OF_mem);
    mem = mem(indom,:);
    
    
    if h < Next % (code not necessary at the end of the inner outer loop)
        
        % definition of the new population
        Nnew = floor(PopSize*pnew);
        Npareto = PopSize - Nnew;
        
        if size(NDomSol,1) < Npareto
            Nnew = PopSize - size(NDomSol,1);
            
            NewComers = rand(Nnew, Nvar);
            
            NewFromPareto = Real2Norm(NDomSol, lb, ub);
        else
            
            NewComers = rand(Nnew, Nvar);
            
            iscramble = randperm(size(NDomSol,1));
            index = iscramble(1:Npareto);
            NewFromPareto = Real2Norm(NDomSol(index,:), lb, ub);
        end
        
        abn = [NewComers; NewFromPareto];
        % convert to real value
        abr = Norm2Real(abn, lb, ub);
        % evaluate function
        OF = fun(abr);
        % find pareto set
        [PS, indom] = FindPareto(OF);
        % evaluate fitness
        fit = Fitness(OF, indom);
    end
    
    waitbar(h / Next);
end
close(hwb);



%% Clean memory with affinity operator
[PF, idel] = OjectiveDistance(OF_mem, Nmax);
mem(idel,:) = [];

%% Final result
if size(PF,2) == 3
    hf2 = figure; set(gcf, 'color', [1 1 1])
    plot3(PF(:,1),PF(:,2),PF(:,3),'o','markerfacecolor','None','markersize',8,'linewidth',2)
    set(gca, 'fontsize',18)
    xlabel('O1','fontsize',18)
    ylabel('O2','fontsize',18)
    zlabel('O3','fontsize',18)
    grid on
elseif size(PF,2) == 2
    hf2 = figure; set(gcf, 'color', [1 1 1])
    plot(PF(:,1),PF(:,2),'o','markerfacecolor','None','markersize',8,'linewidth',2)
    set(gca, 'fontsize',18)
    xlabel('O1','fontsize',18)
    ylabel('O2','fontsize',18)
    grid on
end
    








