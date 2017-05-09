function [ znew ] = get_new_IMU( z )
global IMUCOUNTER Acc_1_X Acc_2_X Gyro_1_Z Gyro_2_Z IMU_calibration_vector Acc_1_Y Acc_1_Z Acc_2_Y Acc_2_Z

    A_constant = 6/10000; %raw data to m/s^2 (really 9.82*2/32768)
    G_constant = 250/32768; %uncertain about this
    %z_3 =  (Acc_1_X(IMUCOUNTER)-238.5439)*A_constant; % - IMU_calibration_vector(1);
    %z_4 =  (Acc_2_X(IMUCOUNTER)-142.8875)*A_constant; % - IMU_calibration_vector(4);
    z_3 = (Acc_1_X(IMUCOUNTER)-abs(sqrt((10.825157332397808/A_constant)^2-Acc_1_Z(IMUCOUNTER)^2 - Acc_1_Y(IMUCOUNTER)^2)))*A_constant - IMU_calibration_vector(1);
    z_4 =  (Acc_2_X(IMUCOUNTER)-((9.526537836718489/A_constant)^2-norm([Acc_2_Z(IMUCOUNTER) Acc_2_Y(IMUCOUNTER)])))*A_constant - IMU_calibration_vector(4);
    z_5 =  Gyro_1_Z(IMUCOUNTER)*G_constant - IMU_calibration_vector(9);
    z_6 =  Gyro_2_Z(IMUCOUNTER)*G_constant - IMU_calibration_vector(12);
    
    znew=[z(1);z(2);z_3;z_4;z_5; z_6];


end

