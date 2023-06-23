library IEEE;
use IEEE.std_logic_1164.all;

entity COMP_erro is
port(
	E0, E1: in std_logic_vector(14 downto 0);
	diferente: out std_logic
);
end COMP_erro;

architecture circuit of COMP_erro is

begin
    diferente <= '1' when E0 = E1 else
                 '0';
end circuit;
