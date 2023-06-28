library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM3 is
port(
    address: in std_logic_vector(3 downto 0);
    output : out std_logic_vector(31 downto 0)
);
end ROM3;

architecture arc_ROM3 of ROM3 is
begin
    output <= "1111" & "0010" & "1110" & "1000" & "0001" & "1101" & "1111" & "0110" when address = "0000" else
             --des      2        E        8        1        D        des      6

              "0110" & "1111" & "0000" & "0111" & "1101" & "1111" & "1010" & "1100" when address = "0001" else
             --6        des      0        7        D        des      A        C

              "1111" & "0110" & "1001" & "0101" & "0011" & "0111" & "0100" & "1111" when address = "0010" else
             --des      6        9        5        3        7        4        des

              "0001" & "1100" & "1101" & "1111" & "1000" & "0011" & "1001" & "1111" when address = "0011" else
             --1        C        D        des      8        3        9        des

              "1011" & "0010" & "0000" & "1111" & "0110" & "1111" & "0001" & "0101" when address = "0100" else
             --B        2        0        des      6        des      1        5

              "0000" & "1100" & "1111" & "1101" & "0101" & "1000" & "1011" & "1111" when address = "0101" else
             --0        C        des      D        5        8        B        des

              "0001" & "1000" & "1101" & "1111" & "1111" & "1001" & "1010" & "0101" when address = "0110" else
             --1        8        D        des      des      9        A        5

              "1001" & "0010" & "1111" & "0100" & "1111" & "0101" & "0011" & "0110" when address = "0111" else
             --9        2        des      4        des      5        3        6

              "0010" & "1010" & "0100" & "1111" & "1111" & "1100" & "1001" & "0101" when address = "1000" else
             --2        A        4        des      des      C        9        5

              "0100" & "1111" & "0111" & "0010" & "1000" & "0000" & "1111" & "0011" when address = "1001" else
             --4        des      7        2        8        0        des      3

              "1010" & "0101" & "1111" & "1111" & "0100" & "0111" & "1000" & "0010" when address = "1010" else
             --A        5        des      des      4        7        8        2

              "0100" & "0000" & "1100" & "1111" & "1111" & "0001" & "1010" & "1110" when address = "1011" else
             --4        0        C        des      des      1        A        E

              "1111" & "1010" & "0001" & "1000" & "1101" & "1111" & "1100" & "1001" when address = "1100" else
             --des      A        1        8        D        des      C        9

              "0011" & "1011" & "1111" & "0111" & "0001" & "1000" & "1100" & "1111" when address = "1101" else
             --3        B        des      7        1        8        C        des

              "0010" & "0110" & "1111" & "1111" & "1000" & "1010" & "1001" & "0100" when address = "1110" else
             --2        6        des      des      8        A        9        4

              "1111" & "0011" & "0000" & "1111" & "0010" & "0001" & "1000" & "0100";
             --des      3        0        des      2        1        8        4
end arc_ROM3;
