----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:53:06
-- Design Name: 
-- Module Name: DECODER1 - Behavioral
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

entity DECODER1 is
    Port ( clk : in STD_LOGIC;
           boton1 : in STD_LOGIC;
           boton2 : in STD_LOGIC;
           boton3 : in STD_LOGIC;
           boton4 : in STD_LOGIC;
           piso : out STD_LOGIC_VECTOR (2 DOWNTO 0));
end DECODER1;

architecture Behavioral of DECODER1 is

begin


decoder: PROCESS (clk, boton1, boton2, boton3, boton4)
	BEGIN
		IF rising_edge(clk) THEN		
            IF boton1='1' THEN           
              piso <= "001";
            ELSIF boton2='1' THEN
              piso <= "010";
            ELSIF boton3='1' THEN
              piso <= "011";
            ELSIF boton4='1' THEN
              piso <= "100";
            END IF;	
           END IF;     
END PROCESS; 

end Behavioral;