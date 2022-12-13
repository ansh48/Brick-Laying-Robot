clc;
clear all;
close all;

a = arduino('COM3','mega2560','Libraries','Adafruit/MotorShieldV2');
shield = addon(a,'Adafruit/MotorShieldV2');
configurePin(a, 'A8', 'AnalogInput');  

dcm1 = dcmotor(shield,2);
% dcm2 = dcmotor(shield,2);
dcm3 = dcmotor(shield,3);
dcm4 = dcmotor(shield,4);
p = 2.7;
pin1=readVoltage(a,'A8');
writeDigitalPin(a,'D52',1);
writeDigitalPin(a,'D53',0);

interv = 20000;
init_time = 1;
x=0;
while (init_time<interv)
  b=readVoltage(a,'A8');
  x=[x,b];
  plot(x)
  grid ON
  init_time=init_time+1;
  drawnow
  disp(b);
end
