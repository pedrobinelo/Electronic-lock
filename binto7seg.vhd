library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
    port (
        input: in std_logic_vector(3 downto 0); -- Valor binário de entrada (4 bits)
        display: out std_logic_vector(7 downto 0) -- Sinais do display de 7 segmentos
    );
end entity;

architecture behavior of binto7seg is

begin
    process(input)
    begin
        case input is 
            when "0000" => display <= "10000000"; -- Exibe 0
            when "0001" => display <= "11111100"; -- Exibe 1
            when "0010" => display <= "10100100"; -- Exibe 2
            when "0011" => display <= "10110000"; -- Exibe 3
            when "0100" => display <= "10011001"; -- Exibe 4
            when "0101" => display <= "10010010"; -- Exibe 5
            when "0110" => display <= "10000010"; -- Exibe 6
            when "0111" => display <= "11111000"; -- Exibe 7
            when "1000" => display <= "10000000"; -- Exibe 8
            when "1001" => display <= "10011000"; -- Exibe 9
            when "1010" => display <= "10001000"; -- Exibe A
            when "1011" => display <= "10000011"; -- Exibe B
            when "1100" => display <= "11000110"; -- Exibe C
            when "1101" => display <= "10100001"; -- Exibe D
            when "1110" => display <= "10000110"; -- Exibe E
            when "1111" => display <= "10001110"; -- Exibe F
            when others => display <= "11111111"; -- Exibe nada (apaga)
        end case;
    end process;
end architecture; 
