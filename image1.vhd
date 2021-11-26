LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY image1 IS 
	PORT ( clk		 		: IN STD_LOGIC;
			 reset			: IN STD_LOGIC := '0';
			 start1 			: IN STD_LOGIC := '1';
			 start2 			: IN STD_LOGIC := '1';
			 pause1			: IN STD_LOGIC := '1';
			 pause2			: IN STD_LOGIC := '1';
			 key1 			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);-- 0 hacia arriba 
			 key2 			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);-- 1 hacia abajo 
			 vga_hs			: OUT STD_LOGIC;
			 vga_vs 			: OUT STD_LOGIC;
			 vga_r			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			 vga_g			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			 vga_b 			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY image1;

ARCHITECTURE arch OF image1 IS

	SIGNAL 	vga_clk		: STD_LOGIC := '0';
	SIGNAL 	pausa			: STD_LOGIC;
   SIGNAL 	pause			: STD_LOGIC;
	SIGNAL 	start			: STD_LOGIC;
	SIGNAL  	rand			: STD_LOGIC_VECTOR(2 DOWNTO 0);
	

	
BEGIN

	pause <= pause1 OR pause2;
	start <= start1 AND start2;	

	pll_module: ENTITY work.PLL 
	PORT MAP(	inclk0 => clk,
					c0		 => vga_clk);
	
	vga: ENTITY work.sync 
	PORT MAP(	clk	=> vga_clk,
					rst	=> reset,
					str	=> start,
					pse 	=> pausa,
					cmd   => key1,
					cmd1	=>	key2,
					rand  => rand, 
					HSYNC => vga_hs,
					VSYNC => vga_vs,
					R		=> vga_r,
					G		=> vga_g,
					B 		=> vga_b);
					
	pse_block: ENTITY work.FSM_pause 
	PORT MAP(	clk	=> vga_clk,
					rst	=> reset,
					pau	=> pause,
					pse 	=> pausa);
	
	random_timer: entity work.BinUnivCont
	GENERIC MAP(	N			 => 3,
						MAX_COUNT => 5)
		PORT MAP(	clk		=> clk,
						rst		=> reset,
						ena		=> start,
						syn_clr	=> '0',
						load		=> '0',
						up			=> '1',
						d			=> "000",
						counter	=> rand);

END ARCHITECTURE;