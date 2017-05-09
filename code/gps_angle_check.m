function [ bool ] = gps_angle_check(datapoints )
global cmd_mode WHEELCOUNTER
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bool =1;
for i = 1:datapoints
    if cmd_mode(WHEELCOUNTER-i)==1
        bool = 0;
    end
end
    
end

