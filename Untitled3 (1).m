%invkinmit(2.3, 2.6, 2) % Home
claw_open()
x=0;
while x<4
    
    invkinmit(3,4,0.3)% P2
    claw_close()
    invkinmit(3, 3.25, 1.25)% P1
    invkinmit(4, 3.25, 1.25)% P1
    invkinmit(4, 4, 0.3)% P4
    claw_open()
    invkinmit(4, 3.25, 1.25)% P3
    x=x+1;
end