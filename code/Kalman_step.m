%%Kalman_step - One iteration of the Kalman filter
%
%[xhat_t_t,Pt_t,xhat_p,P_p,L,innovation]=Kalman_step(y,A,C,xhat_f,P_f,Q,R)
%
%input:
%y           - measurement of x(k)
%A,C         - Model parameters
%xhat_f      - updated estimation x(k-1|k-1)
%P_f         - updated covariance matrix P(k-1|k-1)
%Q,R         - Variance of the process and measurement noise
%
%output:
%xhat_t_t    - updated estimate x(k|k)
%Pt_t        - updated covariance matrix P(k|k)
%xhat_p      - predicted estimate x(k|k-1)
%Pt_p        - predicted covariance matrix P(k|k-1)
%innovation  - (y-C*xhat_p)
%




function [xhat_t_t,Pt_t,xhat_p,P_p,L,innovation]=Kalman_step(y,A,C,xhat_f,P_f,Q,R)

%% Kalman recursions --------------------------------------------------

% Predict states in x one time step forward using the previous x.
% xhat(t|t-1) = A*xhat(t-1|t-1)
xhat_p = A*xhat_f;          

% Calculate the covariance matrix of the prediction error.
% P(t|t-1) = A*P(t-1|t-1)*A'+Q
P_p = A*P_f*A'+Q;


% Calculate the Kalman gain
L = P_p*C'*inv(C*P_p*C'+R);   

innovation = (y-C*xhat_p); % The unpredicted part (innovation) of the measurement vector.

% Estimate states at time t by adding new information to the predicted values
% xhat(t|t) = xhat(t|t-1)+L*innovation
xhat_t_t = xhat_p+L*innovation;

% Calculate the covariance matrix for the estimation error in xhat(t|t)
Pt_t = (eye(size(xhat_t_t,1))-L*C)*P_p;
