% Generate CRC, calculated over the Advertising Channel PDU (PDU)
function sr = CRC(PDU)
sr = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];	% Initialization of shift register; position 1 is LSB, position 24 is MSB
for i = 1: length(PDU)
	x24 = xor(sr(24), PDU(i));
	for j = 24:-1:12
		sr(j) = sr(j-1);
	end
	sr(11) = xor(sr(10), x24);
	sr(10) = xor(sr(9), x24);
	sr(9) = sr(8);
	sr(8) = sr(7);
	sr(7) = xor(sr(6), x24);
	sr(6) = sr(5);
	sr(5) = xor(sr(4), x24);
	sr(4) = xor(sr(3), x24);
	sr(3) = sr(2);
	sr(2) = xor(sr(1), x24);
	sr(1) = x24;
end