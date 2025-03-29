figure('visible','on')%��������

run D:\UofT\Capstone\eit_gui\eidors\startup.m	

inv_model = mk_common_model('c2c',16);%�����ܶ�Ϊj��2Dģ��,c��״���磬16�缫 j2c	d2d4c
options = {'no_meas_current'};
[stim, meas_select] = mk_stim_patterns(16,1,'{ad}','{ad}',options,6);
inv_model.fwd_model.stimulation = stim;
inv_model.fwd_model.meas_select = meas_select

 inv_model.solve = @inv_solve_diff_GN_one_step;	%nodal_solve  inv_solve_diff_GN_one_step

fid=fopen('D:\UofT\Capstone\eit_gui\output3\vvRefRaw.txt','r');%��ȡ���Ƚ���֡��ѹ����uV
vvRefRaw=fscanf(fid,'%f');
fclose(fid);

fid=fopen('D:\UofT\Capstone\eit_gui\output3\vvAvgRaw.txt','r');%��ȡ����֡��ѹ����uV
vvAvgRaw=fscanf(fid,'%f');
fclose(fid);

vvRef = ff(vvRefRaw)
fid=fopen('D:\UofT\Capstone\eit_gui\vvRef.txt','w+t');%������Ƚ���֡ԭʼ��ѹ���ݵ��ļ�
fprintf(fid,'%g\r\n',vvRef);
fclose(fid);

vvAvg = ff(vvAvgRaw)
fid=fopen('D:\UofT\Capstone\eit_gui\vvAvg.txt','w+t');%������Ƚ���֡ԭʼ��ѹ���ݵ��ļ�
fprintf(fid,'%g\r\n',vvAvg);
fclose(fid);

 % x = 1:1:256; plot(x,vvAvg,'b--o')
 % pause 10

img = inv_solve(inv_model,vvRef,vvAvg);%��̬����ģʽ��vvRef���ο���ѹ���ݣ�vvAvg���β�����ѹ����
calc_colours('npoints',256)
out_img = show_slices(img);%��ʾ���������ʷ�
eidors_colourbar(img);%��ʾ�ʺ���		
