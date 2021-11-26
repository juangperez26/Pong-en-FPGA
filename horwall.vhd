LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE horwall IS
	PROCEDURE hw(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;SIGNAL rgb:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL draw: OUT STD_LOGIC);
	END horwall;

	PACKAGE BODY horwall IS
		PROCEDURE hw(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;
						 SIGNAL rgb						 :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
						 SIGNAL draw					 : OUT STD_LOGIC) IS
	BEGIN 
		IF(Xcur>Xpos AND Xcur<(Xpos+639) AND Ycur>Ypos AND Ycur<(Ypos+4)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSE 
			rgb <= "0000";
			draw <= '0';
		END IF;
	END hw;
END horwall;