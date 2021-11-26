----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------
ENTITY raqueta_fsm IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				cmd				:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				raq_y				:	OUT	STD_LOGIC_VECTOR(12 DOWNTO 0)
	);
END ENTITY raqueta_fsm;
----------------------------------------------------------------
ARCHITECTURE fsm OF raqueta_fsm IS
	TYPE state IS (start, move);
	SIGNAL pr_state, nx_state	:	state;
	SIGNAL rq_y				      : INTEGER RANGE 0 TO 1066 := 161;
	--SIGNAL prevy 					: INTEGER RANGE 0 TO 1066 := 0;
	
BEGIN 
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(RST, clk)
	BEGIN
			IF(rq_y < 956) THEN 
				rq_y <= rq_y + 1;
			END IF;
			raq_y <= STD_LOGIC_VECTOR(TO_UNSIGNED(rq_y,13));
		
	END PROCESS sequential;
	
END ARCHITECTURE fsm;