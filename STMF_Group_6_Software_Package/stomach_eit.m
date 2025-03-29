figure('visible','on')%开启弹窗

%run eidors\startup.m	

imdl= mk_common_model('c2t3',16);
% most EIT systems image best with normalized difference
imdl.fwd_model = mdl_normalize(imdl.fwd_model, 1);
imdl.RtR_prior= @prior_gaussian_HPF;

% electrodes start on back (dorsal), then do this
imdl.fwd_model.electrode([9:16,1:8])=  ...
   imdl.fwd_model.electrode;


subplot(221);
show_fem(imdl.fwd_model);

axis equal
print_convert tutorial410a.png;
%%


fid=fopen('D:\UofT\Capstone\eit_gui\output\vvRefRaw.txt','r');%读取均匀介质帧电压数据uV
vvRefRaw=fscanf(fid,'%f');
fclose(fid);

fid=fopen('D:\UofT\Capstone\eit_gui\output\vvAvgRaw.txt','r');%读取介质帧电压数据uV
vvAvgRaw=fscanf(fid,'%f');
fclose(fid);

vvRef = ff(vvRefRaw)
fid=fopen('.\vvRef.txt','w+t');%保存均匀介质帧原始电压数据到文件
fprintf(fid,'%g\r\n',vvRef);
fclose(fid);

vvAvg = ff(vvAvgRaw)
fid=fopen('.\vvAvg.txt','w+t');%保存均匀介质帧原始电压数据到文件
fprintf(fid,'%g\r\n',vvAvg);
fclose(fid);

 % x = 1:1:256; plot(x,vvAvg,'b--o')
 % pause 10

% Abdomen Images  $Id: tutorial410b.m 4839 2015-03-30 07:44:50Z aadler $

%load montreal_data_1995
imdl.hyperparameter.value=.2;
%vh= zc_h_stomach_pre; % abdomen before fluid
%vi= zc_stomach_0_5_60min; % each 5 minutes after drink
%img= inv_solve(imdl, vh, vi);
img = inv_solve(imdl,vvRef,vvAvg);

clf; show_slices(img)
axis equal

print_convert tutorial410b.png;


		
