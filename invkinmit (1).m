function invkinmit(x,y,z)
a = arduino('COM3','mega2560','Libraries','Adafruit/MotorShieldV2');
shield = addon(a,'Adafruit/MotorShieldV2');
configurePin(a, 'A8', 'AnalogInput');  
configurePin(a, 'A9', 'AnalogInput'); 
configurePin(a, 'A10', 'AnalogInput'); 
writeDigitalPin(a,'D52',1);
writeDigitalPin(a,'D53',0);
writeDigitalPin(a,'D50',1);
writeDigitalPin(a,'D51',0);
writeDigitalPin(a,'D48',1);
writeDigitalPin(a,'D49',0);

dcm1 = dcmotor(shield,1);
dcm2 = dcmotor(shield,2);
dcm3 = dcmotor(shield,3);
pin1=readVoltage(a,'A8');
pin2=readVoltage(a,'A9');
pin3=readVoltage(a,'A10');

init_time = 1;
e=0;
f=0;
g=0;
while (init_time==1)
  b=readVoltage(a,'A8');
  c=readVoltage(a,'A9');
  d=readVoltage(a,'A10');
  e=[e,b];
  f=[f,c];
  g=[g,d];
  subplot(3,1,1)
  plot(e)
  grid ON
  subplot(3,1,2)
  plot(f)
  grid ON
  subplot(3,1,3)
  plot(g)
  grid ON
  hold on
  init_time=init_time+1;
  drawnow
  fprintf('value of x: %d\n', pin1);
  fprintf('value of y: %d\n', pin2);
  fprintf('value of z: %d\n', pin3);

while abs(pin1-x)>0.1
    pin1=readVoltage(a,'A8');
    fprintf('value of x: %d\n', pin1);
    if pin1>x
        dcm1.Speed = -0.9;
        start(dcm1)
        pause(1)
    else
        dcm1.Speed = 0.9;
        start(dcm1)
        pause(1)
    end
    stop(dcm1)
    
while abs(pin1-x)>0.01
    pin1=readVoltage(a,'A8');
    fprintf('value of x: %d\n', pin1);
    if pin1>x
        dcm1.Speed = -0.7;
        start(dcm1)
%         pause(0.1)
    else
        dcm1.Speed = 0.7;
        start(dcm1)
%         pause(0.1)
    end
    stop(dcm1)
end
end

while abs(pin2-y)>0.1
    pin2=readVoltage(a,'A9');
    fprintf('value of y: %d\n', pin2);
    if pin2>y
        dcm2.Speed = -0.9;
        start(dcm2)
        pause(2)
    else
        dcm2.Speed = 0.9;
        start(dcm2)
        pause(2)
    end
    stop(dcm2)
    
while abs(pin2-y)>0.01
    pin2=readVoltage(a,'A9');
    fprintf('value of y: %d\n', pin2);
    if pin2>y
        dcm2.Speed = -0.5;
        start(dcm2)
%         pause(0.1)
    else
        dcm2.Speed = 0.5;
        start(dcm2)
%         pause(0.1)
    end
    stop(dcm2)
end
end

while abs(pin3-z)>0.1
    pin3=readVoltage(a,'A10');
    fprintf('value of z: %d\n', pin3);
    if pin3>z
        dcm3.Speed = -0.5;
        start(dcm3)
        pause(1)
    else
        dcm3.Speed = 0.5;
        start(dcm3)
        pause(1)
    end
    stop(dcm3)
    
while abs(pin3-z)>0.01
    pin3=readVoltage(a,'A10');
    fprintf('value of z: %d\n', pin3);
    if pin3>z
        dcm3.Speed = -0.7;
        start(dcm3)
%         pause(0.1)
    else
        dcm3.Speed = 0.7;
        start(dcm3)
%         pause(0.1)
    end
    stop(dcm3)
    init_time = 0;
end
end

end
end
