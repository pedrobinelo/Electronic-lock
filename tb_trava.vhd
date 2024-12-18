library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trava is
end entity;

architecture testbench of tb_trava is
    -- Sinais de entrada e saída
    signal clock: std_logic := '0';
    signal reset: std_logic := '0';
    signal input: std_logic_vector(7 downto 0) := (others => '0');
    signal segundos: std_logic_vector(7 downto 0);
    signal trava: std_logic;

    -- Constantes para a senha e o tempo de desarme
    constant senha_correta: natural := 123;  -- Ajuste de acordo com a senha de teste
    constant tempo_correto: natural := 10; -- Ajuste para o tempo desejado

begin
    uut: entity work.trava(behavior)
        generic map (
            senha => senha_correta,
            tempo_para_desarme => tempo_correto
        )
        port map (
            clock => clock,
            reset => reset,
            input => input,
            segundos => segundos,
            trava_s => trava
        );

    -- Geração do sinal de clock de 1 Hz (um ciclo a cada 1 segundo)
    clock_process: process
    begin
        for i in 0 to 10 loop
            wait for 500 ms;
            clock <= not clock;
        end loop;
        wait;
    end process;

    -- Processo de estímulo
    stimulus_process: process
    begin
        -- Teste de reset
        reset <= '1';
        wait for 1 sec;
        reset <= '0';
        wait for 1 sec;
        assert trava = '1' report "Erro: A trava deveria estar bloqueada após o reset." severity error;

        -- Aguarda um tempo antes de tentar desbloquear
        wait for 1 sec;

        -- Teste de desbloqueio com senha correta
        input <= std_logic_vector(to_unsigned(senha_correta, 8)); -- Senha correta
        wait for 1 sec;
        assert trava = '0' report "Erro: A trava deveria estar desbloqueada com senha correta." severity error;
        wait for 1 sec;

        -- Teste de desbloqueio com senha incorreta
        input <= std_logic_vector(to_unsigned(50, 8)); -- Senha incorreta
        wait for 1 sec;
        assert trava = '1' report "Erro: A trava deveria permanecer bloqueada com senha incorreta." severity error;
        wait for 1 sec;

        -- Verifique o estado após o tempo de desbloqueio expirar e sem tentar desbloquear
        reset <= '1';
        wait for 1 sec;
        reset <= '0';
        wait for 1 sec;

        for i in 0 to tempo_correto loop
            wait for 1 sec;
        end loop;

        assert trava = '1' report "Erro: A trava deveria estar bloqueada apos o tempo expirar." severity error;

        -- Finaliza a simulação
        report "Fim dos testes.";
        wait;
    end process;

end architecture;
