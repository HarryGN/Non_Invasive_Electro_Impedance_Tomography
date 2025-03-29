imdl= mk_common_model('c2c2',16);
img= calc_jacobian_bkgnd( imdl );
vh= fwd_solve(img);
img.elem_data([232,240])= 1.1;
img.elem_data([225,249])= 0.9;
vi= fwd_solve(img);

subplot(221); 
plot([vh.meas, vi.meas]); axis tight

subplot(222); 
show_fem(img,[0,1,1]); axis square

img0 = inv_solve(imdl,vh,vi);
subplot(223);
show_fem(img0,[0,1,0]); axis square

imdl=mk_common_gridmdl('backproj');
img1 = inv_solve(imdl,vh,vi);
subplot(224); 
show_fem(img1,[0,1,0]); axis square

print -dpng -r100 db_backproj_matrix01.png