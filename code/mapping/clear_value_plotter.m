update_values = input('Nya värden?', 's');
if isempty(update_values) == false
    clear X Y Theta gridsize
    
    X = input('X value: ')
    Y = input('Y value: ')
    Theta = input('Theta value: ')
    gridsize = input('Gridsize:  ')
end

point_distance = sqrt((1/(gridsize*2))^2+(1/(gridsize*2))^2)+1/(gridsize*6);
%point_distance = (1/gridsize)*(cosd(Theta)+sind(Theta))
P_dist = 0.3; %Distance from calculated x/y to front of robot
    
    
    thetaplus = Theta + (90);
    thetaminus = Theta - (90);

    %X_shift = X + cosd(Theta)*P_dist;
    %Y_shift = Y + sind(Theta)*P_dist;
    %X_plus = X_shift + cosd(thetaplus)*point_distance;
    %Y_plus = Y_shift + sind(thetaplus)*point_distance;
    %X_min = X_shift + cosd(thetaminus)*point_distance;
    %Y_min = Y_shift + sind(thetaminus)*point_distance;
            
    %X_shift_forw = X + cosd(Theta)*(P_dist+0.1);
    %Y_shift_forw = Y + sind(Theta)*(P_dist+0.1);
    %X_plus_forw = X_shift_forw + cosd(thetaplus)*point_distance;
    %Y_plus_forw = Y_shift_forw + sind(thetaplus)*point_distance;
    %X_min_forw = X_shift_forw + cosd(thetaminus)*point_distance;
    %Y_min_forw = Y_shift_forw + sind(thetaminus)*point_distance;
            
    %X_vector = [X, X_shift, X_plus, X_min, X_shift_forw, X_plus_forw, X_min_forw];
    %Y_vector = [Y, Y_shift, Y_plus, Y_min, Y_shift_forw, Y_plus_forw, Y_min_forw];
    %X_minimum = min(X_vector);
    %X_maximum = max(X_vector);
    %Y_minimum = min(Y_vector);
    %Y_maximum = max(Y_vector);
    
    %figure()
    %plot(X_vector, Y_vector, 'k*')
    %hold on
    
    
    %X_shift = X + cosd(Theta)*P_dist;
    %Y_shift = Y + sind(Theta)*P_dist;
    
    %[X_shift, Y_shift] = Center_of_cell(X_shift,Y_shift,gridsize);
    %X_plus = X_shift + cosd(thetaplus)*point_distance;
    %Y_plus = Y_shift + sind(thetaplus)*point_distance;
    %X_min = X_shift + cosd(thetaminus)*point_distance;
    %Y_min = Y_shift + sind(thetaminus)*point_distance;
            
    %X_shift_forw = X_shift + cosd(Theta)*(1/gridsize);
    %Y_shift_forw = Y_shift + sind(Theta)*(1/gridsize);
    %X_plus_forw = X_shift_forw + cosd(thetaplus)*point_distance;
    %Y_plus_forw = Y_shift_forw + sind(thetaplus)*point_distance;
    %X_min_forw = X_shift_forw + cosd(thetaminus)*point_distance;
    %Y_min_forw = Y_shift_forw + sind(thetaminus)*point_distance;
    
    
    
    
    
    
    %X_vector = [X, X_shift, X_plus, X_min, X_shift_forw, X_plus_forw, X_min_forw];
    %Y_vector = [Y, Y_shift, Y_plus, Y_min, Y_shift_forw, Y_plus_forw, Y_min_forw];
    
    length_sq = floor(66/(100/gridsize));
    width_sq = floor (50/(100/gridsize));
    k=0;
    [X_shift, Y_shift] = Center_of_cell(X,Y,gridsize);
    if mod(width_sq,2) == 0 && Theta <= 270 && Theta >= 90
       X_shift = X_shift -  (1/gridsize);
       Y_shift = Y_shift - (1/gridsize);
    end
% X_shift = X;
% Y_shift = Y;
    for i=1:1:length_sq
        for j=1:1:width_sq
            k=k+1;
            sq_vector(k,1)=X_shift+cosd(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +sind(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            sq_vector(k,2)=Y_shift-sind(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +cosd(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            if i <= (length_sq/4) 
                occ_x = 0.25+0.4*(i/(length_sq/2));
            elseif i >= ((3*length_sq/4))
                occ_x = 0.65-0.4*(i/(length_sq));    
            else
                occ_x = 0.45;
            end
            if i <= (width_sq/4) 
                occ_y = 0.25+0.4*(i/(width_sq/2));
            elseif i >= ((3*width_sq/4))
                occ_y = 0.65-0.4*(i/(width_sq));    
            else
                occ_y = 0.45;
            end
            occval(k,1) = occ_x+occ_y;
        end
    end
    
    X_vector = sq_vector(:,1);
    Y_vector = sq_vector(:,2);
    
    
    X_minimum = min(X_vector);
    X_maximum = max(X_vector);
    Y_minimum = min(Y_vector);
    Y_maximum = max(Y_vector);
    
   
    plot(X_vector, Y_vector, 'b*')
    hold on
    plot(X,Y, 'k^')
    hold on
    
    
    
    
        g_y=[((floor(Y_minimum*gridsize))/gridsize)-(2/gridsize):(1/gridsize):((floor(Y_maximum*gridsize)+0.2)/gridsize)+(2/gridsize)]; % user defined grid Y [start:spaces:end]
        g_x=[((floor(X_minimum*gridsize))/gridsize)-(2/gridsize):(1/gridsize):((floor(X_maximum*gridsize)+0.2)/gridsize)+(2/gridsize)]; % user defined grid X [start:spaces:end]
    for i=1:length(g_x)
        plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        hold on    
    end
    for i=1:length(g_y)
        plot([g_x(1) g_x(end)],[g_y(i) g_y(i)],'k:') %x grid lines
        hold on    
    end
    