# EE183DA Lab3 and Lab 4

This lab aims to perform state estimation and motion planning on a two wheeled car with a dragging tail.

The first step is to upload the files in the data folder and the paperbot.ino sketch onto the Arduino. This sketch provides a web interface to interact with the Arduino. It also reads data values from the IMU sensor and the LIDARs and prints them to the Serial. After uploading the sketch the user should connect to the Arduino via WiFi and open the IP address listed in the sketch on a browser. This works as the interface to pass commands to the vehicle.

The next step is to run the MAIN.py file in the Main Driver Code folder. This program reads data from the Serial thus reading sensor values as well as user inputs. The sensor readings and inputs are then passed to a MATLAB script implemented in the State Estimation folder. The MATLAB script maintains an Extended Kalman Filter object. This object takes a state transition function and a measurement function as inputs. The state transition function utilizes the user inputs to determine the expected position of the vehicle. The measurement function uses a sensor model to provide the expected sensor measurements given the location and orientation of the vehicle. The Extended Kalman Filter updates the filter with actual sensor measurements on each iteration and tracks the corrected state output thus completing the state estimation part of the lab.

For the motion planning part, a button called RRT is provided on the web interface. When the user clicks the RRT button, the MAIN.py script recognizes this input and then invokes the rrt.py script provided in the same folder. The rrt.py script opens an image of the box given in box.jpg. This box is treated as the environment the robot is in, where the whitespace is the place the robot can move around in and the black figures represent obstacles. The user is then prompted to select a starting point for the robot by clicking on the image. After that the user is prompted to click on another point on the image which is the goal that the robot wants to get to. The program then takes these two points and runs an RRT algorithm to compute a trajectory from the start to the goal (if one exists). The trajectory computed is shown on the figure as well as returned to the MAIN.py script and printed to the output console. The parameters for the RRT function can also be specified to change the amount of time one is willing to wait to check whether a route exists.

References:
Skeleton Code - https://git.uclalemur.com/mehtank/paperbot/

RRT - https://github.com/ArianJM/rapidly-exploring-random-trees
