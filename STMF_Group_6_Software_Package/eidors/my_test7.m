
cd C:\Users\qldeng\Documents\eit_gui\eidors;

run startup.m

clear;
clc;

[stim,msel] = mk_stim_patterns(16,1, '{ad}' , '{ad}' ,{'no_meas_current'},1);



fmdl = mk_common_model('d2d0c',16)
fmdl.stimulation = stim;
fmdl.meas_select = msel;
img = mk_image( fmdl, 1);
% simulate homogeneous
vh = fwd_solve(img);

subplot(231);
show_fem(img,[1 1 0]);
subplot(232);
plot(vh.meas);

%%方法1：创建1个圆形球
% % select_fcn = '(x-0.0).^2+(y-0.5).^2<0.4^2';
% % or select_fcn = inline('(x-0.2).^2+(y-0.5).^2<0.2^2','x','y','z');
% memb_frac = elem_select( img.fwd_model, select_fcn)
% img.elem_data = 1 + memb_frac*1;

%%方法2：创建2个圆形球
DeltaC1 = -0.2; %-电阻率低
DeltaC2 = 0.3;  %+电阻率高
target= mk_c2f_circ_mapping(img.fwd_model, [[0.2;0.0;0.3],[-0.5;0;0.2]]);
img.elem_data = 1+ DeltaC1*target(:,1) + DeltaC2*target(:,2) ;


% simulate inhomogeneous
% img.elem_data( [1 53 122] ) = 1.6;
% img.elem_data( [2 52 121] ) = 0.2;
vi = fwd_solve(img);

subplot(233); 
show_fem(img,[1 1 0]);

subplot(234);
plot(vi.meas);

num_elems = num_elems( fmdl );
num_elecs = num_elecs( fmdl );
n_nodes = num_nodes( fmdl );







% imdl = mk_common_model('c2c0',16);
% imdl.fwd_model.stimulation = stim;
% imdl.fwd_model.meas_select = msel;
% imdl.hyperparameter.value = 0.10;
% % reconstruct normally
imdl=fmdl;


imdl.RtR_prior = @prior_laplace;
imdl.hyperparameter.value = 0.1;

subplot(235); 
show_fem( inv_solve( imdl, vh.meas, vi.meas));
% % reconstruct abs
vha = vh.meas;
via = vi.meas;

imdl1.solve = @nodal_solve;
imdl1.RtR_prior = @prior_laplace;
imdl1.hyperparameter.value = 0.1;

subplot(236); 
show_fem( inv_solve( imdl, vha, via));



