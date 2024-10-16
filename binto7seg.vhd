library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
    port (
        input: in std_logic_vector(7 downto 0); -- Valor binario a ser mostrado ´
        display: out std_logic_vector(7 downto 0) -- Leds do Display de 7 seg.
    );

end entity;