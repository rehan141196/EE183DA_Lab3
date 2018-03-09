dt = 0.0001;
wheeldist = 0.084;

A = zeros(6);
A(1,1) = 1;
A(1,4) = dt;
A(2,2) = 1;
A(2,5) = dt;
A(3,3) = 1;
A(3,6) = dt;

B = zeros(6,2);
B(4,1) = 0.5*cos(theta);
B(4,2) = 0.5*cos(theta);
B(5,1) = 0.5*cos(theta);
B(5,2) = 0.5*sin(theta);
B(6,1) = -1/wheeldist;
B(6,2) = -1/wheeldist;


for n=1:100
	
end



function state = StateTrans(prevState, B, inputs)
	state = A*prevState + B*inputs;
end