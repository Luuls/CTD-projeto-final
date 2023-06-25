library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM1a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM1a;

architecture arc_ROM1a of ROM1a is
begin
--            switches 0 a 14
--            EDCBA9876543210                  round
    output <= "011101000000000" when address = "0000" else
              "010000100010001" when address = "0001" else
              "000000100110001" when address = "0010" else
              "100100010010000" when address = "0011" else
              "001001010000100" when address = "0100" else
              "010000000101001" when address = "0101" else
              "000000100000111" when address = "0110" else
              "010100001000100" when address = "0111" else
              "110000100001000" when address = "1000" else
              "000110000001010" when address = "1001" else
              "100110000000010" when address = "1010" else
              "100000100101000" when address = "1011" else
              "100110000010000" when address = "1100" else
              "000001101100000" when address = "1101" else
              "100000011001000" when address = "1110" else
              "010010100000100";
end arc_ROM1a
