%Occupancy grid mapping ändra till bra positionsdata från GPS i ROS samt
%ändra till lawn0
init_ROS_comp();
%%
close all
clear all
subgps = rossubscriber('/fix');
substatus = rossubscriber('/sensor_status');
subodom =rossubscriber('/odom');
pubcmd = rospublisher('/cmd_vel','geometry_msgs/Twist');
subloop = rossubscriber('/loop');
cmd_message = rosmessage('geometry_msgs/Twist');
%GPS referens-data, måste ändras för riktiga klipparen
latitude_ref = 59.33258;
longitude_ref = 18.0649;
Latitude_const = 111111.1;
Longitude_const = 111111.1 * cosd(latitude_ref);

%mapping stuff:
%create probabilistic occupancy grid, width, height, resolution (cells per
%meter) as input variables
% map.XWorldLimits = [-20 20];
% map.YWorldLimits = [-20 20];
map = robotics.OccupancyGrid(20,20,10);

map.FreeThreshold = 0.3;
map.OccupiedThreshold = 0.7;
map.ProbabilitySaturation = [0.01 0.99];

P_dist = 0.3;


K=1;
t=0;
point_distance = 0.1;
while(true)
        t=t+1;
        
        x_gps = (subgps.LatestMessage.Latitude - latitude_ref)*Latitude_const+10;
        y_gps = (longitude_ref - subgps.LatestMessage.Longitude)*Longitude_const+10;
        X = subodom.LatestMessage.Pose.Pose.Position.X  +10;
        Y = subodom.LatestMessage.Pose.Pose.Position.Y  +10;
        z = subodom.LatestMessage.Pose.Pose.Orientation.Z;
        w = subodom.LatestMessage.Pose.Pose.Orientation.W;
        quat = [w 0 0 z];
        eulZYX = quat2eul(quat);
%         a0_frontcenter = subloop.LatestMessage.A0.FrontCenter;
%         a0_frontright = subloop.LatestMessage.A0.FrontRight;
%         a0_rearleft = subloop.LatestMessage.A0.RearLeft;
%         a0_rearright = subloop.LatestMessage.A0.RearRight;
        X_shift = X + cos(eulZYX(1))*P_dist;
        Y_shift = Y + sin(eulZYX(1))*P_dist;
        figure(1)
        plot(X, Y, 'rx')
        hold on
        plot(X_shift, Y_shift, 'b*')
        hold on
        drawnow
        if(substatus.LatestMessage.SensorStatus_ == 4)
            %ij = world2grid(map, [x_gps y_gps]);
            thetaplus = eulZYX(1)+(pi/2);
            thetaminus = eulZYX(1)- (pi/2);
            X_plus = X_shift + cos(thetaplus)*point_distance;
            Y_plus = Y_shift + sin(thetaplus)*point_distance;
            X_min = X_shift + cos(thetaminus)*point_distance;
            Y_min = Y_shift + sin(thetaminus)*point_distance;
            
            X_shift_forw = X + cos(eulZYX(1))*(P_dist+0.1);
            Y_shift_forw = Y + sin(eulZYX(1))*(P_dist+0.1);
            X_plus_forw = X_shift_forw + cos(thetaplus)*point_distance;
            Y_plus_forw = Y_shift_forw + sin(thetaplus)*point_distance;
            X_min_forw = X_shift_forw + cos(thetaminus)*point_distance;
            Y_min_forw = Y_shift_forw + sin(thetaminus)*point_distance;
            
            
            ij=[X_shift Y_shift; X_plus Y_plus; X_min Y_min; X_shift_forw, Y_shift_forw; X_plus_forw, Y_plus_forw; X_min_forw, Y_min_forw];
            occval=[0.9;0.7;0.7; 0.9; 0.7; 0.7];
            %setOccupancy(map,ij,occval,'grid') 
            updateOccupancy(map, ij, occval);
            %inflate(map, 0.1);
            figure(2)
            show(map)
            
            if K ==1
                K=-1;
                rot_vel = 2*(0.5-rand);
            cmd_message.Linear.X = K;
            cmd_message.Angular.Z = rot_vel;
            send(pubcmd,cmd_message); %send cmd_vel rotating	
            pause(5*rand);
            else
                K=1;
                rot_vel = 2*(0.5-rand);
            cmd_message.Linear.X = K;
            cmd_message.Angular.Z = rot_vel;
            send(pubcmd,cmd_message); %send cmd_vel rotating	
            pause(4*rand);
            end
        else
            %ij = world2grid(map, [x_gps y_gps]);
            thetaplus = eulZYX(1)+(pi/2);
            thetaminus = eulZYX(1)- (pi/2);
            X_plus = X_shift + cos(thetaplus)*point_distance;
            Y_plus = Y_shift + sin(thetaplus)*point_distance;
            X_min = X_shift + cos(thetaminus)*point_distance;
            Y_min = Y_shift + sin(thetaminus)*point_distance;
            ij=[X_shift Y_shift; X_plus Y_plus; X_min Y_min];
            occval=[0.1; 0.2; 0.2];
            updateOccupancy(map, ij, occval);
            %setOccupancy(map,ij,occval,'grid') 
            %inflate(map, 0.1);
            figure(2)
            show(map)
            K=1;
            cmd_message.Linear.X = K;
            cmd_message.Angular.Z =-0.2; %-0.1;

            send(pubcmd,cmd_message)
        end;


%         figure(2)
%         plot(t,a0_frontcenter, 'rx')
%         hold on
%         plot(t, a0_frontright, 'k-')
%         hold on
%         plot(t, a0_rearleft, 'g*')
%         hold on
%         plot(t, a0_rearright, 'b^')
%         hold on
%         drawnow
        
end