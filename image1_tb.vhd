LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY image1_tb IS 
END ENTITY image1_tb;

ARCHITECTURE testbench OF image1_tb IS 
 
	SIGNAL clk_24_tb     : STD_LOGIC_VECTOR(1 DOWNTO 0):= (OTHERS => '1'); 
	SIGNAL reset_tb      : STD_LOGIC := '1';
	SIGNAL start_tb 	  	: STD_LOGIC := '0';
	SIGNAL pause_tb  	  	: STD_LOGIC := '1';
	SIGNAL key1_tb     	: STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '1');
	SIGNAL vga_hs_tb		: STD_LOGIC;
	SIGNAL vga_vs_tb 		: STD_LOGIC;
	SIGNAL vga_r_tb		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vga_g_tb		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL vga_b_tb		: STD_LOGIC_VECTOR(3 DOWNTO 0);
 
BEGIN
	clk_24_tb <= NOT clk_24_tb after 10ns;
	
	reset_tb   <= '0' after 50ns;

	start_tb   <= '1' after 80ns;


	DUT: ENTITY work.image1
	PORT MAP( clk_24		=> clk_24_tb,
				reset		=> reset_tb,
				start		=> start_tb,
				pause		=> pause_tb,
				key1		=> key1_tb,
				vga_hs	=> vga_hs_tb,
				vga_vs	=> vga_vs_tb,
				vga_r		=> vga_r_tb,
				vga_g 	=> vga_g_tb,
				vga_b		=> vga_b_tb);
	 
	END ARCHITECTURE testbench;