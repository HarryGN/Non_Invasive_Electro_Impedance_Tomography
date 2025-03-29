figure('visible','off')
load montreal_data_1995
outimg=show_slices(inv_solve(mk_common_model('d2c2',16),zc_h_demo4,zc_demo4)) 
%   print_convert('abc.png');

%   subplot(221)
  image(outimg);
%   subplot(222)
%   imshow('abc.png')
% 
% handle=figure;
% set(0, 'currentFigure', handle);