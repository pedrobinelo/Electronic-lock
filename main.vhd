library ieee;
use ieee.std_logic_1164.all;

entity main is 
	port(
       rst: in std_logic; -- Reset do sistema -> SW9
       inp: in std_logic_vector(7 downto 0); -- Entrada da senha em binário - SW2, SW1 e SW0
       --seconds: out std_logic_vector(7 downto 0); -- Tempo restante para o bloqueio em binário
       tv: out std_logic; -- Estado da trava: 1 (bloqueado), 0 (desbloqueado) -> LED9 (G9)
		 clk50: in std_logic;
       dsp1: out std_logic_vector(7 downto 0); -- Sinais do display de 7 segmentos
		 dsp2: out std_logic_vector(7 downto 0)
		 -- Os LEDs G2, G1 e G0 serão usados para visualizar os swtiches SW2, SW1 e SW0, respectivamente.
		 -- 
	);
end entity;

architecture struct of main is
	signal clk: std_logic := '0';
	signal ds1, ds2: std_logic_vector(3 downto 0); 
begin
	travinha: entity work.trava(behavior)
		generic map(
			senha => 7,
			tempo_para_desarme => 10
		)
		port map(
			clock => clk,
			reset => rst,
			input => inp,
			segundos (7 downto 4) => ds1,
			segundos (3 downto 0) => ds2,
			trava_s => tv
		);
	led1: entity work.binto7seg(behavior)
		port map(
			input => ds1,
			display => dsp1
		);
	led2: entity work.binto7seg(behavior)
		port map(
			input => ds2,
			display => dsp2 
		);
	div: entity work.clk_div(behavioral)
		port map(
			clk_in => clk50,
			clk_out => clk
		);
end architecture;
