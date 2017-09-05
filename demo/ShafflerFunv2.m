function OF = ShafflerFunv2(x)

% Author: Luca Giaccone (luca.giaccone@polito.it)

v1 = zeros(size(x));
v1(x<=1) = -x(x<=1);
v1(x>1 & x<=3) = x(x>1 & x<=3) - 2;
v1(x>3 & x<=4) = 4 - x(x>3 & x<=4);
v1(x>4) = x(x>4) - 4;

v2 = (x - 5).^2;
OF = [v1 v2];

