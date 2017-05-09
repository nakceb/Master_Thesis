function [] = init_map(x, y, gsize)
    global map point_distance gridsize
    gridsize = gsize;
    map = robotics.OccupancyGrid(x,y,gridsize); 
    map.FreeThreshold = 0.60;
    map.OccupiedThreshold = 0.7;
    map.ProbabilitySaturation = [0.01 0.99];
    
    point_distance = sqrt((1/(gridsize*2))^2+(1/(gridsize*2))^2)+1/(gridsize*2);
end
