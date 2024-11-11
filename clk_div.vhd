library ieee;
use ieee.std_logic_1164.all;

entity clk_div is
    generic(
        cycle_count: natural := 25_000_000
    );

    port(
        clk_in: in std_logic;
        clk_out: out std_logic
    );
end entity;

architecture behavioral of clk_div is
    signal clk_1hz: std_logic := '0';
begin

    process (clk_in) is
        variable contador: natural range 0 to (cycle_count + 1) := 0;
    begin
        if (rising_edge(clk_in)) then
            contador := contador + 1;
        if (contador >= cycle_count) then
            contador := 0;
            clk_1hz <= not clk_1hz;
        end if;
    end if;
    end process;
	 
	 clk_out <= clk_1hz;
end architecture;
