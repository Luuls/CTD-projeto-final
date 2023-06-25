library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM1 is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM1;

architecture arc_ROM1 of ROM1 is
begin
    output <= "1111" & "1111" & "1001" & "1101" & "1111" & "1111" & "1100" & "1011" when address = "0000" else
              --des      des      9      D      des      des      C      B

              "1111" & "0000" & "0100" & "1111" & "1000" & "1111" & "1111" & "1101" when address = "0001" else
              --des      0      4      des      8      des      des      D

              "0100" & "1111" & "1000" & "1111" & "0101" & "1111" & "1111" & "0000" when address = "0010" else
              --4      des      8      des      5      des      des      0

              "0111" & "1011" & "1111" & "1111" & "1111" & "0100" & "1111" & "1110" when address = "0011" else
              --7      B      des      des      des      4      des      E

              "1111" & "1111" & "1001" & "0010" & "0111" & "1111" & "1111" & "1100" when address = "0100" else
              --des      des      9      2      7      des      des      C

              "1101" & "1111" & "1111" & "1111" & "0000" & "1111" & "0101" & "0011" when address = "0101" else
              --D      des      des      des      0      des      5      3

              "0001" & "1111" & "1111" & "1000" & "0000" & "1111" & "0010" & "1111" when address = "0110" else
              --1      des      des      8      0      des      2      des

              "0110" & "1101" & "1111" & "1111" & "1111" & "0010" & "1011" & "1111" when address = "0111" else
              --6      D      des      des      des      2      B      des

              "0011" & "1111" & "1110" & "1101" & "1000" & "1111" & "1111" & "1111" when address = "1000" else
              --3      des      E      D      8      des      des      des

              "1111" & "1111" & "0001" & "1011" & "1010" & "0011" & "1111" & "1111" when address = "1001" else
              --des      des      1      B      A      3      des      des

              "1111" & "1111" & "1011" & "0001" & "1111" & "1111" & "1010" & "1110" when address = "1010" else
              --des      des      B      1      des      des      A      E

              "1111" & "1111" & "0011" & "1111" & "1000" & "1111" & "1110" & "0101" when address = "1011" else
              --des      des      3      des      8      des      E      5

              "1111" & "1011" & "1111" & "1010" & "0100" & "1111" & "1111" & "1110" when address = "1100" else
              --des      B      des      A      4      des      des      E

              "0110" & "1111" & "0101" & "1111" & "1000" & "1001" & "1111" & "1111" when address = "1101" else
              --6      des      5      des      8      9      des      des

              "1111" & "1111" & "0011" & "1110" & "1111" & "0111" & "0110" & "1111" when address = "1110" else
              --des      des      3      E      des      7      6      des

              "1111" & "1000" & "1010" & "1111" & "1111" & "1101" & "0010" & "1111";
              --des      8      A      des      des      D      2      des
end arc_ROM1;
