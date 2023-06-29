library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM3a is
port(
    address: in std_logic_vector(3 downto 0);
    output : out std_logic_vector(14 downto 0)
);
end ROM3a;

architecture arc_ROM3a of ROM3a is
begin
--             switches 0 a 14
--             EDCBA9876543210                  round
    output <= "110000101000110" when address = "0000" else
              "011010011000001" when address = "0001" else
              "000001011111000" when address = "0010" else
              "011001100001010" when address = "0011" else
              "000100001100111" when address = "0100" else
              "011100100100001" when address = "0101" else
              "010011100100010" when address = "0110" else
              "000001001111100" when address = "0111" else
              "001011000110100" when address = "1000" else
              "000000110011101" when address = "1001" else
              "000010110110100" when address = "1010" else
              "101010000010011" when address = "1011" else
              "011011100000010" when address = "1100" else
              "001100110001010" when address = "1101" else
              "000011101010100" when address = "1110" else
              "000000100011111";
end arc_ROM3a;
