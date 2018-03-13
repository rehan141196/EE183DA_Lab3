x = input('Enter initial x: ');
y = input('Enter initial y: ');
theta = input('Enter initial theta: ');
xdot = input('Enter initial xdot: ');
ydot = input('Enter initial ydot: ');
thetadot = input('Enter initial thetadot: ');

initialstate = [x; y; theta; xdot; ydot; thetadot];

lidar1 = input('Enter Front LIDAR measurement: ');
lidar2 = input('Enter Right LIDAR measurement: ');
imu = input('Enter IMU measurement: ');

sensors = [lidar1; lidar2; imu];

pwm1 = input('Enter PWM Input to Right wheel: ');
pwm2 = input('Enter PWM Input to Left wheel: ');
inputs = [pwm1; pwm2];

order = input('Type 1 to do predict and then correct or 0 to do correct and then predict: ');
dt = 1; % Time step
wheeldist = 0.084; % Distance between wheels
% Box dimensions
x_max = 26;
y_max = 21;

A = zeros(6);
A(1,1) = 1;
A(1,4) = dt;
A(2,2) = 1;
A(2,5) = dt;
A(3,3) = 1;
A(3,6) = dt;

theta = sensors(3,1);
B = zeros(6,2);
B(4,1) = 0.5*cos(theta);
B(4,2) = 0.5*cos(theta);
B(5,1) = 0.5*cos(theta);
B(5,2) = 0.5*sin(theta);
B(6,1) = -1/wheeldist;
B(6,2) = -1/wheeldist;

obj = extendedKalmanFilter(@StateTrans,@SensorMeas,initialstate);

if(order == 1)
[PredictedState,PredictedStateCovariance] = predict(obj, A, B, inputs);
[CorrectedState,CorrectedStateCovariance] = correct(obj, sensors, x_max, y_max); % Update EKF    
end
if (order == 0)
[CorrectedState,CorrectedStateCovariance] = correct(obj, sensors, x_max, y_max); % Update EKF
[PredictedState,PredictedStateCovariance] = predict(obj, A, B, inputs);        
end

fprintf('The Corrected State is: \n');
disp(CorrectedState);
fprintf('The Corrected State Caovariance Matrix is: \n');
disp(CorrectedStateCovariance);
fprintf('The Predicted State is: \n');
disp(PredictedState);
fprintf('The Predicted State Covariance Matrix is: \n');
disp(PredictedStateCovariance);