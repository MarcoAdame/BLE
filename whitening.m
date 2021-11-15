function PDU_CRC_white = whitening(PDU_CRC, Channel_Index)
%% Whitening
if (~exist('Channel_Index', 'var')) 
   Channel_Index = 39;
end

ci = Channel_Index;             % Conversion of Channel_Index to binary
rr = [0 0 0 0 0 0 1];           % Position 0 of LSB is always set to 1
i = 1;
while (ci >= 2)
	cit = floor(ci/2); 
	rr(i) = mod(ci,2);		% Channel Index in binary
	i = i + 1;
	ci = cit;
end
rr(i) = cit; 
% Interchange elements of rr and leave them in rr
for i = 1:floor(length(rr)/2)    % debe dar un entero la division
	temp = rr(i);
	rr(i) = rr(length(rr)+1-i);
	rr(length(rr)+1-i) = temp;
end

w = rr		% Initialization of shift register; position 1 is LSB position 24 is MSB
for i = 1: length(PDU_CRC)
	x7 = w(7);
	PDU_CRC_white(i) = xor(x7, PDU_CRC(i));
	w(7) = w(6);
	w(6) = w(5);
	w(5) = xor(w(4), x7);
	w(4) = w(3);
	w(3) = w(2);
	w(2) = w(1);
	w(1) = x7;
end

end % End function