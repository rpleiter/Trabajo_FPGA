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


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.





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

signal OP11, OP12, OP13, OP21, OP22, OP23, OP31, OP32, OP33, OP41, OP42, OP43 : std_logic;
    BEGIN
    process(clock)
    BEGIN
        if (clock'event and clock = '1') then
            OP11 <= b1;
            OP12 <= OP11;
            OP13 <= OP12;
   -----------------------BOTON1         
            OP21 <= b2;
            OP22 <= OP21;
            OP23 <= OP22;
   -----------------------BOTON2
            OP31 <= b3;
            OP32 <= OP31;
            OP33 <= OP32;
   -----------------------BOTON3
            OP41 <= b4;
            OP42 <= OP41;
            OP43 <= OP42;
   -----------------------BOTON4
    end if;
    end process;
        P1_OUT <= OP11 and OP12 and OP13;
        P2_OUT <= OP21 and OP22 and OP23;
        P3_OUT <= OP31 and OP32 and OP33;
        P4_OUT <= OP41 and OP42 and OP43;
        
END behavioral;
