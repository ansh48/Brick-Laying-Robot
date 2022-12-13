function claw_close()
a = arduino('COM3','mega2560','Libraries','Adafruit/MotorShieldV2');
shield = addon(a,'Adafruit/MotorShieldV2');
dcm4 = dcmotor(shield,4);
dcm4.Speed = -0.7;
start(dcm4)
pause(1)
stop(dcm4)
end