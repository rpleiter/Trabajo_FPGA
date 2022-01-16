----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:38:33
-- Design Name: 
-- Module Name: Debouncer2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer2 is
    Port ( clock : in STD_LOGIC;
           c : in STD_LOGIC;
           Pc_OUT: out STD_LOGIC);
end Debouncer2;

architecture Behavioral of Debouncer2 is
signal R11, R12, R13: std_logic;
begin

process(clock)
    BEGIN
        if (clock'event and clock = '1') then

            R11 <= c;
            R12 <= R11;
            R13 <= R12;
            -- BOTON c
            
             end if;
    end process;
    Pc_OUT <= R11 and R12 and (not R13);

end Behavioral;
