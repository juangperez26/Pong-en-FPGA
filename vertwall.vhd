LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE vertwall IS
	PROCEDURE vw(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;SIGNAL rgb:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL draw: OUT STD_LOGIC);
	END vertwall;

	PACKAGE BODY vertwall IS
		PROCEDURE vw(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;
						 SIGNAL rgb						 :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
						 SIGNAL draw					 : OUT STD_LOGIC) IS
	BEGIN 
		IF(Xcur>Xpos AND Xcur<(Xpos+4) AND Ycur>Ypos AND Ycur<(Ypos+439)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSE 
			rgb <= "0000";
			draw <= '0';
		END IF;
	END vw;
END vertwall;