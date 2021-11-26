LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE zero IS
	PROCEDURE n0(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;SIGNAL rgb:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL draw: OUT STD_LOGIC);
	END zero;

	PACKAGE BODY zero IS
		PROCEDURE n0(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;
						 SIGNAL rgb						 :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
						 SIGNAL draw					 : OUT STD_LOGIC) IS
	BEGIN 
		IF(Xcur>Xpos AND Xcur<(Xpos+4) AND Ycur>Ypos AND Ycur<(Ypos+40)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF ((Xcur>=(Xpos+4) AND Xcur<=(Xpos+16)) AND ((Ycur>Ypos AND Ycur<(Ypos+4)) OR (Ycur>(Ypos+36) AND Ycur<(Ypos+40)))) THEN 
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>(Xpos+16) AND Xcur<(Xpos+20) AND Ycur>Ypos AND Ycur<(Ypos+40)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSE 
			rgb <= "0000";
			draw <= '0';
		END IF;
	END n0;
END zero;