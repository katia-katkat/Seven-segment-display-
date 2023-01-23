LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY segment IS
port(
	clock : in std_logic;
	BCDin : in std_logic_vector(11 downto 0);
	en_d : out std_logic;
	en : in std_logic;
	display : out std_logic_vector(20 downto 0)
);
END segment;
 
ARCHITECTURE behavior OF segment IS
	type state is (data, convert, update);
	signal etat : state;
	Signal Seven_Segment : std_logic_vector(20 downto 0);
	Signal BCD : std_logic_vector(3 downto 0);

	signal i : integer range 0 to 3 := 0;
	begin
	process(clock)
	begin
	if(rising_edge(clock)) then 
		case etat is 
		when data => 
			if i = 3 then
				etat <= update;			
			elsif(en = '1') then 	
				BCD <= BCDin(i*4 + 3 downto i*4);
				etat <= convert;
			end if;
			
		when update => 
				i <= 0;
				en_d <= '1';
				display <= Seven_Segment;
				etat	 <= data;
		when convert =>
					i <= i +1;
					case BCD is
						when "0000" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0000001"; --0
						when "0001" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "1001111"; --1
						when "0010" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0010010"; --2
						when "0011" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0000110"; --3
						when "0100" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "1001100"; --4
						when "0101" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0100100"; --5
						when "0110" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0100000"; --6
						when "0111" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0001111"; --7
						when "1000" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0000000"; --8
						when "1001" =>
						Seven_Segment(i*7 + 6 downto i*7) <= "0000100"; --9
						when others =>
						Seven_Segment(i*7 + 6 downto i*7) <= "1111111"; --null
					end case;
			etat <= data;
		end case;
	end if;
	end process;

end architecture;