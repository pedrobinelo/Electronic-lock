library ieee;
use ieee.std_logic_1164.all;

entity tb_binto7seg is
end entity;

architecture testbench of tb_binto7seg is
    -- Sinais internos para conectar a entidade
    signal input : std_logic_vector(3 downto 0);
    signal display : std_logic_vector(7 downto 0);

begin
    uut: entity work.binto7seg(behavior)
        port map (
            input => input,
            display => display
        );

    -- Processo de estímulo
    stimulus_process: process
    begin
        -- Teste para cada valor binário de 0 a F
        input <= "0000"; wait for 10 ns; -- Testa 0
        assert (display = "10000001") report "Caso 0 falhou!" severity failure;
        input <= "0001"; wait for 10 ns; -- Testa 1
        assert (display = "11001111") report "Caso 1 falhou!" severity failure;
        input <= "0010"; wait for 10 ns; -- Testa 2
        assert (display = "10010010") report "Caso 2 falhou!" severity failure;
        input <= "0011"; wait for 10 ns; -- Testa 3
        assert (display = "10000110") report "Caso 3 falhou!" severity failure;
        input <= "0100"; wait for 10 ns; -- Testa 4
        assert (display = "11001100") report "Caso 4 falhou!" severity failure;
        input <= "0101"; wait for 10 ns; -- Testa 5
        assert (display = "10100100") report "Caso 5 falhou!" severity failure;
        input <= "0110"; wait for 10 ns; -- Testa 6
        assert (display = "10100000") report "Caso 6 falhou!" severity failure;
        input <= "0111"; wait for 10 ns; -- Testa 7
        assert (display = "10001111") report "Caso 7 falhou!" severity failure;
        input <= "1000"; wait for 10 ns; -- Testa 8
        assert (display = "10000000") report "Caso 8 falhou!" severity failure;
        input <= "1001"; wait for 10 ns; -- Testa 9
        assert (display = "10000100") report "Caso 9 falhou!" severity failure;
        input <= "1010"; wait for 10 ns; -- Testa A
        assert (display = "10001000") report "Caso A falhou!" severity failure;
        input <= "1011"; wait for 10 ns; -- Testa B
        assert (display = "11100000") report "Caso B falhou!" severity failure;
        input <= "1100"; wait for 10 ns; -- Testa C
        assert (display = "10110001") report "Caso C falhou!" severity failure;
        input <= "1101"; wait for 10 ns; -- Testa D
        assert (display = "11000010") report "Caso D falhou!" severity failure;
        input <= "1110"; wait for 10 ns; -- Testa E
        assert (display = "10110000") report "Caso E falhou!" severity failure;
        input <= "1111"; wait for 10 ns; -- Testa F
        assert (display = "10111000") report "Caso F falhou!" severity failure;
        -- Finaliza a simulação
        report "Fim dos testes.";
        
        wait;
    end process;
end architecture;
