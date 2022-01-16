----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 12:28:44
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    Port ( clk : in STD_LOGIC;
           PD1 : in STD_LOGIC;
           PD2 : in STD_LOGIC;
           PD3 : in STD_LOGIC;
           PD4 : in STD_LOGIC;
           PA1 : in STD_LOGIC;
           PA2 : in STD_LOGIC;
           PA3 : in STD_LOGIC;
           PA4 : in STD_LOGIC;
           reset : in STD_LOGIC;
           motor_LED1 : out STD_LOGIC;
           motor_LED2 : out STD_LOGIC;
           LED_INDICADOR_LLEGADA: out STD_LOGIC;
           puerta : out STD_LOGIC;
           DISPLAY_SELEC : out STD_LOGIC_VECTOR (7 downto 0);
           DISPLAY_NUMER : out STD_LOGIC_VECTOR (6 downto 0));
end TOP;

architecture Behavioral of TOP is

COMPONENT CLK_DIV
    PORT(
        clock: IN STD_LOGIC;
        clock_200Hz: OUT STD_LOGIC);
    END COMPONENT;


COMPONENT Debouncer
    PORT(
           clock : in STD_LOGIC;
           b1 : in STD_LOGIC;
           b2 : in STD_LOGIC;
           b3 : in STD_LOGIC;
           b4 : in STD_LOGIC;
           P1_OUT : out STD_LOGIC;
           P2_OUT : out STD_LOGIC;
           P3_OUT : out STD_LOGIC;
           P4_OUT : out STD_LOGIC);
END COMPONENT;

COMPONENT DECODER1 
	PORT(
	clk, boton1, boton2, boton3, boton4: IN STD_LOGIC;
	piso: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
);
		END COMPONENT;
		
COMPONENT DECODER2
	PORT(
	clk: IN STD_LOGIC;
	piso: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	pines_display2: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
);
		END COMPONENT;




COMPONENT MOTOR 
	PORT(
	clock: IN STD_LOGIC;
	SENSOR_MOTOR: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	LED1: OUT STD_LOGIC;
    LED2: OUT STD_LOGIC
);
		END COMPONENT;


COMPONENT FSM
	PORT(
	       clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           piso_destino : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           piso_actual : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_DEST: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_ACT: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_P1:out STD_LOGIC;
           LED0: out STD_LOGIC;
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
);
		END COMPONENT;
		
		
COMPONENT Display_refresh 
    Port ( clock : in STD_LOGIC;
           display_selection : out STD_LOGIC_VECTOR (7 downto 0);
           display_number : out STD_LOGIC_VECTOR (6 downto 0);
           piso_actual : in STD_LOGIC_VECTOR (6 downto 0);
           piso_destino : in STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;
		

-- SEÑALES
SIGNAL P_ACT: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL P_DEST: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL PISO_ACT_FSM: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL PISO_DEST_FSM: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL P1_D, P2_D, P3_D, P4_D: STD_LOGIC;    -- BOTONES PLANTA DESTINO
SIGNAL P1_A, P2_A, P3_A, P4_A: STD_LOGIC;    -- BOTONES PLANTA ACTUAL
SIGNAL PUERTA_ORDEN: STD_LOGIC;
SIGNAL ESTADO_PUERTA: STD_LOGIC;
SIGNAL ESTADO_MOTOR: STD_LOGIC_VECTOR (1 DOWNTO 0);
TYPE state_type IS (S1, S2, S3);
SIGNAL state, next_state: state_type;
SIGNAL DISPLAY1, DISPLAY2: STD_LOGIC_VECTOR (6 DOWNTO 0);
SIGNAL RELOJ_200Hz: STD_LOGIC;
SIGNAL RESET_SINREBOTE: STD_LOGIC;

begin

DEBOUNCER_PD: Debouncer
    PORT MAP(
    clock => clk,
    b1 => PD1,
    b2 => PD2,
    b3 => PD3,
    b4 => PD4,
    P1_OUT => P1_D,
    P2_OUT => P2_D,
    P3_OUT => P3_D,
    P4_OUT => P4_D
    );

DEBOUNCER_AD: Debouncer
    PORT MAP(
    clock => clk,
    b1 => PA1,
    b2 => PA2,
    b3 => PA3,
    b4 => PA4,
    P1_OUT => P1_A,
    P2_OUT => P2_A,
    P3_OUT => P3_A,
    P4_OUT => P4_A
    );

CLKDIV200HZ: CLK_DIV
    PORT MAP(
        clock => clk,
        clock_200Hz => RELOJ_200Hz
        );

Decoder_1: DECODER1
	PORT MAP( 
	clk => clk,
	boton1 => P1_D,
	boton2 => P2_D,
	boton3 => P3_D,
    	boton4 => P4_D,
    	piso => P_DEST  );
    
Decoder4: DECODER1
	PORT MAP( 
	clk => clk,
	boton1 => P1_A,
	boton2 => P2_A,
	boton3 => P3_A,
    	boton4 => P4_A,
    	piso => P_ACT  );

Decoder3: DECODER2
	PORT MAP(
	clk => clk,
	piso => PISO_DEST_FSM,
	pines_display2 => DISPLAY1
);


Motor1: MOTOR
	PORT MAP(
	clock => clk,
	SENSOR_MOTOR => ESTADO_MOTOR,
	LED1 => motor_LED1,
	LED2 => motor_LED2
);

D_R: Display_refresh
        PORT MAP(
        clock => RELOJ_200Hz,
        display_selection => DISPLAY_SELEC,
        display_number => DISPLAY_NUMER,
        piso_actual => DISPLAY2,
        piso_destino => DISPLAY1
);

Decoder_2: DECODER2
	PORT MAP(
	clk => clk,
	pines_display2 => DISPLAY2,
	piso => PISO_ACT_FSM
);


FSMASCENSOR: FSM 
    PORT MAP(
	clock => clk,
	RST => reset,
	motor_out => ESTADO_MOTOR,
	piso_actual => P_ACT,
	piso_destino => P_DEST,
	DIS_DEST => PISO_DEST_FSM,
	DIS_ACT => PISO_ACT_FSM,
	LED_P1 => LED_INDICADOR_LLEGADA,
	LED0 => puerta
);

end Behavioral;
