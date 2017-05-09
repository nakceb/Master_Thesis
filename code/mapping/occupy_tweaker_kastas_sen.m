 clear map ij occval sq_vector J 
global map
gridsize = 20;
Theta = 0;
init_map(20,20,gridsize)    

point_distance = sqrt((1/(gridsize*2))^2+(1/(gridsize*2))^2)+1/(gridsize*6);

%point_distance = (1/gridsize)*(cosd(Theta)+sind(Theta))
    length_sq = floor(66/(100/gridsize))+4;
    width_sq = floor (50/(100/gridsize))+6;
    k=0;

    
    
% for J=1:1:5
% X_shift = 10.25;
% Y_shift = 10.25+J/20;
% probability_param = 0.35;
%     for i=1:1:length_sq
%         for j=1:1:width_sq
%             k=k+1;
%             sq_vector(k,1)=X_shift+cosd(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +sind(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
%             sq_vector(k,2)=Y_shift-sind(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +cosd(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
%             occ_x = probability_param*((i)/(length_sq));    
%             %occ_x = 0.55*((i)/(length_sq));
%             if (j) <= (width_sq/4) 
%                 occ_y = (1.25*probability_param-(probability_param/2))+(probability_param/2)*((j-1)/(width_sq/2));
%                 %occ_y = 0.35+0.2*((j-1)/(width_sq/2));
%             elseif (j) > ((3*width_sq/4))
%                 occ_y = 1.25*probability_param-(probability_param/2)*((j-6)/(width_sq/2));
%                 %occ_y = 0.55-0.2*((j-6)/(width_sq/2));    
%             else
%                 occ_y = probability_param;
%             end
%             if occ_x+occ_y >= 1
%                 occval(k,1) = 0.95;
%             elseif occ_x+occ_y < 0.5
%                 occval(k,1) = 0.5;
%             else
%                 occval(k,1) = occ_x+occ_y;
%             end
%         end
%     end
G=2;
if G==1

for M=1:1:1
X_shift = 10;
Y_shift = 10+M/20;
probability_param = 0.3;
    for i=1:1:length_sq
        for j=(width_sq/2)+2:1:width_sq
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
end

else
for J=1:1:1
X_shift = 10;
Y_shift = 10+J/20;

   % [X_shift, Y_shift] = Center_of_cell(X,Y,gridsize);
    if mod(width_sq,2) == 0 && Theta <= 270 && Theta >= 90
       X_shift = X_shift -  (1/gridsize);
       Y_shift = Y_shift - (1/gridsize);
    end
    
probability_param = 0.3;
    for i=1:1:length_sq
        for j=1:1:width_sq/2
            k=k+1;
            sq_vector(k,1)=X_shift+cosd(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +sind(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            sq_vector(k,2)=Y_shift-sind(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +cosd(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            occ_x = probability_param*((i+4)/(length_sq));    
            %occ_x = 0.55*((i)/(length_sq));
            if (j) <= (width_sq/4) 
                occ_y = (1.25*probability_param)-(probability_param/2)*((j-1)/(width_sq/2));
                %occ_y = 0.35+0.2*((j-1)/(width_sq/2));
            elseif (j) > ((width_sq/2))
                occ_y = 0;
                occ_x = 0;
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
end
end
    X_vector = sq_vector(:,1);
    Y_vector = sq_vector(:,2);
    
    ij=[X_vector, Y_vector];    
    updateOccupancy(map, ij, occval);
    occval=0.1;
    ij=[X_shift, Y_shift];
    updateOccupancy(map,ij,occval)

    
show(map)