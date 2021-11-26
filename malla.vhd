LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE malla IS
	PROCEDURE ml(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;SIGNAL rgb:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL draw: OUT STD_LOGIC);
	END malla;

	PACKAGE BODY malla IS
		PROCEDURE ml(SIGNAL Xcur,Ycur,Xpos,Ypos :IN INTEGER;
						 SIGNAL rgb						 :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
						 SIGNAL draw					 : OUT STD_LOGIC) IS
	BEGIN 
		IF(Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>Ypos AND Ycur<(Ypos+10)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+20) AND Ycur<(Ypos+30)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+40) AND Ycur<(Ypos+50)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+60) AND Ycur<(Ypos+70)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+80) AND Ycur<(Ypos+90)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+100) AND Ycur<(Ypos+110)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+120) AND Ycur<(Ypos+130)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+140) AND Ycur<(Ypos+150)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+160) AND Ycur<(Ypos+170)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+180) AND Ycur<(Ypos+190)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+200) AND Ycur<(Ypos+210)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+220) AND Ycur<(Ypos+230)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+240) AND Ycur<(Ypos+250)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+260) AND Ycur<(Ypos+270)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+280) AND Ycur<(Ypos+290)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+300) AND Ycur<(Ypos+310)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+320) AND Ycur<(Ypos+330)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+340) AND Ycur<(Ypos+350)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+360) AND Ycur<(Ypos+370)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+380) AND Ycur<(Ypos+390)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+400) AND Ycur<(Ypos+410)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+420) AND Ycur<(Ypos+430)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+440) AND Ycur<(Ypos+450)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSIF (Xcur>Xpos AND Xcur<(Xpos+2) AND Ycur>(Ypos+460) AND Ycur<(Ypos+470)) THEN
			rgb <= "1111";
			draw <= '1';
		ELSE 
			rgb <= "0000";
			draw <= '0';
		END IF;
	END ml;
END malla;