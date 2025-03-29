% Solving onto Nodes vs Elements

% Simulate Target $Id: nodal_solve01.m 2157 2010-04-04 11:22:54Z aadler $

imdl= mk_common_model('d2d1c',16);
img= mk_image(imdl);

vh = fwd_solve(img); %Homogeneous
% Ô²ÐÎ
% select_fcn = inline('(x-0.2).^2+(y-0.5).^2<0.4^2','x','y','z');
% ÍÖÔ²
% select_fcn = inline('(x).^2/0.8^2+(y).^2/0.6^2<1','x','y','z');
select_fcn = inline('(abs(x))./1+(abs(y))./1<0.4','x','y','z');
img.elem_data = 1 + elem_select(img.fwd_model, select_fcn);
vi = fwd_solve(img); %Homogeneous

subplot(321);
show_fem(img);

subplot(322);
plot([vh.meas, vi.meas]); axis tight

% Reconstructing onto elements
% 
% Coarse model
imdl1= mk_common_model('a2c0',16);
imdl1.RtR_prior = @prior_laplace;
imdl1.hyperparameter.value = 0.1;

img1 = inv_solve(imdl1, vh, vi);
subplot(323);
show_fem(img1);

% Fine model
imdl2= mk_common_model('c2c0',16);
imdl2.RtR_prior = @prior_laplace;
imdl2.hyperparameter.value = 0.1;

img2 = inv_solve(imdl2, vh, vi);
subplot(324);
show_fem(img2);

% Reconstructing onto nodes
% 
% Coarse model
imdl1= mk_common_model('a2c0',16);
imdl1.solve = @nodal_solve;
imdl1.RtR_prior = @prior_laplace;
imdl1.hyperparameter.value = 0.1;

img1 = inv_solve(imdl1, vh, vi);
subplot(325);
show_fem(img1);

% Fine model
imdl2= mk_common_model('c2c0',16);
imdl2.solve = @nodal_solve;
imdl2.RtR_prior = @prior_laplace;
imdl2.hyperparameter.value = 0.1;

img2 = inv_solve(imdl2, vh, vi);
subplot(326);
show_fem(img2);
