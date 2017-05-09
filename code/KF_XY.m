function[Sx_est,vx_est]=KF_XY(Sx,vx,ax,dt,origin_initialized)
%Sx =xgps
%vx= ygps
%ax= R
%Sx_est=x
%vx_est=y

% n=length(acc); %number of samples
global theta
persistent KF_initialized xhat Pt 

if isempty(KF_initialized)
    KF_initialized = 0;
end

if isempty(xhat)
    %xhat = [Sx;vx];  % Initial guess on states xhat(1|0)
    xhat = [0;0];
end

if isempty(Pt)
    Pt = 100*eye(2);    % Initial uncertainty P(1|0)
end

% Model 
    A = [1  0;
         0   1];

%     C = [0 0;
%         0 0];
    
     C = [1 0;
         0 1];
    
    u = [ax];
    
    B = [-cos(theta);
        sin(theta)];

    Q = diag([1 1]);    % Variance for process noise
    
%     if GPS_status(GPSCOUNTER+1)==1 
%         R = diag([100 100]);        % Variance measurement noise
%     else
%          R = diag([10000 10000]);
%     end
   R = diag([100 100]); 
% initial step
if origin_initialized && ~KF_initialized
    [xhat,Pt,~,~] = Kalman_first([Sx;vx],C,xhat,Pt,R);
    KF_initialized = 1;
    Sx_est = xhat(1);
    vx_est = xhat(2);
    %ax_est = xhat(3);
    
% rest of the steps
elseif origin_initialized && KF_initialized
    [xhat,Pt,xhat_p,P_p,~,~] = Kalman_step_XY([Sx;vx],A,B,C,xhat,u,Pt,Q,R);
    %disp(B*u)
    Sx_est = xhat(1);
    vx_est = xhat(2);
    %ax_est = xhat(3);
    
else % pass raw data if origin not initialized
    Sx_est = Sx;
    vx_est = vx;
    %ax_est = ax;
end