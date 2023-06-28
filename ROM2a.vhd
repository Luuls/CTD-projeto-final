library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM2a is
port(
    address: in std_logic_vector(3 downto 0);
    output : out std_logic_vector(14 downto 0)
);
end ROM2a

architecture arc_ROM2a of ROM2a is
begin
--             switches 0 a 14
--             EDCBA9876543210                  round
    output <= "001100001001001" when address = "0000" else
              "000101010010010" when address = "0001" else
              "000010001101001" when address = "0010" else
              "010001100001100" when address = "0011" else
              "100011010000100" when address = "0100" else
              "000011000011010" when address = "0101" else
              "001000011010001" when address = "0110" else
              "000011111000000" when address = "0111" else
              "000100001110010" when address = "1000" else
              "000000011110001" when address = "1001" else
              "001001010001001" when address = "1010" else
              "011100001100000" when address = "1011" else
              "010110000000101" when address = "1100" else
              "110101000000100" when address = "1101" else
              "010100101001000" when address = "1110" else
              "000001011010100";
end arc_ROM2a;
