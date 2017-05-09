function [ Theta_imu, Theta_imu_dot ] = IMU_integrate( Theta_dot, dt, Theta_imu_old )
Theta_imu = Theta_imu_old + 0.0198*0.974*(-Theta_dot)*dt;
Theta_imu = wrapToPi(Theta_imu);

Theta_imu_dot = 0.0198*0.974*(-Theta_dot);
Theta_imu_dot = wrapToPi(Theta_imu_dot);

end

