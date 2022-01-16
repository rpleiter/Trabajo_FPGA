----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:09:50
-- Design Name: 
-- Module Name: FSM - Behavioral
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
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity FSM is
    Port ( clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           piso_destino : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           piso_actual : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_DEST: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_ACT: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_P1: out STD_LOGIC;
           LED0: out STD_LOGIC; --led de la puerta, 0 cerrada, 1 abierta
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
           );               
end FSM;

architecture Behavioral of FSM is
    TYPE state_type IS (S1, S2, S3); --S1 es estado en reposo, S2 subiendo, S3 bajando
    SIGNAL next_state: state_type;
    SIGNAL state: state_type;
    SIGNAL LED_S1: STD_LOGIC;
    SIGNAL P_D: INTEGER;
    SIGNAL P_A: INTEGER;
    SIGNAL MOTOR: STD_LOGIC_VECTOR (1 downto 0);
		
begin 

SINCRONIZACION_RELOJ: PROCESS (clock,RST)
	BEGIN  
	  --  state <= S1;	  
	  IF RST= '0' THEN
	       state <= S1;
	       DIS_DEST <= "001";
	       DIS_ACT <= "001";  
	       P_D <= 1;
	       P_A <= 1;
	             
	 ELSIF (clock'event and clock='1') AND RST='0' THEN
		P_A <= to_integer(unsigned(piso_actual));  	   	     
	    DIS_ACT <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, DIS_DEST'LENGTH));
	    state <= next_state;
	    IF MOTOR = "00" THEN
	        P_D <= to_integer(unsigned(piso_destino));  
	       DIS_DEST <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_D, DIS_DEST'LENGTH)); 
	    END IF;
	  END IF;
END PROCESS;


NEXT_STATE_DECODE: PROCESS (clock, state, P_D, P_A)  

  BEGIN	
	next_state <= state;    		     
     case state is
     when S1 =>
         IF (P_D-P_A=0 ) THEN		-- planta deseada		
                    next_state <= S1;	    --estado de reposo    
         ELSIF (P_D-P_A>0) THEN   -- la planta deseada está arriba
                    next_state <= S2;	-- estado subiendo
         ELSIF (P_D-P_A<0) THEN     -- planta deseada esta abajo
                    next_state <= S3;   -- estado bajando
         END IF;
     when S2=>         
       IF (P_D-P_A=0) THEN		-- planta deseada		
		        next_state <= S1; -- reposo
		        END IF;   
      when S3=> 
         IF (P_D-P_A=0) THEN		-- planta deseada	
		        next_state <= S1; -- reposo
		        END IF;
END CASE;
END PROCESS;


Estado_del_motor: PROCESS (clock, state )
begin       
        case state is 
        when S1=>
                MOTOR <= "00";		-- Hay dos señales motor, porque MOTOR es una señal de la arquitectura que usamos para hacer comparaciones
                motor_out <= "00";	-- con la salida no podriamos hacer comparaciones
                LED0 <= '1';
                LED_P1 <= '1';
        when S2 =>               
                 MOTOR <= "01";
                 motor_out <= "01";  
                 LED0 <= '0';
                 LED_P1 <= '0';          
         when S3 => 
                 MOTOR <= "10";
                 motor_out <= "10"; 
                 LED0 <= '0';
                 LED_P1 <= '0';    
end case;
	END PROCESS;

end Behavioral;
