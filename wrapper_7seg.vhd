----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:32 12/29/2022 
-- Design Name: 
-- Module Name:    wrapper_7seg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wrapper_7seg is
	generic (clock_per_bit : integer := 100000
	);
port(	clock : in std_logic;
      en : in std_logic;
		Binary_in : in std_logic_vector(11 downto 0);
		anodes : out std_logic_vector(7 downto 0);
		data : out std_logic_vector(6 downto 0)
);
end wrapper_7seg;

architecture Behavioral of wrapper_7seg is
signal display : std_logic_vector(20 downto 0);
signal an : integer range 0 to 7 := 0;
signal en_d : std_logic;

signal counter : integer range 0 to clock_per_bit-1 := 0;

	component segment is
		port(
		clock : in std_logic;
		BCDin : in std_logic_vector(11 downto 0);
		en : in std_logic;
		en_d : out std_logic;
		display : out std_logic_vector(20 downto 0)
		);
	END component segment;
begin
	b_7 : segment port map(clock => clock,BCDin=>Binary_in, en_d=>en_d, en=> en ,display=> display) ;
	

	process(clock)
	begin 
		if(rising_edge(clock))then 
			if(counter = clock_per_bit - 1 ) then
				counter <= 0;
				if an > 7 then 
					an <= 0;
				else 	
					an <= an + 1;
				end if;
			else 
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	process(clock)
	begin 
	if( rising_edge(clock) ) then 
	if(en_d = '1')then 
		case an is 
			when 0 =>
				anodes <= "11111110";
				data <= display(6 downto 0);				
			
			when 1 => 
				anodes <= "11111101";	
				data <= display(13 downto 7);
				
			when 2 => 
				anodes <= "11111011";
				data <= display(20 downto 14);
				
			when 3 =>
				anodes <= "11110111";
				data <= "1111111";				
			
			when 4 => 
				anodes <= "11101111";	
				data <= "1111111";
				
			when 5 => 
				anodes <= "11011111";
				data <= "1111111";
				
			when 6 => 
				anodes <= "10111111";	
				data <= "1111111";
				
			when 7 => 
				anodes <= "01111111";
				data <= "1111111";
		end case;
		end if;
		end if;
	end process;
	
end Behavioral;

