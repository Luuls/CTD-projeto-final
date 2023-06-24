library ieee;
use use ieee.std_logic_1164.all;

entity half_sub is
    port (A, B: in std_logic;
    dif, bo: out_std_logic
    );
end half_sub;

architecture circuit of half_sub is
    begin
        dif <= a xor b;
        bo <= (not a) and b;
end circuit;