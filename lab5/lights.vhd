-- Implements a simple Nios II system for the DE2-115 series board
-- Inputs: SW7-0 are parallel port inputs to the Nios II system
--         CLOCK_50 is the system clock
--         KEY0 is the active-low system reset
-- Outputs:LED7-0 are parallel port outputs from the Nios II system

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lights is
port (
	CLOCK_50 : in std_logic;
	KEY      : in std_logic_vector(0 downto 0);
	SW       : in std_logic_vector(7 downto 0);
	LEDR     : out std_logic_vector(7 downto 0);
	HEX0     : OUT STD_LOGIC_VECTOR(6 downto 0);
	HEX1     : OUT STD_LOGIC_VECTOR(6 downto 0)
	);
end lights;

architecture lights_rtl of lights is
  component nios_system
      port (
			signal clk_clk : in std_logic;
			signal reset_reset_n : in std_logic;
			signal switches_export : in std_logic_vector (7 downto 0);
			signal leds_export : out std_logic_vector (7 downto 0);
			signal hexa_export : out std_logic_vector (7 downto 0);
			signal hexb_export : out std_logic_vector (7 downto 0)
		);
	end component;
	SIGNAL HEXA : std_logic_vector(7 downto 0);
	SIGNAL HEXB : std_logic_vector(7 downto 0);
begin
HEX0(0)<=HEXA(0);
HEX0(1)<=HEXA(1);
HEX0(2)<=HEXA(2);
HEX0(3)<=HEXA(3);
HEX0(4)<=HEXA(4);
HEX0(5)<=HEXA(5);
HEX0(6)<=HEXA(6);
HEX1(0)<=HEXB(0);
HEX1(1)<=HEXB(1);
HEX1(2)<=HEXB(2);
HEX1(3)<=HEXB(3);
HEX1(4)<=HEXB(4);
HEX1(5)<=HEXB(5);
HEX1(6)<=HEXB(6);
NiosII : nios_system
  port map(
		clk_clk => CLOCK_50,
		reset_reset_n => KEY(0),
		switches_export => SW(7 downto 0),
		leds_export => LEDR(7 downto 0),
		hexa_export => HEXA,
		hexb_export => HEXB
	);
end lights_rtl;