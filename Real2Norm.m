function abn = Real2Norm(abr, lb, ub)
% NORM2REAL convert from real valued to normalized the antibodies
%
% USE:
% abn = Real2Norm(abr, lb, ub)
%
% INPUT:
% 'abr': real valued antibodies
% 'lb': lower bounds for the optmization paramenters
% 'ub': upper bounds for the optmization paramenters
%
% OUTPUT:
% 'abn': normalized antibodies
%
% VERSION:
% Date: 03.03.2017
% Author: Luca Giaccone (luca.giaccone@polito.it)
%
% HISTORY:

abn = (abr - lb(:).')./(ub(:) - lb(:)).';

