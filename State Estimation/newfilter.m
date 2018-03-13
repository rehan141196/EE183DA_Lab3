function obj = newfilter(initialstate)

obj = extendedKalmanFilter(@StateTrans,@SensorMeas,initialstate); % Create new Extended Kalman Filter object

end

