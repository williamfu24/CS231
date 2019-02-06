	component nios_system is
		port (
			clk_clk         : in  std_logic                    := 'X';             -- clk
			hexa_export     : out std_logic_vector(7 downto 0);                    -- export
			hexb_export     : out std_logic_vector(7 downto 0);                    -- export
			leds_export     : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n   : in  std_logic                    := 'X';             -- reset_n
			switches_export : in  std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			hexa_export     => CONNECTED_TO_hexa_export,     --     hexa.export
			hexb_export     => CONNECTED_TO_hexb_export,     --     hexb.export
			leds_export     => CONNECTED_TO_leds_export,     --     leds.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --    reset.reset_n
			switches_export => CONNECTED_TO_switches_export  -- switches.export
		);

