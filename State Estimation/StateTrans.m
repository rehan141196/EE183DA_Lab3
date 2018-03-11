function state = StateTrans(prevState, A, B, inputs)
	state = A*prevState + B*inputs;
end