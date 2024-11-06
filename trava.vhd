library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trava_tb is
end entity;

architecture testbench of trava_tb is
    -- Sinais de entrada e saída
    signal clock: std_logic := '0';
    signal reset: std_logic := '0';
    signal input: std_logic_vector(7 downto 0) := (others => '0');
    signal segundos: std_logic_vector(7 downto 0);
    signal trava: std_logic;

    -- Constantes para a senha e o tempo de desarme
    constant senha_correta: natural := 123;  -- Ajuste de acordo com a senha de teste
    constant tempo_para_desarme_correto: natural := 10; -- Ajuste para o tempo desejado

    -- Instanciação do componente
    component trava
        generic (
            senha: natural;
            tempo_para_desarme: natural
        );
        port (
            clock: in std_logic;
            reset: in std_logic;
            input: in std_logic_vector(7 downto 0);
            segundos: out std_logic_vector(7 downto 0);
            trava: out std_logic
        );
    end component;

begin
    -- Conectando o DUT (Device Under Test)
    uut: trava
        generic map (
            senha => senha_correta,
            tempo_para_desarme => tempo_para_desarme_correto
        )
        port map (
            clock => clock,
            reset => reset,
            input => input,
            segundos => segundos,
            trava => trava
        );

    -- Geração do sinal de clock de 1 Hz (um ciclo a cada 1 segundo)
    clock_process: process
    begin
        wait for 500 ms;
        clock <= not clock;
    end process;

    -- Processo de estímulo
    stimulus_process: process
    begin
        -- Teste de reset
        reset <= '1';
        wait for 1 ns;
        reset <= '0';
        assert trava = '1' report "Erro: A trava deveria estar bloqueada após o reset." severity error;

        -- Aguarda um tempo antes de tentar desbloquear
        wait for 2 sec;

        -- Teste de desbloqueio com senha incorreta
        input <= std_logic_vector(to_unsigned(50, 8)); -- Senha incorreta
        wait for 1 sec;
        assert trava = '1' report "Erro: A trava deveria permanecer bloqueada com senha incorreta." severity error;

        -- Teste de desbloqueio com senha correta
        input <= std_logic_vector(to_unsigned(senha_correta, 8)); -- Senha correta
        wait for 1 sec;
        assert trava = '0' report "Erro: A trava deveria estar desbloqueada com senha correta." severity error;

        -- Simulação de expiração do tempo de desbloqueio
        reset <= '1';
        wait for 1 sec;
        reset <= '0';

        wait for 1 sec;
        assert trava = '1' report "Erro: A trava deveria estar bloqueada após reset." severity error;

        -- Teste de contagem do tempo para bloqueio
        for i in 1 to tempo_para_desarme_correto loop
            wait for 1 sec;
        end loop;

        assert trava = '1' report "Erro: A trava deveria estar bloqueada após o tempo expirar." severity error;

        -- Finaliza a simulação
        wait;
    end process;

end architecture;
