%%Kalman_first - The first iteration of the Kalman filter
%
%[xhat_t_t,Pt_t,L,innovation] = Kalman_first(y,C,xhat_p,P_p,R)
%
%input:
%y           - measurement of x(1)
%C           - model parameter
%xhat_p      - initial estimate x(0),
%P_p         - initial predicted covariance matrix 
%R           - Variance of the process noise
%
%output:
%xhat_t_t    - udated estimate x(1|1)
%Pt_t        - updated covariance matrix P(1|1)
%innovation  - (y-C*xhat_p)
%


function [xhat_t_t,Pt_t,L,innovation] = Kalman_first(y,C,xhat_p,P_p,R)

%% Kalman recursions --------------------------------------------------

% Calculate the Kalman gain
L = P_p*C'*inv(C*P_p*C'+R); 

innovation = (y-C*xhat_p);

% Estimate states at time t by adding new information to the predicted values
% xhat(t|t) = xhat(t|t-1)+L*innovation
xhat_t_t = xhat_p+L*innovation;     

% Calculate the covariance matrix for the estimation error in xhat(t|t)
Pt_t = (eye(size(xhat_t_t,1))-L*C)*P_p; 

