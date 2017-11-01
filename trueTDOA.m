function tdoa = trueTDOA(DOA)
% Author: Xu Chenglin (NTU, Singapore)
% Date: 3 Dec 2016
% Format: 1 Nov 2017

%mic position in x-y plan in unit of meters. array center is the origin. 
mic_theta = 0:pi/4:(2*pi-0.1);
mic = [sin(mic_theta); cos(mic_theta)]*0.1; 

DOA_xy = -[sin(DOA/180*pi); cos(DOA/180*pi)];

projection = mic'*DOA_xy;

% use the first channel as the reference channel
% negative projection means channel is earlier than the ref channel
projection = projection - projection(1);  

tdoa = projection / 345 * 16000;

end
