function state = StateTrans(prevState, A, B, inputs)
	state = A*prevState + B*inputs; % Multiplt A and B matrices appropriately
end