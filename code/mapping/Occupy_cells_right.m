function [] = Occupy_cells_right(X, Y, Theta) %Clear_cells(X, Y, Theta, X_p, Y_p, Theta_p)
    global map point_distance gridsize
    
    point_distance = sqrt((1/(gridsize*2))^2+(1/(gridsize*2))^2)+1/(gridsize*4);
    length_sq = floor(66/(100/gridsize))+8;
    width_sq = floor (50/(100/gridsize))+8;
    k=0;

X_shift = X;
Y_shift = Y;
probability_param = 0.4;
    for i=1:1:length_sq
        for j=(width_sq/2):1:width_sq
            k=k+1;
            
            sq_vector(k,1)=X_shift+cosd(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +sind(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            sq_vector(k,2)=Y_shift-sind(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +cosd(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            occ_x = probability_param*((i+4)/(length_sq));    
            %occ_x = 0.55*((i)/(length_sq));
            if (j) <= (width_sq/2) 
                %occ_y = (1.25*probability_param-(probability_param/2))+(probability_param/2)*((j-1)/(width_sq/2));
                %occ_y = 0.35+0.2*((j-1)/(width_sq/2));
                occ_y = 0;
                occ_x = 0;
            elseif (j) > ((3*width_sq/4))
                occ_y = (1.25*probability_param-probability_param/2)+(probability_param/2)*((j-(width_sq/2)-1)/(width_sq/2));
                %occ_y = 0.55-0.2*((j-6)/(width_sq/2));    
            else
                occ_y = probability_param;
            end
            if occ_x+occ_y >= 1
                occval(k,1) = 0.95;
            elseif occ_x+occ_y < 0.5
                occval(k,1) = 0.5;
            else
                occval(k,1) = occ_x+occ_y;
            end
        end
    end


    
    X_vector = sq_vector(:,1);
    Y_vector = sq_vector(:,2);
    
    ij=[X_vector, Y_vector];    
    updateOccupancy(map, ij, occval);

end