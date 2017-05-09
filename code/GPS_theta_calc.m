function [theta_average] = GPS_theta_calc()
global theta_vector cmd_mode WHEELCOUNTER theta_counter GPSCOUNTER GPS_Y GPS_X GPS_ready
%persistent theta_vector dim
datapoints = 10;
    if gps_angle_check(datapoints) && theta_counter > datapoints
        %xnew(3) = x(3)+ Konstant*(angle_average(atan2(GPS_Y(GPSCOUNTER)-GPS_Y(GPSCOUNTER-datapoints ),GPS_X(GPSCOUNTER)-GPS_X(GPSCOUNTER-datapoints)),x(3)));%(atan2(GPS_Y(GPSCOUNTER)-GPS_Y(GPSCOUNTER-datapoints ),GPS_X(GPSCOUNTER)-GPS_X(GPSCOUNTER-datapoints))-x(3));
        %xnew(3) = x(3)+ Konstant*(atan2(GPS_Y(GPSCOUNTER)-GPS_Y(GPSCOUNTER-datapoints ),GPS_X(GPSCOUNTER)-GPS_X(GPSCOUNTER-datapoints))-x(3));
        %xnew(3) = angle_average(x(3),atan2(GPS_Y(GPSCOUNTER)-GPS_Y(GPSCOUNTER-datapoints ),GPS_X(GPSCOUNTER)-GPS_X(GPSCOUNTER-datapoints)));
        %gps_theta = xnew(3);
        
        if theta_counter >= (datapoints+1)
           gps_theta = atan2((GPS_Y(GPSCOUNTER)-GPS_Y(GPSCOUNTER-datapoints)),-(GPS_X(GPSCOUNTER)-GPS_X(GPSCOUNTER-datapoints)));
           gps_theta = radtodeg(gps_theta);
           theta_vector = [theta_vector, gps_theta];
           theta_average = meanangle(theta_vector);
           theta_average = degtorad(theta_average);
           %dim=dim+1;
        else
            theta_vector = [0];
            gps_theta = atan2((GPS_Y(GPSCOUNTER)-GPS_Y(GPSCOUNTER-datapoints)),-(GPS_X(GPSCOUNTER)-GPS_X(GPSCOUNTER-datapoints)));
            gps_theta = radtodeg(gps_theta);
            theta_vector = [gps_theta];
            theta_average = gps_theta;
            theta_average = degtorad(theta_average);
            %dim = 2;
        end
        GPS_ready = 1;
    elseif cmd_mode(WHEELCOUNTER) == 1
        theta_counter = 0;
        theta_vector = [0];
        theta_average = NaN;
        GPS_ready = 0;
    else
        theta_average = NaN;
        theta_vector = [0];
        GPS_ready = 0;
    end
    theta_counter = theta_counter + 1;
end