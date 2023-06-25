library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity of subtrator is
    port(enable: in std_logic;
    number: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(3 downto 0)
    );
end subtrator;

architecture circuit of subtrator is
    signal negative_enable, enable_4bit: std_logic_vector(3 downto 0);

begin
    enable_4bit <= "000" & enable;
    negative_enable <= (not enable_4bit) + "0001";
    result <= negative_enable + number;
end circuit; 
