library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM2 is
port(
    address: in std_logic_vector(3 downto 0);
    output : out std_logic_vector(31 downto 0)
);
end ROM2;

architecture arc_ROM2 of ROM2 is
begin
    --         HEX7     HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0                 round
    output <= "0011" & "1111" & "0110" & "1011" & "1111" & "0000" & "1111" & "1100" when address = "0000" else
             --3        des      6        B        des      0        des      C

              "0001" & "0111" & "1111" & "1001" & "0100" & "1111" & "1111" & "1011" when address = "0001" else
             --1        7        des      9        4        des      des      B

              "0011" & "1111" & "0101" & "1111" & "1010" & "1111" & "0110" & "0000" when address = "0010" else
             --3        des      5        des      A        des      6        0

              "1001" & "1111" & "0010" & "1111" & "0011" & "1000" & "1111" & "1101" when address = "0011" else
             --9        des      2        des      3        8        des      D

              "1010" & "1110" & "1001" & "1111" & "0010" & "1111" & "1111" & "0111" when address = "0100" else
             --A        E        9        des      2        des      des      7

              "1010" & "1111" & "1001" & "0011" & "0001" & "1111" & "1111" & "0100" when address = "0101" else
             --A        des      9        3        1        des      des      4

              "0110" & "0000" & "1111" & "0100" & "1111" & "1100" & "0111" & "1111" when address = "0110" else
             --6        0       des      4        des       C        7        des

              "0111" & "1111" & "0110" & "1111" & "1001" & "1111" & "1010" & "1000" when address = "0111" else
             --7        des      6        des      9        des      A        8

              "1111" & "1011" & "0100" & "0101" & "1111" & "0001" & "1111" & "0110" when address = "1000" else
             --des      B        4        5        des      1        des      6

              "1111" & "0101" & "0111" & "1111" & "0000" & "0100" & "1111" & "0110" when address = "1001" else
             --des      5        7        des      0        4        des      6

              "1111" & "1111" & "0000" & "1001" & "0011" & "0111" & "1111" & "1100" when address = "1010" else
             --des      des      0        9        3        7        des      C

              "0110" & "1100" & "0101" & "1111" & "1011" & "1101" & "1111" & "1111" when address = "1011" else
             --6        C        5        des      B        D        des      des

              "1111" & "1111" & "1101" & "1011" & "0010" & "1010" & "0000" & "1111" when address = "1100" else
             --des      des      D        B        2        A        0        des

              "1111" & "1001" & "1110" & "1011" & "1111" & "1111" & "1101" & "0010" when address = "1101" else
             --des      9        E        B        des      des      D        2

              "1111" & "1000" & "1101" & "0011" & "1111" & "1111" & "0110" & "1011" when address = "1110" else
             --des      8        D        3        des      des      6        B

              "0111" & "0110" & "1111" & "1111" & "1001" & "0100" & "1111" & "0010";
             --7        6        des      des      9        4        des      2
end arc_ROM2;

