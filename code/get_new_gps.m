function [ vector ] = get_new_gps( noise )
%Returns the value of the gps coordinats, +-noise 
persistent random_walk
global GPSCOUNTER GPS_X GPS_Y GPS_X_START GPS_Y_START WHEELCOUNTER

if isempty(random_walk)
    random_walk =0;
end
    constant = 0;
    random_walk = random_walk +  constant*noise*(randn); %generate random walk

    x = GPS_X(GPSCOUNTER) - GPS_X_START + noise*(randn)+random_walk;
    y = GPS_Y(GPSCOUNTER) - GPS_Y_START + noise*(randn)+random_walk;
    vector = [x;y];
end

