import serial
import re
import matlab.engine
import rrt

eng = matlab.engine.start_matlab() # Start MATLAB engine

sensors = []
inputs = []
initialstate = [0, 0, 0, 0, 0, 0]

ExtendedKF = eng.newfilter(initialstate) # Create Extended Kalman Filter in MATLAB. This function must be in the same directory as the Python script

ser = serial.Serial(port='COM3', timeout=None, baudrate=115200) # Setup serial to begin reading

while True:
	line = ser.readline() # Read from Serial
	if 'Lidar 1 range(mm):' in line:
		sensornumbers = [int(s) for s in line.split() if s.isdigit()]
		sensors = [sensornumbers[1], sensornumbers[3]] # Extract the sensor measurements from the data written to Serial
		inputs = [0, 0]
		continue
	elif 'Heading' in line:
		magnumbers = re.findall("\d+\.\d+", line) # Extract the heading
		magreading = float(magnumbers[0])
		sensors.append(magreading)
		print(sensors)

		# Extract any input	
	elif '#FD' in line:
		print('Received Forward Input')
		inputs = [1, -1]
	elif '#RT' in line:
		print('Received Right Input')
		inputs = [1, 0]
	elif '#LT' in line:
		print('Received Left Input')
		inputs = [0, -1]
	elif '#BK' in line:
		print('Received Back Input')
		inputs = [-1 , 1]

		# Extract RRT button information if pressed
	elif '#RRT' in line:
		print('Executing RRT')
		path = rrt.main() # Call the RRT function
		print("After resizing, the following path can be used to get from the start to the goal: ", path) # Print the trajectory
		continue
	
	ExtendedKF = eng.EKF(ExtendedKF, sensors, inputs) # Update the Extended Kalman Filter by calling a MATLAB script 


