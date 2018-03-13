function out = EKF(obj, sensors, inputs)

dt = 1;
wheeldist = 0.084;
x_max = 10;
y_max = 5;

A = zeros(6);
A(1,1) = 1;
A(1,4) = dt;
A(2,2) = 1;
A(2,5) = dt;
A(3,3) = 1;
A(3,6) = dt;

theta = 0;
B = zeros(6,2);
B(4,1) = 0.5*cos(theta);
B(4,2) = 0.5*cos(theta);
B(5,1) = 0.5*cos(theta);
B(5,2) = 0.5*sin(theta);
B(6,1) = -1/wheeldist;
B(6,2) = -1/wheeldist;

[CorrectedState,CorrectedStateCovariance] = correct(obj, sensors, x_max, y_max);
[PredictedState,PredictedStateCovariance] = predict(obj, A, B, inputs);
out = obj;