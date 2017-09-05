function abr = Norm2Real(abn, lb, ub)
% NORM2REAL convert from normalized to real value the antibodies
%
% USE:
% abr = Norm2Real(abn, lb, ub)
%
% INPUT:
% 'abn': normalized antibodies
% 'lb': lower bounds for the optmization paramenters
% 'ub': upper bounds for the optmization paramenters
%
% OUTPUT:
% 'abn': real valued antibodies
%
% VERSION:
% Date: 03.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

abr = lb(:)' + abn .* (ub(:) - lb(:))';

