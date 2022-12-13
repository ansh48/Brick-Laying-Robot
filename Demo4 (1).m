% You need to call "webcamlist" to find what webcams you have
% >> webcamlist
% gives me
% ans =
% 2×1 cell array
% {'FaceTime HD Camera (Built-in)'}
% {'USB Camera' }
clc;
clear all;
clear('cam'); % clear the cam object so you can make a new one
cam = webcam('UVC Camera'); %open the camera
a = arduino('COM3','mega2560','Libraries','Adafruit/MotorShieldV2');
shield = addon(a,'Adafruit/MotorShieldV2');
dcm1 = dcmotor(shield,1);
dcm2 = dcmotor(shield,2);
x=1024;
pin1=0;

while (true)

while abs(pin1-x)>30

    RGB = snapshot(cam);
    % figure(1)
    % imshow(RGB) %original
    %%%%%%%%%%%%%% FROM colorThresholder %%%%%%%%%%%%%%%%%%
    % I used the Matlab app colorThresholder to find the points for my mask, which is red
    % Convert RGB image to chosen color space
    I = rgb2hsv(RGB);
    % Define thresholds for channel 1 based on histogram settings
    channel1Min = 0.694;
    channel1Max = 0.000;
    % Define thresholds for channel 2 based on histogram settings
    channel2Min = 0.059;
    channel2Max = 1.000;
    % Define thresholds for channel 3 based on histogram settings
    channel3Min = 0.141;
    channel3Max = 0.882;
    % Create mask based on chosen histogram thresholds
    sliderBW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
    BW = sliderBW;
    % Initialize output masked image based on input image.
    maskedRGBImage = RGB;
    % Set background pixels where BW is false to zero.
    maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
    %%%%%%%%%%%%% END FROM colorThresholder %%%%%%%%%%%%%%%%
    % figure(2);clf;
    % imshow(maskedRGBImage)
    %https://www.mathworks.com/help/images/ref/bwconncomp.html is easier.
    CC = bwconncomp(sliderBW);
    s = regionprops(CC,'Centroid','Area');
    centroids = cat(1,s.Centroid);
    areas = cat(1,s.Area);
    [m,ind] = max(areas); % find the largest connected component
    figure(3);clf;
    imshow(double(sliderBW))
    hold on
    %plot(centroids(:,1),centroids(:,2),'b*')
    % for i = 1:numel(areas) % this shows all the spots
    % text(centroids(i,1),centroids(i,2),num2str(areas(i) ),'color','r')
    % end
    plot(centroids(ind,1),centroids(ind,2),'m*','markersize',32)
    % put a star on the largest connected component.
    % This is where you should aim your robot.
    
    pin1 = centroids(ind,1);

    fprintf('value of x: %d\n', pin1);
    if pin1>x
        dcm1.Speed = -0.5;
        start(dcm1)
        pause(0.1)
    else
        dcm1.Speed = 0.5;
        start(dcm1)
        pause(0.1)
    end
    stop(dcm1)
end

end