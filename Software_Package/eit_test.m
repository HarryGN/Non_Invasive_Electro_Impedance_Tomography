figure('visible','on')%开启弹窗

run D:\UofT\Capstone\eit_gui\eidors\startup.m	

inv_model = mk_common_model('c2c',16);%网络密度为j，2D模型,c环状网络，16电极 j2c	d2d4c
options = {'no_meas_current'};
[stim, meas_select] = mk_stim_patterns(16,1,'{ad}','{ad}',options,6);
inv_model.fwd_model.stimulation = stim;
inv_model.fwd_model.meas_select = meas_select

 inv_model.solve = @inv_solve_diff_GN_one_step;	%nodal_solve  inv_solve_diff_GN_one_step

fid=fopen('D:\UofT\Capstone\eit_gui\output3\vvRefRaw.txt','r');%读取均匀介质帧电压数据uV
vvRefRaw=fscanf(fid,'%f');
fclose(fid);

fid=fopen('D:\UofT\Capstone\eit_gui\output3\vvAvgRaw.txt','r');%读取介质帧电压数据uV
vvAvgRaw=fscanf(fid,'%f');
fclose(fid);

vvRef = ff(vvRefRaw)
fid=fopen('D:\UofT\Capstone\eit_gui\vvRef.txt','w+t');%保存均匀介质帧原始电压数据到文件
fprintf(fid,'%g\r\n',vvRef);
fclose(fid);

vvAvg = ff(vvAvgRaw)
fid=fopen('D:\UofT\Capstone\eit_gui\vvAvg.txt','w+t');%保存均匀介质帧原始电压数据到文件
fprintf(fid,'%g\r\n',vvAvg);
fclose(fid);

 % x = 1:1:256; plot(x,vvAvg,'b--o')
 % pause 10

img = inv_solve(inv_model,vvRef,vvAvg);%动态成像模式：vvRef，参考电压数据，vvAvg本次测量电压数据
calc_colours('npoints',256)
out_img = show_slices(img);%显示不带网络剖分
eidors_colourbar(img);%显示彩虹条		
