----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:35:38
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;




entity Debouncer is
    Port ( clock : in STD_LOGIC;
           b1 : in STD_LOGIC;
           b2 : in STD_LOGIC;
           b3 : in STD_LOGIC;
           b4 : in STD_LOGIC;          
           P1_OUT : out STD_LOGIC;
           P2_OUT : out STD_LOGIC;
           P3_OUT : out STD_LOGIC;
           P4_OUT : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is

signal Q11, Q12, Q13, Q21, Q22, Q23, Q31, Q32, Q33, Q41, Q42, Q43 : std_logic;
    BEGIN
    process(clock)
    BEGIN
        if (clock'event and clock = '1') then
            Q11 <= b1;
            Q12 <= Q11;
            Q13 <= Q12;
   -----------------------BOTON1         
            Q21 <= b2;
            Q22 <= Q21;
            Q23 <= Q22;
   -----------------------BOTON2
            Q31 <= b3;
            Q32 <= Q31;
            Q33 <= Q32;
   -----------------------BOTON3
            Q41 <= b4;
            Q42 <= Q41;
            Q43 <= Q42;
   -----------------------BOTON4
    end if;
    end process;
        P1_OUT <= Q11 and Q12 and (not Q13);
        P2_OUT <= Q21 and Q22 and (not Q23);
        P3_OUT <= Q31 and Q32 and (not Q33);
        P4_OUT <= Q41 and Q42 and (not Q43);
        
END behavioral;