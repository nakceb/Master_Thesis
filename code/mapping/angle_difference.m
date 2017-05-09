function [ anglediff ] = angle_difference( theta_new, theta_old )
    a =  radtodeg(theta_new);
    b = radtodeg(theta_old);
    anglediff = (mod( ( a - b + 180 + 360 ) ,360) ) - 180;
end

