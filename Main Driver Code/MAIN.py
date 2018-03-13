import serial
import re
import matlab.engine
import rrt

eng = matlab.engine.start_matlab()

sensors = []
inputs = []
initialstate = [0, 0, 0, 0, 0, 0]

ExtendedKF = eng.newfilter(initialstate)

ser = serial.Serial(port='COM3', timeout=None, baudrate=115200)

while True:
	line = ser.readline()
	if 'Lidar 1 range(mm):' in line:
		sensornumbers = [int(s) for s in line.split() if s.isdigit()]
		sensors = [sensornumbers[1], sensornumbers[3]]
		inputs = [0, 0]
		continue
	elif 'Heading' in line:
		magnumbers = re.findall("\d+\.\d+", line)
		magreading = float(magnumbers[0])
		sensors.append(magreading)
		print(sensors)
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
	elif '#RRT' in line:
		print('Executing RRT')
		path = rrt.main()
		print("After resizing, the following path can be used to get from the start to the goal: ", path)
		continue
	
	ExtendedKF = eng.EKF(ExtendedKF, sensors, inputs)


