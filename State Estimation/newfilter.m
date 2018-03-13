function obj = newfilter(initialstate)

obj = extendedKalmanFilter(@StateTrans,@SensorMeas,initialstate);

end

