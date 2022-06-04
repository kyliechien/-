Library IEEE;
USE ieee.std_logic_1164.all;

Entity LEDdotmatrix is
	port(
		CLK:in std_logic;
		RESET:in std_logic;
		FRAME_NUMBER:in integer range 0 to 7;
		
	);
end Entity;

Architecture ar of LEDdotmatrix is
	Type ROM_table8x8 is array (0 to 7) of std_logic_vector(0 to 7);
	Constant FRAME_0 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("00000000"),
														("00000000"),
														("00000000"),
														("00000000"),
														("00000000"));
	
	Constant FRAME_T0 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("10000000"),
														("00000000"),
														("00000000"),
														("00000000"),
														("00000000"));
														
	Constant FRAME_T1 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("10000000"),
														("01000000"),
														("01000000"),
														("00000000"),
														("00000000"));
														
	Constant FRAME_T2 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("10000000"),
														("01000000"),
														("01100000"),
														("00100000"),
														("00100000"));
														
	Constant FRAME_T3 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("10000000"),
														("01000000"),
														("01110000"),
														("00110000"),
														("00110000"));
														
	Constant FRAME_T4 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("10000000"),
														("01001000"),
														("01111000"),
														("00111000"),
														("00110000"));
														
	Constant FRAME_T5 : ROM_table8x8 := (	("00000000"),
														("00000000"),
														("00000000"),
														("10000100"),
														("01001100"),
														("01111100"),
														("00111000"),
														("00110000"));
														
	Constant FRAME_T6 : ROM_table8x8 := (	("00000000"),
														("00000010"),
														("00000010"),
														("10000100"),
														("01001100"),
														("01111100"),
														("00111000"),
														("00110000"));
	
	Constant FRAME_T7 : ROM_table8x8 := (	("00000001"),
														("00000010"),
														("00000010"),
														("10000100"),
														("01001100"),
														("01111100"),
														("00111000"),
														("00110000"));
	
	singal rowRoter : std_logic_vector(0 to 7) :="00000000";
	signal rowCounter : integer range 0 to 7 :=0;
	signal frame : ROM_table8x8;
	
	begin
		with FRAME_NUMBER select
			frame <=	FRAMET0 when 0,
						FRAMET1 when 1,
						FRAMET2 when 2,
						FRAMET3 when 3,
						FRAMET4 when 4,
						FRAMET5 when 5,
						FRAMET6 when 6,
						FRAMET7 when 7,
						FRAME0 when others;
	process (CLK, RESET) is
		begin
			if(RESET = '1')then
			rowCounter <= 0;
			rowRoter <= "";
			elsif(rising_edge(CLK)) then
				c <= not frame(rowCounter);
				R <= rowRoter;
				rowRoter <= rowRoter(7) & rowRoter(0 to 6);
				rowCounter <= rowCounter + 1;
			end if;
	end process;
	
end Architecture;