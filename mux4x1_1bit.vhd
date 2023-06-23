library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1_1bit is
port(
	E0, E1, E2, E3: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic
);
end mux4x1_1bit;

architecture circuit of mux4x1_1bit is
    
begin
    saida <= E0 when sel = "00" else
             E1 when sel = "01" else
             E2 when sel = "10" else
             E3 when sel = "11";
end circuit;
