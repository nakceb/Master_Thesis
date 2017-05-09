function [ bool ] = all_fix( length )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global GPS_status GPSCOUNTER
bool = 1;
gps_lenght = size(GPS_status);
    
    for i= 1:1:length
        if GPSCOUNTER+i < gps_lenght(2)
            if GPS_status(GPSCOUNTER+i) ~=1%GPS_status(GPSCOUNTER-i) ~= 1 && GPS_status(GPSCOUNTER+i) ~=1
                bool = 0;
                break
            end
        end
    end
    
end

