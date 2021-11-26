----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY vendingController IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				five_in			:	IN		STD_LOGIC;
				ten_in			:	IN		STD_LOGIC;
				twentyfive_in	:	IN		STD_LOGIC;
				candy_out		:	OUT	STD_LOGIC;
				five_out			:	OUT	STD_LOGIC;
				ten_out			:	OUT	STD_LOGIC
	);
END ENTITY vendingController;
----------------------------------------------------------------
ARCHITECTURE fsm OF vendingController IS
	TYPE state IS (st0, st5, st10, st15, st20, st25, st30, st35, st40, st45);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(RST, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	st0;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(pr_state, five_in, ten_in, twentyfive_in)
	BEGIN
		CASE pr_state IS
			WHEN st0	=>
				candy_out	<=	'0';
				five_out		<=	'0';
				ten_out		<=	'0';
				IF (five_in = '1') THEN
					nx_state	<= st5;
				ELSIF (ten_in = '1') THEN
					nx_state	<= st10;
				ELSIF (twentyfive_in = '1') THEN
					nx_state	<= st25;
				ELSE
					nx_state	<= st0;
				END IF;
			WHEN st5	=>
				candy_out	<=	'0';
				five_out		<=	'0';
				ten_out		<=	'0';
				IF (five_in = '1') THEN
					nx_state	<= st10;
				ELSIF (ten_in = '1') THEN
					nx_state	<= st15;
				ELSIF (twentyfive_in = '1') THEN
					nx_state	<= st30;
				ELSE
					nx_state	<= st5;
				END IF;
			WHEN st10	=>
				candy_out	<=	'0';
				five_out		<=	'0';
				ten_out		<=	'0';
				IF (five_in = '1') THEN
					nx_state	<= st15;
				ELSIF (ten_in = '1') THEN
					nx_state	<= st20;
				ELSIF (twentyfive_in = '1') THEN
					nx_state	<= st35;
				ELSE
					nx_state	<= st10;
				END IF;
			WHEN st15	=>
				candy_out	<=	'0';
				five_out		<=	'0';
				ten_out		<=	'0';
				IF (five_in = '1') THEN
					nx_state	<= st20;
				ELSIF (ten_in = '1') THEN
					nx_state	<= st25;
				ELSIF (twentyfive_in = '1') THEN
					nx_state	<= st40;
				ELSE
					nx_state	<= st15;
				END IF;
			WHEN st20	=>
				candy_out	<=	'0';
				five_out		<=	'0';
				ten_out		<=	'0';
				IF (five_in = '1') THEN
					nx_state	<= st25;
				ELSIF (ten_in = '1') THEN
					nx_state	<= st40;
				ELSIF (twentyfive_in = '1') THEN
					nx_state	<= st45;
				ELSE
					nx_state	<= st20;
				END IF;
			WHEN st25	=>
				candy_out	<=	'1';
				five_out		<=	'0';
				ten_out		<=	'0';
				nx_state		<= st0;
			WHEN st30	=>
				candy_out	<=	'1';
				five_out		<=	'1';
				ten_out		<=	'0';
				nx_state		<= st0;
			WHEN st35	=>
				candy_out	<=	'1';
				five_out		<=	'0';
				ten_out		<=	'1';
				nx_state		<= st0;
			WHEN st40	=>
				candy_out	<=	'0';
				five_out		<=	'1';
				ten_out		<=	'0';
				nx_state		<= st35;
			WHEN st45	=>
				candy_out	<=	'0';
				five_out		<=	'0';
				ten_out		<=	'1';
				nx_state		<= st35;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;