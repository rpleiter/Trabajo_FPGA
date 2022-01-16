----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:57:03
-- Design Name: 
-- Module Name: DECODER2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity DECODER2 is
    Port ( clk : in STD_LOGIC;
           piso : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           pines_display2 : out STD_LOGIC_VECTOR(6 DOWNTO 0));
end DECODER2;

architecture Behavioral of DECODER2 is

begin

decoder2: PROCESS (clk, piso)
	BEGIN
		IF rising_edge(clk) THEN
		IF piso = "001" THEN
		      pines_display2 <= "1001111";
		ELSIF piso = "010" THEN   
		      pines_display2 <= "0010010";
		ELSIF piso = "011" THEN
		      pines_display2 <= "0000110";
		ELSIF piso = "100" THEN
		      pines_display2 <= "1001100";
		      END IF;
			END IF;
      END PROCESS;

end Behavioral;
