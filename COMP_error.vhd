library IEEE;
use IEEE.std_logic_1164.all;

entity COMP_error is
port(
	E0, E1: in std_logic_vector(14 downto 0);
	diferente: out std_logic
);
end COMP_error;

architecture circuit of COMP_error is

begin
    diferente <= '0' when E0 = E1 else
                 '1';
end circuit;
