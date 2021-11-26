LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.MY.ALL;
USE WORK.vertwall.ALL;
USE WORK.horwall.ALL;
USE WORK.raqueta.ALL;
USE WORK.zero.ALL;
USE WORK.one.ALL;
USE WORK.two.ALL;
USE WORK.three.ALL;
USE WORK.four.ALL;
USE WORK.five.ALL;
USE WORK.six.ALL;
USE WORK.seven.ALL;
USE WORK.eight.ALL;
USE WORK.nine.ALL;
USE WORK.malla.ALL;
 
ENTITY sync IS
	PORT( clk 			: IN STD_LOGIC;
			rst			: IN STD_LOGIC;
			str			: IN STD_LOGIC;
			pse 			: IN STD_LOGIC; 
			cmd			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			cmd1			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			rand			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			hsync 		: OUT STD_LOGIC;
			vsync 		: OUT STD_LOGIC;
			R				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			G				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			B 				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY sync;

ARCHITECTURE arch OF sync IS

	TYPE state IS (st0, wtst, st45, st135, st225, st315, st90l, st90r, stps);
	SIGNAL pr_state, nx_state	:	state;
	SIGNAL draw 					: STD_LOGIC;
	SIGNAL drawr 					: STD_LOGIC;
	SIGNAL rgb						: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rgbr						: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rgbn						: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rgb1,rgb2				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL draw1, draw2			: STD_LOGIC;
	SIGNAL x_vw1					: INTEGER RANGE 0 TO 799 := 0;
	SIGNAL y_vw1					: INTEGER RANGE 0 TO 525 := 40;
	SIGNAL x_vw2					: INTEGER RANGE 0 TO 799 := 636;
	SIGNAL y_vw2					: INTEGER RANGE 0 TO 525 := 40;
	SIGNAL rgb3,rgb4				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL draw3, draw4			: STD_LOGIC;
	SIGNAL x_hw1					: INTEGER RANGE 0 TO 799 := 0;
	SIGNAL y_hw1					: INTEGER RANGE 0 TO 525 := 40;
	SIGNAL x_hw2					: INTEGER RANGE 0 TO 799 := 0;
	SIGNAL y_hw2					: INTEGER RANGE 0 TO 525 := 474;
	SIGNAL hpos						: INTEGER RANGE 0 TO 799 := 0;
	SIGNAL vpos						: INTEGER RANGE 0 TO 525 := 0;
	SIGNAL rgb5, rgb6				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL draw5, draw6			: STD_LOGIC;
	SIGNAL x_rq1					: INTEGER RANGE 0 TO 799 := 4;
	SIGNAL y_rq1					: INTEGER RANGE 0 TO 525 := 209;
	SIGNAL x_rq2					: INTEGER RANGE 0 TO 799 := 628;
	SIGNAL y_rq2					: INTEGER RANGE 0 TO 525 := 209;
	SIGNAL rgbb						: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawb					: STD_LOGIC;
	SIGNAL x_bl						: INTEGER RANGE 0 TO 799 := 312;
	SIGNAL y_bl						: INTEGER RANGE 0 TO 525 := 249;
	SIGNAL rgb7						: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawm					: STD_LOGIC;
	SIGNAL x_m						: INTEGER RANGE 0 TO 799 := 315;
	SIGNAL y_m						: INTEGER RANGE 0 TO 525 := 44;
	SIGNAL endvg           		: STD_LOGIC;
	SIGNAL gena, rena, pena		: STD_LOGIC := '0';
	SIGNAL desp						: INTEGER RANGE 1 TO 20 := 5;
	SIGNAL times 					: INTEGER RANGE 0 TO 30 := 0;
	
	
	SIGNAL drawna, drawnb		: STD_LOGIC;
	SIGNAL rgbn0,rgbn1			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn0,drawn1			: STD_LOGIC;
	SIGNAL x_na						: INTEGER RANGE 0 TO 799 := 159;
	SIGNAL x_nb						: INTEGER RANGE 0 TO 799 := 477;
	SIGNAL y_n						: INTEGER RANGE 0 TO 525 := 0;
	SIGNAL x_na0					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_na1					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn2,rgbn3			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn2,drawn3			: STD_LOGIC;
	SIGNAL x_na2					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_na3					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn4,rgbn5			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn4,drawn5			: STD_LOGIC;
	SIGNAL x_na4					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_na5					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn6,rgbn7			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn6,drawn7			: STD_LOGIC;
	SIGNAL x_na6					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_na7					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn8,rgbn9			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn8,drawn9			: STD_LOGIC;
	SIGNAL x_na8					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_na9					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL pointsp1, pointsp2	: INTEGER RANGE 0 TO 9	 := 0; 
	
	SIGNAL rgbn10,rgbn11			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn10,drawn11		: STD_LOGIC;
	SIGNAL x_nb0					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_nb1					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn12,rgbn13			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn12,drawn13		: STD_LOGIC;
	SIGNAL x_nb2					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_nb3					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn14,rgbn15			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn14,drawn15			: STD_LOGIC;
	SIGNAL x_nb4					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_nb5					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn16,rgbn17			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn16,drawn17			: STD_LOGIC;
	SIGNAL x_nb6					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_nb7					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL rgbn18,rgbn19			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL drawn18,drawn19			: STD_LOGIC;
	SIGNAL x_nb8					: INTEGER RANGE 0 TO 799 := 655;
	SIGNAL x_nb9					: INTEGER RANGE 0 TO 799 := 655;
	

BEGIN

	--Posiciones De Los Margenes--
	x_vw1	<= 0;
	y_vw1	<= 40;
	x_vw2	<= 636;
	y_vw2	<= 40;
	x_hw1	<= 0;
	y_hw1	<= 40;
	x_hw2	<= 0;
	y_hw2	<= 474;
	--Posicion de la malla
	x_m	<= 316;
	y_m	<= 44;
	
	--Posiciones De los numeros--
	x_na	<= 159;
	x_nb 	<= 477;
	y_n	<= 0;
	
	---------------Figuras---------------
	vw(hpos,vpos,x_vw1,y_vw1,rgb1,draw1);
	vw(hpos,vpos,x_vw2,y_vw2,rgb2,draw2);
	hw(hpos,vpos,x_hw1,y_hw1,rgb3,draw3);
	hw(hpos,vpos,x_hw2,y_hw2,rgb4,draw4);
	rq(hpos,vpos,x_rq1,y_rq1,rgb5,draw5);
	rq(hpos,vpos,x_rq2,y_rq2,rgb6,draw6);
	sq(hpos,vpos,x_bl,y_bl,rgbb,drawb);
	ml(hpos,vpos,x_m,y_m,rgb7,drawm);	
	
	n0(hpos,vpos,x_na0,y_n,rgbn0,drawn0);
	n1(hpos,vpos,x_na1,y_n,rgbn1,drawn1);
	n2(hpos,vpos,x_na2,y_n,rgbn2,drawn2);
	n3(hpos,vpos,x_na3,y_n,rgbn3,drawn3);
	n4(hpos,vpos,x_na4,y_n,rgbn4,drawn4);
	n5(hpos,vpos,x_na5,y_n,rgbn5,drawn5);
	n6(hpos,vpos,x_na6,y_n,rgbn6,drawn6);
	n7(hpos,vpos,x_na7,y_n,rgbn7,drawn7);
	n8(hpos,vpos,x_na8,y_n,rgbn8,drawn8);
	n9(hpos,vpos,x_na9,y_n,rgbn9,drawn9);
	n0(hpos,vpos,x_nb0,y_n,rgbn10,drawn10);
	n1(hpos,vpos,x_nb1,y_n,rgbn11,drawn11);
	n2(hpos,vpos,x_nb2,y_n,rgbn12,drawn12);
	n3(hpos,vpos,x_nb3,y_n,rgbn13,drawn13);
	n4(hpos,vpos,x_nb4,y_n,rgbn14,drawn14);
	n5(hpos,vpos,x_nb5,y_n,rgbn15,drawn15);
	n6(hpos,vpos,x_nb6,y_n,rgbn16,drawn16);
	n7(hpos,vpos,x_nb7,y_n,rgbn17,drawn17);
	n8(hpos,vpos,x_nb8,y_n,rgbn18,drawn18);
	n9(hpos,vpos,x_nb9,y_n,rgbn19,drawn19);
	
	
	draw <= draw1 OR draw2 OR draw3 OR draw4 OR drawm;
	drawr <= draw5 OR draw6;
	drawna <= drawn0 OR drawn1 OR drawn2 OR drawn3 OR drawn4 OR drawn5 OR drawn6 OR drawn7 OR drawn8 OR drawn9;
	drawnb <= drawn10 OR drawn11 OR drawn12 OR drawn13 OR drawn14 OR drawn15 OR drawn16 OR drawn17 OR drawn18 OR drawn19;
	
	rgb <= rgb1 OR rgb2 OR rgb3 OR rgb4 OR rgb7;
	rgbr <= rgb5 OR rgb6;
		
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(rst, clk, str, pr_state, gena, rena)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	st0;
			rena <= '1';
		ELSIF (rising_edge(clk)) THEN
			rena <= '0';
			IF (pse = '1') THEN
				pena <= '1';
				pr_state <= stps;
			ELSE 
				pr_state	<=	nx_state;
				pena <= '0';
			END IF;
		END IF;
	END PROCESS sequential;
	
	control_vga: PROCESS(clk, cmd, str, pse, pr_state)
	BEGIN
		IF (rising_edge(clk)) THEN 
			IF (draw = '1' OR drawr = '1' OR drawna = '1' OR drawnb = '1' OR drawb = '1') THEN
				IF(drawr = '1') THEN
					R <= rgbr;
					G <= rgbr;
					B <= rgbr;
				ELSIF(drawna = '1' OR drawnb = '1') THEN
					IF (drawn0 = '1' AND pointsp1 = 0) THEN --imprime cero a la izquierda
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na0 <= x_na;
						R <= rgbn0;
						G <= rgbn0;
						B <= rgbn0;
					ELSIF (drawn1 = '1' AND pointsp1 = 1) THEN --imprime 1 a la izquierda
						x_na0	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na1 <= x_na;
						R <= rgbn1;
						G <= rgbn1;
						B <= rgbn1;
					ELSIF (drawn2 = '1' AND pointsp1 = 2) THEN --imprime 2 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na2 <= x_na;
						R <= rgbn2;
						G <= rgbn2;
						B <= rgbn2;
					ELSIF (drawn3 = '1' AND pointsp1 = 3) THEN --imprime 3 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na3 <= x_na;
						R <= rgbn3;
						G <= rgbn3;
						B <= rgbn3;
					ELSIF (drawn4 = '1' AND pointsp1 = 4) THEN --imprime 4 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na4 <= x_na;
						R <= rgbn4;
						G <= rgbn4;
						B <= rgbn4;
					ELSIF (drawn5 = '1' AND pointsp1 = 5) THEN --imprime 5 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na5 <= x_na;
						R <= rgbn5;
						G <= rgbn5;
						B <= rgbn5;
					ELSIF (drawn6 = '1' AND pointsp1 = 6) THEN --imprime 6 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na6 <= x_na;
						R <= rgbn6;
						G <= rgbn6;
						B <= rgbn6;
					ELSIF (drawn7 = '1' AND pointsp1 = 7) THEN--imprime 7 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na8	<= 655;
						x_na9	<= 655;
						x_na7 <= x_na;
						R <= rgbn7;
						G <= rgbn7;
						B <= rgbn7;
					ELSIF (drawn8 = '1' AND pointsp1 = 8) THEN --imprime 8 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na9	<= 655;
						x_na8 <= x_na;
						R <= rgbn8;
						G <= rgbn8;
						B <= rgbn8;
					ELSIF (drawn9 = '1' AND pointsp1 = 9) THEN --imprime 9 a la izquierda
						x_na0	<= 655;
						x_na1	<= 655;
						x_na2	<= 655;
						x_na3	<= 655;
						x_na4	<= 655;
						x_na5	<= 655;
						x_na6	<= 655;
						x_na7	<= 655;
						x_na8	<= 655;
						x_na9 <= x_na;
						R <= rgbn9;
						G <= rgbn9;
						B <= rgbn9;
					ELSIF (drawn10 = '1' AND pointsp2 = 0) THEN --imprime cero a la derecha
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb0 <= x_nb;
						R <= rgbn10;
						G <= rgbn10;
						B <= rgbn10;
					ELSIF (drawn11 = '1' AND pointsp2 = 1) THEN --imprime 1 a la derecha
						x_nb0	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb1 <= x_nb;
						R <= rgbn11;
						G <= rgbn11;
						B <= rgbn11;
					ELSIF (drawn12 = '1' AND pointsp2 = 2) THEN --imprime 2 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb2 <= x_nb;
						R <= rgbn12;
						G <= rgbn12;
						B <= rgbn12;
					ELSIF (drawn13 = '1' AND pointsp2 = 3) THEN --imprime 3 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb3 <= x_nb;
						R <= rgbn13;
						G <= rgbn13;
						B <= rgbn13;
					ELSIF (drawn14 = '1' AND pointsp2 = 4) THEN --imprime 4 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb4 <= x_nb;
						R <= rgbn14;
						G <= rgbn14;
						B <= rgbn14;
					ELSIF (drawn15 = '1' AND pointsp2 = 5) THEN --imprime 5 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb5 <= x_nb;
						R <= rgbn15;
						G <= rgbn15;
						B <= rgbn15;
					ELSIF (drawn16 = '1' AND pointsp2 = 6) THEN --imprime 6 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb6 <= x_nb;
						R <= rgbn16;
						G <= rgbn16;
						B <= rgbn16;
					ELSIF (drawn17 = '1' AND pointsp2 = 7) THEN --imprime 7 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb8	<= 655;
						x_nb9	<= 655;
						x_nb7 <= x_nb;
						R <= rgbn17;
						G <= rgbn17;
						B <= rgbn17;
					ELSIF (drawn18 = '1' AND pointsp2 = 8) THEN --imprime 8 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb9	<= 655;
						x_nb8 <= x_nb;
						R <= rgbn18;
						G <= rgbn18;
						B <= rgbn18;
					ELSIF (drawn19 = '1' AND pointsp2 = 9) THEN --imprime 9 a la derecha
						x_nb0	<= 655;
						x_nb1	<= 655;
						x_nb2	<= 655;
						x_nb3	<= 655;
						x_nb4	<= 655;
						x_nb5	<= 655;
						x_nb6	<= 655;
						x_nb7	<= 655;
						x_nb8	<= 655;
						x_nb9 <= x_nb;
						R <= rgbn19;
						G <= rgbn19;
						B <= rgbn19;
					END IF; 
				ELSIF (drawb = '1') THEN --imprime la bola
					R <= rgbb;
					G <= rgbb;
					B <= rgbb;
				ELSE 							 --imprime la malla
					R <= rgb;
					G <= NOT rgb;
					B <= NOT rgb;
				END IF;
			ELSE 
				R <= (OTHERS => '0');	--imprime el fondo
				G <= (OTHERS => '0');
				B <= (OTHERS => '0');
			END IF;	
			--Diagrama de tiempo para desplegar vga
			IF(hpos < 800) THEN
				hpos <= hpos+1;
			ELSE 
				hpos <= 0;
					IF(vpos < 525)THEN
						vpos <= vpos+1;
					ELSE
                  endvg <= '1';	
						vpos <= 0;
					END IF;
			END IF;
				
			IF (hpos < 665) THEN
				hsync <= '1';
			ELSIF (hpos >= 655 AND hpos < 751) THEN 
				hsync <= '0';
			ELSE 
				hsync <= '1';
			END IF;
				
			IF(vpos < 479)THEN
				vsync <= '1';
			ELSIF (vpos >= 479 AND vpos < 491) THEN
				vsync <= '0'; 
			ELSE 
				vsync <= '1';
			END IF;
			
			IF ((hpos>639 AND hpos<800) OR (vpos>479 AND vpos<525)) THEN
				R <=(OTHERS => '0');
				G <=(OTHERS => '0');
				B <=(OTHERS => '0');
			END IF;
			
		--Seccion de movimientos	
		--Movimiento Raqueta
			IF(endvg = '1') THEN
				IF (pena = '0') THEN 
					IF(cmd(0) = '0') THEN --Hacia arriba jugador 1
						IF (y_rq1 >= 49) THEN 
							y_rq1 <= y_rq1 - 5;
							endvg <= '0';
						END IF;
					END IF;
					
					IF(cmd1(0) = '0') THEN --Hacia arriba jugador 2
						IF (y_rq2 >= 49) THEN 
							y_rq2 <= y_rq2 - 5;
							endvg <= '0';
						END IF;
					END IF;
	
					IF(cmd1(1) = '0') THEN --Hacia abajo jugador 1 
						IF (y_rq2 < 370) THEN 
							y_rq2 <= y_rq2 + 5;
							endvg <= '0';
						END IF;
					END IF;
					
					IF(cmd(1) = '0') THEN --Hacia abajo jugador 2
						IF (y_rq1 < 370) THEN 
							y_rq1 <= y_rq1 + 5;
							endvg <= '0';
						END IF;
					END IF;
				END IF;
				--Ubicación inicial de la bola y las raquetas
				CASE pr_state IS
					WHEN st0	=>
						endvg <= '0';
						x_rq1	<= 4;
						y_rq1	<= 209;
						x_rq2	<= 628;
						y_rq2	<= 209;
						x_bl	<= 312;
						y_bl	<= 249;
						times <= 0;
						desp <= 2;
						
						IF (rena = '1') THEN
							gena <= '0';
							pointsp1 <= 0;
							pointsp2 <= 0;
							x_na0	<= 655;
							x_na1	<= 655;
							x_na2	<= 655;
							x_na3	<= 655;
							x_na4	<= 655;
							x_na5	<= 655;
							x_na6	<= 655;
							x_na7	<= 655;
							x_na8	<= 655;
							x_na9	<= 655;
							x_nb0	<= 655;
							x_nb1	<= 655;
							x_nb2	<= 655;
							x_nb3	<= 655;
							x_nb4	<= 655;
							x_nb5	<= 655;
							x_nb6	<= 655;
							x_nb7	<= 655;
							x_nb8	<= 655;
							x_nb9	<= 655;
						END IF;
						-- Decide la direccion de la bola
						IF (gena = '1') THEN	
							IF (rand = "101") THEN --a la derecha
								nx_state <= st90r;
							ELSIF (rand = "100") THEN --a 315 grados
								nx_state <= st315;
							ELSIF (rand = "011") THEN --a 225 grados
								nx_state <= st225;
							ELSIF (rand = "010") THEN --a la izquierda
								nx_state <= st90l;
							ELSIF (rand = "001") THEN --a 135 grados
								nx_state <= st135;
							ELSIF (rand = "000") THEN --a 45 grados
								nx_state <= st45;
								gena <= '0';
							END IF;
						ELSE 
							nx_state <= wtst;
							gena <= '0';
						END IF;
					-- Espera el start para comenzar	
					WHEN wtst =>	
						endvg <= '0';
						IF(str = '1') THEN
							gena <= '0';
							nx_state <= wtst;
						ELSE
							gena <= '1';
							nx_state <= st0;
						END IF;
						
					WHEN st45	=>
						endvg <= '0';
						gena <= '0';
						IF (y_bl > 44 AND x_bl < 618) THEN
							y_bl <= y_bl - desp;
							x_bl <= x_bl + desp;
						ELSIF (y_bl <= 44) THEN
							nx_state <= st315;
						ELSIF (x_bl >= 618) THEN
							IF (times < 10) THEN --Toca 10 veces las raquetas en velocidad minima
								desp <= 2;
							ELSIF (times < 20 AND times >= 10) THEN --Toca 10 veces las raquetas en velocidad media
								desp <= 5;
							ELSE 
								desp <=10; --Toca 10 veces las raquetas en velocidad maxima
							END IF;
							IF (times <= 30) THEN --Lleva el conteo de los toques de las raquetas
								times <= times + 1;
							END IF;	
							-- la bola adquiere una direccion segun la parte de la raqueta en la que golpee
							IF ((y_bl + 8) >= y_rq2 AND y_bl <= (y_rq2 + 34))THEN 
								nx_state <= st135;
							ELSIF ((y_bl + 5) >= (y_rq2 + 35) AND y_bl <= (y_rq2 + 61))THEN
								nx_state <= st90l;
							ELSIF ((y_bl + 5) >= (y_rq2 + 62) AND y_bl <= (y_rq2 + 98))THEN
								nx_state <= st225;
							ELSE 
							-- Marca punto si la bola no pega en la raqueta 1
								IF(pointsp1 < 9 ) THEN
									pointsp1 <= pointsp1 + 1;
								ELSE
								-- Reinicia el marcador cuando alguien llegue a 10 puntos
									pointsp1 <= 0;
									pointsp2 <= 0;
								END IF;
								nx_state <= st0;
							END IF;
						END IF;
						  
					WHEN st135	=>
						endvg <= '0';
						gena <= '0';
						IF (y_bl > 44 AND x_bl > 12) THEN
							y_bl <= y_bl - desp;
							x_bl <= x_bl - desp;
						ELSIF (x_bl <= 12) THEN
							IF (times < 10) THEN 
								desp <= 2;
							ELSIF (times < 20 AND times >= 10) THEN
								desp <= 5;
							ELSE 
								desp <= 10;
							END IF;
							IF (times <= 30) THEN 
								times <= times + 1;
							END IF;	 
							IF ((y_bl + 8) >= y_rq1 AND y_bl <= (y_rq1 + 34))THEN
								nx_state <= st45;
							ELSIF ((y_bl + 5) >= (y_rq1 + 35) AND y_bl <= (y_rq1 + 61))THEN
								nx_state <= st90r;
							ELSIF ((y_bl + 5) >= (y_rq1 + 62) AND y_bl <= (y_rq1 + 98))THEN
								nx_state <= st315;
							ELSE 
								IF(pointsp2 < 9 ) THEN
									pointsp2 <= pointsp2 + 1;
								ELSE
									pointsp2 <= 0;
									pointsp1 <= 0;
								END IF; 
								nx_state <= st0;
							END IF;
						ELSIF (y_bl <= 44) THEN
							nx_state <= st225;
						END IF;
					
					WHEN st225	=>
						endvg <= '0';
						gena <= '0';
						IF (y_bl < 464 AND x_bl > 12) THEN
							y_bl <= y_bl + desp;
							x_bl <= x_bl - desp;
						ELSIF (y_bl >= 464) THEN
							nx_state <= st135;
						ELSIF (x_bl <= 12) THEN
							IF (times < 10) THEN 
								desp <= 2;
							ELSIF (times < 20 AND times >= 10) THEN
								desp <= 5;
							ELSE 
								desp <= 10;
							END IF;
							IF (times <= 30) THEN 
								times <= times + 1;
							END IF;	
							IF ((y_bl + 8) >= y_rq1 AND y_bl <= (y_rq1 + 34))THEN
								nx_state <= st45;
							ELSIF ((y_bl + 5) >= (y_rq1 + 35) AND y_bl <= (y_rq1 + 61))THEN
								nx_state <= st90r;
							ELSIF ((y_bl + 5) >= (y_rq1 + 62) AND y_bl <= (y_rq1 + 98))THEN
								nx_state <= st315;
							ELSE 
								IF(pointsp2 < 9 ) THEN
									pointsp2 <= pointsp2 + 1;
								ELSE
									pointsp2 <= 0;
									pointsp1 <= 0;
								END IF; 
								nx_state <= st0;
							END IF;
						END IF;
						
					WHEN st315	=>
						endvg <= '0';
						gena <= '0';
						IF (y_bl < 464 AND x_bl < 618) THEN
							y_bl <= y_bl + desp;
							x_bl <= x_bl + desp;
						ELSIF (x_bl >= 618) THEN
							IF (times < 10) THEN 
								desp <= 2;
							ELSIF (times < 20 AND times >= 10) THEN
								desp <= 5;
							ELSE 
								desp <= 10;
							END IF;
							IF (times <= 30) THEN 
								times <= times + 1;
							END IF;	 
							IF ((y_bl + 8) >= y_rq2 AND y_bl <= (y_rq2 + 34))THEN
								nx_state <= st135;
							ELSIF ((y_bl + 5) >= (y_rq2 + 35) AND y_bl <= (y_rq2 + 61))THEN
								nx_state <= st90l;
							ELSIF ((y_bl + 5) >= (y_rq2 + 62) AND y_bl <= (y_rq2 + 98))THEN
								nx_state <= st225;
							ELSE 
								IF(pointsp1 < 9 ) THEN
									pointsp1 <= pointsp1 + 1;
								ELSE
									pointsp1 <= 0;
									pointsp2 <= 0;
								END IF;
								nx_state <= st0;
							END IF;
						ELSIF (y_bl >= 464) THEN
							nx_state <= st45;
						END IF;
						
					WHEN st90l	=>
						endvg <= '0';
						gena <= '0';
						IF (x_bl > 12) THEN
							x_bl <= x_bl - desp;
						ELSE
							IF (times < 10) THEN 
								desp <= 2;
							ELSIF (times < 20 AND times >= 10) THEN
								desp <= 5;
							ELSE 
								desp <= 10;
							END IF;
							IF (times <= 30) THEN 
								times <= times + 1;
							END IF;	
							IF ((y_bl + 8) >= y_rq1 AND y_bl <= (y_rq1 + 34))THEN
								nx_state <= st45;
							ELSIF ((y_bl + 5) >= (y_rq1 + 35) AND y_bl <= (y_rq1 + 61))THEN
								nx_state <= st90r;
							ELSIF ((y_bl + 5) >= (y_rq1 + 62) AND y_bl <= (y_rq1 + 98))THEN
								nx_state <= st315;
							ELSE 
								IF(pointsp2 < 9 ) THEN
									pointsp2 <= pointsp2 + 1;
								ELSE
									pointsp2 <= 0;
									pointsp1 <= 0;
								END IF; 
								nx_state <= st0;
							END IF;
						END IF;
					
					WHEN st90r	=>
						endvg <= '0';
						gena <= '0';
						IF (x_bl < 618) THEN
							x_bl <= x_bl + desp;
						ELSE
							IF (times < 10) THEN 
								desp <= 2;
							ELSIF (times < 20 AND times >= 10) THEN
								desp <= 5;
							ELSE 
								desp <= 10;
							END IF;
							IF (times <= 30) THEN 
								times <= times + 1;
							END IF; 
							IF ((y_bl + 8) >= y_rq2 AND y_bl <= (y_rq2 + 34))THEN
								nx_state <= st135;
							ELSIF ((y_bl + 5) >= (y_rq2 + 35) AND y_bl <= (y_rq2 + 61))THEN
								nx_state <= st90l;
							ELSIF ((y_bl + 5) >= (y_rq2 + 62) AND y_bl <= (y_rq2 + 98))THEN
								nx_state <= st225;
							ELSE 
								IF(pointsp1 < 9 ) THEN
									pointsp1 <= pointsp1 + 1;
								ELSE
									pointsp1 <= 0;
									pointsp2 <= 0;
								END IF; 
								nx_state <= st0;
							END IF;
						END IF;
						 
					WHEN stps =>	
						endvg <= '0';
						
				END CASE;
			END IF;

		END IF;
	END PROCESS;
END ARCHITECTURE;