LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY FSM_pause IS
	PORT( clk 			: IN STD_LOGIC;
			rst			: IN STD_LOGIC;
			pau			: IN STD_LOGIC;
			pse			: OUT STD_LOGIC
	);
END ENTITY FSM_pause;

ARCHITECTURE fsm OF FSM_pause IS

	TYPE state IS (st0, st1, st2, st3);
	SIGNAL pr_state, nx_state	:	state;

BEGIN
		
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(rst, clk, pau)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	st0;
		ELSIF (rising_edge(clk)) THEN
				pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	combinational: PROCESS(clk, pr_state, pau)
	BEGIN
		CASE pr_state IS
			WHEN st0	=>
				IF (pau = '0') THEN
					pse <= '1';
					nx_state <= st1;
				ELSE
					pse <= '0';
					nx_state <= st0;
				END IF;
				
			WHEN st1	=>
					pse <= '1';
				IF (pau = '0') THEN
					nx_state <= st1;
				ELSE
					nx_state <= st2;
				END IF;

			WHEN st2	=>
					pse <= '1';
				IF (pau = '1') THEN
					nx_state <= st2;
				ELSE
					nx_state <= st3;
				END IF;

			WHEN st3	=>
					pse <= '1';
				IF (pau = '0') THEN
					nx_state <= st3;
				ELSE
					nx_state <= st0;
				END IF;
			
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;