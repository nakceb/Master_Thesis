function[Sx_est,vx_est,ax_est]=KF_SVA(Sx,vx,ax,dt,origin_initialized)
%Sx =theta
%vx= theta_dot
%ax= theta_dot_dot
% n=length(acc); %number of samples
global GPS_ready
persistent KF_initialized xhat Pt

if isempty(KF_initialized)
    KF_initialized = 0;
end

if isempty(xhat)
    xhat = [Sx;vx];  % Initial guess on states xhat(1|0)
end

if isempty(Pt)
    Pt = 100*eye(2);    % Initial uncertainty P(1|0)
end

% Model 
    A = [1  dt;
         0  1];
if GPS_ready == 1
    C = [1 0;
        0 1/(pi);
        0 1];
else 
    Sx=0;
        C = [0 0;
         0 1/(pi);
        0 1];
end;
    Q = diag([1 1]);    % Variance for process noise
    R = diag([10 1000 1]);        % Variance measurement noise

% initial step
if origin_initialized && ~KF_initialized
    [xhat,Pt,~,~] = Kalman_first([Sx;vx;ax],C,xhat,Pt,R);
    KF_initialized = 1;
    Sx_est = xhat(1);
    vx_est = xhat(2);
    %ax_est = xhat(3);
    
% rest of the steps
elseif origin_initialized && KF_initialized
    [xhat,Pt,xhat_p,P_p,~,~] = Kalman_step([Sx;vx;ax],A,C,xhat,Pt,Q,R); 
    Sx_est = xhat(1);
    vx_est = xhat(2);
    %ax_est = xhat(3);
    
else % pass raw data if origin not initialized
    Sx_est = Sx;
    vx_est = vx;
    %ax_est = ax;
end