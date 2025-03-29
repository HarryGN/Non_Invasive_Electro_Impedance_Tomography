function vv=ff2(raw_data)
%将原始数据组合成256个数据，小数形式存放，单位为V，例如0.123456V，小数部分6位有效
img_voltage=zeros(256,1);%列向量，256行1列	
img_voltage=raw_data;

img_voltage=double(img_voltage);%转换成浮点，8字节	
img_voltage=img_voltage./1000000.0;%单位由uV转换为V	

%单端输入信号时，需要把电压转化成两个电极之间的差值
v=img_voltage;
% for i=1:256
% 	if rem(i,16) == 0
% 		v(i)=abs(v(i)-v(i-15));
% 	else
% 		v(i)=abs(v(i)-v(i+1));
% 	end
% end
img_voltage=v;

%每组测量电压数据需要将与电流注入电极有关的电极电压数据置0
% img_voltage(1:2)=0;
% img_voltage(16)=0;
% img_voltage(17:19)=0;
% img_voltage(34:36)=0;
% img_voltage(51:53)=0;
% img_voltage(68:70)=0;
% img_voltage(85:87)=0;
% img_voltage(102:104)=0;
% img_voltage(119:121)=0;
% img_voltage(136:138)=0;
% img_voltage(153:155)=0;
% img_voltage(170:172)=0;
% img_voltage(187:189)=0;
% img_voltage(204:206)=0;
% img_voltage(221:223)=0;
% img_voltage(238:240)=0;
% img_voltage(241)=0;
% img_voltage(255:256)=0;

vv = img_voltage
end