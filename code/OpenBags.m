
clear all global

gps_usrinput = 'dag2';%input('Name of GPS log file: ', 's');
gps_filename = sprintf('%s.txt', gps_usrinput);
usrinput = 'real_run';%input('Name of set of log files to read: ', 's');
global Enc_TimeStamp GPS_TimeStamp IMU_TimeStamp Odom_pos_X Odom_pos_Y Odom_ori_Z GPS_status
global GPS_X GPS_Y cmd_mode L_wheel R_wheel
global Acc_1_X Acc_2_X Gyro_1_Z Gyro_2_Z IMU_calibration_vector Acc_1_Y Acc_1_Z Acc_2_Y Acc_2_Z

%IMU
logname = sprintf('%s_imu.txt', usrinput);
delimiterIn = ' ';
headerlinesIn = 2;
IMUlog = importdata(logname,delimiterIn,headerlinesIn);
j=0;
for k=1:1:2
    for M=1:1:12
        j=j+1;
        IMU_calibration_vector(j) = IMUlog.data(k, M);
    end
end
disp('IMU_calibration data loaded')
length = size(IMUlog.data);
j=0;
for k=3:1:length(1,1)
        j=j+1;
        IMU_TimeStamp(j) = IMUlog.data(k, 1);
        Acc_1_X(j) = IMUlog.data(k,2);
        Acc_1_Y(j) = IMUlog.data(k,3);
        Acc_1_Z(j) = IMUlog.data(k,4);
        Acc_2_X(j) = IMUlog.data(k,5);
        Acc_2_Y(j) = IMUlog.data(k,6);
        Acc_2_Z(j) = IMUlog.data(k,7);
        Gyro_1_X(j) = IMUlog.data(k,8);
        Gyro_1_Y(j) = IMUlog.data(k,9);
        Gyro_1_Z(j) = IMUlog.data(k,10);
        Gyro_2_X(j) = IMUlog.data(k,11);
        Gyro_2_Y(j) = IMUlog.data(k,12);
        Gyro_2_Z(j) = IMUlog.data(k,13);
end
disp('IMU data loaded')


%odom
logname = sprintf('%s_odom.txt', usrinput);
delimiterIn = ' ';
headerlinesIn = 1;
odomlog = importdata(logname,delimiterIn,headerlinesIn);
length = size(odomlog.data);
j=0;
for k=1:1:length(1,1)
        j=j+1;
        Odom_TimeStamp(j) = odomlog.data(k, 1);
        Odom_pos_X(j) = odomlog.data(k,2);
        Odom_pos_Y(j) = odomlog.data(k,3);
        Odom_pos_Z(j) = odomlog.data(k,4);
        Odom_ori_X(j) = odomlog.data(k,5);
        Odom_ori_Y(j) = odomlog.data(k,6);
        Odom_ori_Z(j) = odomlog.data(k,7);
end
disp('Odometry data loaded')


%encoder
logname = sprintf('%s_encoder.txt', usrinput);
delimiterIn = ' ';
headerlinesIn = 1;
enclog = importdata(logname,delimiterIn,headerlinesIn);
length = size(enclog.data);
j=0;
for k=1:1:length(1,1)
        j=j+1;
        Enc_TimeStamp(j) = enclog.data(k, 1);
        L_ticks(j) = enclog.data(k,2);
        R_ticks(j) = enclog.data(k,3);
        L_wheel(j) = enclog.data(k,4);
        R_wheel(j) = enclog.data(k,5);
        L_wheel_accum(j) = enclog.data(k,6);
        R_wheel_accum(j) = enclog.data(k,7);
end
disp('Encoder data loaded')


%Sensor_status
logname = sprintf('%s_sensorstatus.txt', usrinput);
delimiterIn = ' ';
headerlinesIn = 1;
sensorlog = importdata(logname,delimiterIn,headerlinesIn);
length = size(sensorlog.data);
j=0;
for k=1:1:length(1,1)
        j=j+1;
        Sensor_TimeStamp(j) = sensorlog.data(k, 1);
        Sensor_status(j) = sensorlog.data(k,2);
end
disp('Sensor data loaded')



%GPS
delimiterIn = ' ';
headerlinesIn = 1;
GPSlog = importdata(gps_filename,delimiterIn,headerlinesIn);

Stop_datapoint = 15000; %dag 2
Start_datapoint = 3;
j=1;
disp('Deleting duplicate GPS rows...')
GPS_data = unique(GPSlog.data, 'rows');
disp('Done!') 
length = size(GPS_data);
 for k=Start_datapoint:1:(length(1,1)-Stop_datapoint)
     if isnan(GPS_data(k,8))|| GPS_data(k,2) < 2e+06
         j=j;
     else
     %elseif GPS_data(k,5)==1 && (GPS_data(k,2)-GPS_data(Start_datapoint,2))>-10       %hard coded for dag2 run
        GPS_TimeStamp(j) = GPS_data(k,1);
        GPS_X(j) = GPS_data(k,2);
        GPS_Y(j) = GPS_data(k,3);
        GPS_Z(j) = GPS_data(k,4);
        GPS_status(j) = GPS_data(k,5);
        GPS_SdX(j) = GPS_data(k,6);
        GPS_SdY(j) = GPS_data(k,7);
        GPS_SdZ(j) = GPS_data(k,8);
        j=j+1;
     end;
end
disp('GPS data loaded')


%Pose
logname = sprintf('%s_pose.txt', usrinput);
delimiterIn = ' ';
headerlinesIn = 1;
poselog = importdata(logname,delimiterIn,headerlinesIn);
length = size(poselog.data);
j=0;
for k=1:1:length(1,1)
        j=j+1;
        Pose_TimeStamp(j) = poselog.data(k, 1);
        Pose_pos_X(j) = poselog.data(k,2);
        Pose_pos_Y(j) = poselog.data(k,3);
        Pose_pos_Z(j) = poselog.data(k,4);
        Pose_ori_X(j) = poselog.data(k,5);
        Pose_ori_Y(j) = poselog.data(k,6);
        Pose_ori_Z(j) = poselog.data(k,7);
end
disp('Pose data loaded')



%Loop
logname = sprintf('%s_loop.txt', usrinput);
delimiterIn = ' ';
headerlinesIn = 1;
looplog = importdata(logname,delimiterIn,headerlinesIn);
length = size(looplog.data);
j=0;
for k=1:1:length(1,1)
        j=j+1;
        Loop_TimeStamp(j) = looplog.data(k, 1);
        Loop_Front_center(j) = looplog.data(k,2);
        Loop_Front_center_N(j) = looplog.data(k,3);
        Loop_Front_center_F(j) = looplog.data(k,4);

end
disp('Loop data loaded')
%cmd_vel saves rotation under 1 linear motion under 2
cmd_mode=[];
length = size(Odom_TimeStamp);
length = length(2);
for i = 2:length
    if abs(Odom_ori_Z(i)-Odom_ori_Z(i-1))>0.005 && abs(Odom_ori_Z(i-1)-Odom_ori_Z(i-2))>0.005
        cmd_mode = [cmd_mode,1]; 
    else
        cmd_mode = [cmd_mode,2]; 
    end
end


     
