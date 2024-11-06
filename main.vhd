library ieee;
use ieee.std_logic_1164.all;

entity main is 
	port(
       rst: in std_logic; -- Reset do sistema
       inp: in std_logic_vector(7 downto 0); -- Entrada da senha em binário
       seconds: out std_logic_vector(7 downto 0); -- Tempo restante para o bloqueio em binário
       tv: out std_logic -- Estado da trava: 1 (bloqueado), 0 (desbloqueado)
		 clk50: in std_logic
		 input2: in std_logic_vector(3 downto 0); -- Valor binário de entrada (4 bits)
       dsp: out std_logic_vector(7 downto 0) -- Sinais do display de 7 segmentos
	);
end entity;

architecture struct of main is
	signal clk: std_logic := '0';
begin
	travinha: entity work.trava(behavior)
		generic map(
			senha => 123,
			tempo_para_desarme => 10
		)
		port map(
			clock => clk,
			reset => rst,
			input => inp,
			segundos => seconds,
			trava => tv
		);
	led1: entity work.binto7seg(behavior)
		port map(
			input => input2,
			display => dsp
		);
	led2: entity work.binto7seg(behavior)
		port map(
			input => input2,
			display => dsp
		);
	div: entity work.clk_div(behavioral)
		port map(
			clk_in => clk50,
			clk_out => clk
		)
end architecture;