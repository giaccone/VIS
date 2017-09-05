function OF = Deb2(x)

% Author: Luca Giaccone (luca.giaccone@polito.it)

G = 2 - exp(-((x(:,2)-0.2)/0.004).^2) - 0.8 * exp(-((x(:,2)-0.6)/0.4).^2);
OF = [x(:,1),  G./x(:,1)];

