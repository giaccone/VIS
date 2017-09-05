clear variables, close all

%% variables
PopSize = 200;
Nclone = 5;
Nmax = 200;
beta = 0.05;
pnew = 0.2;
Nint = 5;
Next = 10;

%% select test function
fun = 'Deb2';

switch fun
    case 'Viennet'
        % handle to function Viennet
        Nvar = 2;
        lb = [-3, -3];
        ub = [3, 3];
        fun = @(x) Viennet(x);

    case 'shaffler2'
        % ShafflerFun2
        Nvar = 1;
        lb = [-5];
        ub = [10];
        fun = @(x) ShafflerFunv2(x);

    case 'Deb2'
        % Deb2
        Nvar = 2;
        lb = [0.1 0.1];
        ub = [1 1];
        fun = @(x) Deb2(x);
end

%% run VIS
[mem, PF] = vis(fun, Nvar, lb, ub, PopSize, Nclone, beta, pnew, Nint, Next, Nmax);