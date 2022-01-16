----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 13:08:12
-- Design Name: 
-- Module Name: CLK_DIV - Behavioral
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

entity  CLK_DIV is
    Generic (   frec2: integer:=500000  ); 
             
    Port ( clock : in STD_LOGIC;
           clock_200Hz: out STD_LOGIC);
end CLK_DIV;

architecture Behavioral of CLK_DIV is
signal clk_sig2: std_logic:= '0';

begin
 
  RELOJ_200HZ: process (clock)
  variable cnt1:integer:=0;
  begin

		if clock'event and clock='1' then
			if (cnt1=frec2) then
				cnt1:=0;
				clk_sig2<=not(clk_sig2);
			else
				cnt1:=cnt1+1;
			end if;
		end if;
  end process;
  clock_200Hz<=clk_sig2;


end Behavioral;
