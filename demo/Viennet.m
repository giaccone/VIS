function OF = Viennet(x)

% Author: Luca Giaccone (luca.giaccone@polito.it)

A = x(:,1).^2 + x(:,2).^2;
B = (3*x(:,1) - 2*x(:,2) + 4).^2;
C = (x(:,1) - x(:,2) + 1).^2;
D = x(:,1).^2 + x(:,2).^2 + 1;

OF = [0.5*A + sin(A) ,  B/8 + C/27 + 15 , 1./D - 1.1*exp(-A)];

