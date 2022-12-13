clc;
clear all;
close all;

a = arduino('COM3','mega2560','Libraries','Adafruit/MotorShieldV2');
shield = addon(a,'Adafruit/MotorShieldV2');
configurePin(a, 'A8', 'AnalogInput');  
writeDigitalPin(a,'D52',1);
writeDigitalPin(a,'D53',0);

dcm1 = dcmotor(shield,2);
% dcm2 = dcmotor(shield,2);
dcm3 = dcmotor(shield,3);
dcm4 = dcmotor(shield,4);
p = 2.7;
pin1=readVoltage(a,'A8');

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


while abs(pin1-p)>0.01
    writeDigitalPin(a,'D50',1);
    writeDigitalPin(a,'D51',0);
    pin1=readVoltage(a,'A8');
    fprintf('value of a: %d\n', pin1);
    if pin1>p
        dcm1.Speed = 0.9;
        start(dcm1)
    else
        dcm1.Speed = 0.9;
        start(dcm1)
    end
    stop(dcm1)
    writeDigitalPin(a,'D50',0);
end
end
