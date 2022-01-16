----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:47:18
-- Design Name: 
-- Module Name: DISPLAY_REFRESH - Behavioral
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

entity DISPLAY_REFRESH is
    Port ( clock : in STD_LOGIC;
           display_selection : out STD_LOGIC_VECTOR (7 downto 0);
           display_number : out STD_LOGIC_VECTOR (6 downto 0);
           piso_actual : in STD_LOGIC_VECTOR (6 downto 0);
           piso_destino : in STD_LOGIC_VECTOR (6 downto 0));
end DISPLAY_REFRESH;

architecture Behavioral of DISPLAY_REFRESH is

begin

PROCESS (clock, piso_destino, piso_actual)
VARIABLE cnt: integer  range 0 to 1 :=0;
BEGIN
IF rising_edge(clock) THEN 
    IF cnt=1 THEN
        cnt:=0;
    ELSE 
    cnt:=cnt+1;
   END IF;
 END IF;
 
 CASE cnt is 
        WHEN 0 => display_selection <="11111101"; -- segunda casilla display
                  display_number <= piso_destino;
 
        WHEN 1 => display_selection <= "11111110"; -- primera casilla display
                  display_number <= piso_actual;            
   END CASE;
   END PROCESS;
   
end Behavioral;
