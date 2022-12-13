clc;
clear all;
close all;

a = arduino('COM3','mega2560','Libraries','Adafruit/MotorShieldV2');
shield = addon(a,'Adafruit/MotorShieldV2');
configurePin(a, 'A8', 'AnalogInput');  

dcm1 = dcmotor(shield,1);
dcm2 = dcmotor(shield,2);
dcm3 = dcmotor(shield,3);
dcm4 = dcmotor(shield,4);
p = 2.7;
pin1=readVoltage(a,'A8');

interv = 20000;
init_time = 1;
x=0;
while (x<20)
writeDigitalPin(a,'D52',1);
writeDigitalPin(a,'D53',0);
dcm2.Speed = -0.9;
start(dcm2)
x=x+1;
end
stop(dcm2)
writeDigitalPin(a,'D50',0);