function [] = Bumper_hit(X, Y, Theta) %Bumper_hit(X, Y, Theta, X_p, Y_p, Theta_p)
    global map point_distance gridsize
    width_robot = 0.5;
    P_dist = 0.3; %Distance from calculated x/y to front of robot
    
    
    thetaplus = Theta + (90);
    thetaminus = Theta - (90);
    
    X_shift = X + cosd(Theta)*P_dist;
    Y_shift = Y + sind(Theta)*P_dist;
    [X_shift, Y_shift] = Center_of_cell(X_shift,Y_shift,gridsize);
    X_plus = X_shift + cosd(thetaplus)*point_distance;
    Y_plus = Y_shift + sind(thetaplus)*point_distance;
    X_min = X_shift + cosd(thetaminus)*point_distance;
    Y_min = Y_shift + sind(thetaminus)*point_distance;
            
    X_shift_forw = X + cosd(Theta)*(P_dist+(1/gridsize));
    Y_shift_forw = Y + sind(Theta)*(P_dist+(1/gridsize));
    X_plus_forw = X_shift_forw + cos(thetaplus)*point_distance;
    Y_plus_forw = Y_shift_forw + sin(thetaplus)*point_distance;
    X_min_forw = X_shift_forw + cos(thetaminus)*point_distance;
    Y_min_forw = Y_shift_forw + sin(thetaminus)*point_distance;
            
            
    ij=[X_shift Y_shift; X_plus Y_plus; X_min Y_min; X_shift_forw, Y_shift_forw; X_plus_forw, Y_plus_forw; X_min_forw, Y_min_forw];
    occval=[0.9;0.7;0.7; 0.9; 0.7; 0.7];
     
    updateOccupancy(map, ij, occval);

end