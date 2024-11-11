library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Para operações aritméticas com inteiros

entity trava is
    generic (
        senha: natural range 0 to 255; -- Senha para desbloqueio
        tempo_para_desarme: natural range 0 to 255 -- Tempo máximo de desbloqueio em segundos
    );
    port (
        clock: in std_logic; -- Clock de 1Hz para contagem do tempo
        reset: in std_logic; -- Reset do sistema
        input: in std_logic_vector(7 downto 0); -- Entrada da senha em binário
        segundos: out std_logic_vector(7 downto 0); -- Tempo restante para o bloqueio em binário
        trava_s: out std_logic -- Estado da trava: 1 (bloqueado), 0 (desbloqueado)
    );
end entity;

architecture behavior of trava is
    signal contador: integer range 0 to 255 := 0;
    signal decrement : std_logic := '1';
begin
    process(clock, reset, input)
    begin
        if reset = '1' then
            contador <= tempo_para_desarme;
            trava_s <= '1';
            decrement <= '1';
        elsif rising_edge(clock) then
            if decrement = '1' then 
                if contador > 0 then
                    contador <= contador - 1;
                end if;
                if contador = 0 then
                    trava_s <= '1';
                    decrement <= '0';
                end if;
            end if;
            
            if contador > 0 then
                if input = std_logic_vector(to_unsigned(senha, 8)) then
                    trava_s <= '0';
                    decrement <= '0';
                else
                    trava_s <= '1';
                    decrement <= '1';
                end if;
            end if;
        end if;
    end process;
    segundos <= std_logic_vector(to_unsigned(contador, 8));
end architecture;
