LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_unsigned.ALL;

ENTITY lab6 IS

PORT (
    CLOCK_50 : IN STD_LOGIC;
    KEY  : IN STD_LOGIC_VECTOR (0 DOWNTO 0); 
    SW   : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
    LEDG : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    HEX1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	 );
END lab6;

ARCHITECTURE lab6_rtl OF lab6 IS 
   COMPONENT nios_system
   PORT (
    SIGNAL clk_clk: IN STD_LOGIC;
    SIGNAL reset_reset_n : IN STD_LOGIC;
    SIGNAL switches_export : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
    SIGNAL leds_export : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL hexa_export : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL hexb_export : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
   END COMPONENT; 

   SIGNAL HEXA : std_logic_vector(7 downto 0);
   SIGNAL HEXB : std_logic_vector(7 downto 0);

BEGIN

  HEX0(0) <= HEXA(0);
  HEX0(1) <= HEXA(1);
  HEX0(2) <= HEXA(2);
  HEX0(3) <= HEXA(3);
  HEX0(4) <= HEXA(4);
  HEX0(5) <= HEXA(5);
  HEX0(6) <= HEXA(6);
  HEX1(0) <= HEXB(0);
  HEX1(1) <= HEXB(1);
  HEX1(2) <= HEXB(2);
  HEX1(3) <= HEXB(3);
  HEX1(4) <= HEXB(4);
  HEX1(5) <= HEXB(5);
  HEX1(6) <= HEXB(6);

  NiosII : nios_system 
  PORT MAP(
    clk_clk => CLOCK_50,
    reset_reset_n => KEY(0), 
    switches_export => SW(7 DOWNTO 0), 
    leds_export => LEDG(7 DOWNTO 0),
    hexa_export => HEXA,
    hexb_export => HEXB
  );
END lab6_rtl;