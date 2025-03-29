

imdl= mk_common_model('c2c0',16);
img= mk_image(imdl);

subplot(231);
show_fem(img,[1 0 0]);

vh = fwd_solve(img); %Homogeneous
select_fcn = '(x-0.2).^2+(y-0.5).^2<0.1^2','x','y','z';
img.elem_data = 1 + elem_select(img.fwd_model, select_fcn);
vi = fwd_solve(img); %inHomogeneous

subplot(232);
plot([vh.meas, vi.meas]); axis tight

% % Reconstructing onto elements
% Coarse model
imdl1= mk_common_model('a2c0',16);
imdl1.RtR_prior = @prior_laplace;
imdl1.hyperparameter.value = 0.1;

img1 = inv_solve(imdl1, vh, vi);
subplot(233);
show_fem(img1);

% Fine model
imdl2= mk_common_model('c2c0',16);
imdl2.RtR_prior = @prior_laplace;
imdl2.hyperparameter.value = 0.1;

img2 = inv_solve(imdl2, vh, vi);
subplot(234);
show_fem(img2);

% % Reconstructing onto nodes
% Coarse model
imdl1= mk_common_model('a2c0',16);
imdl1.solve = @nodal_solve;
imdl1.RtR_prior = @prior_laplace;
imdl1.hyperparameter.value = 0.1;

img1 = inv_solve(imdl1, vh, vi);
subplot(235);
show_fem(img1);

% Fine model
imdl2= mk_common_model('c2c0',16);
imdl2.solve = @nodal_solve;
imdl2.RtR_prior = @prior_laplace;
imdl2.hyperparameter.value = 0.1;

img2 = inv_solve(imdl2, vh, vi);
subplot(236);
show_fem(img2);