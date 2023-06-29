library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
-- use IEEE.std_logic_arith.all;

entity logica is 
port(
	round, bonus: in std_logic_vector(3 downto 0);
	nivel: in std_logic_vector(1 downto 0);
	points: out std_logic_vector(7 downto 0)
);
end logica;

architecture circuit of logica is
    signal nivel_vezes_32,
           bonus_vezes_2, -- 4 * B / 2 = 2B
           round_sobre_4: std_logic_vector(7 downto 0);

begin
    -- Valor máximo possível de pontuação é 159
    -- 8 bits necessários para representar a pontuação
    
    -- nível
    -- xx -> 2 bits
    -- 000000xx -> nível em 8 bits
    -- 0xx00000 -> nível * 32 em 8 bits (deslocado 5 vezes para a esquerda)
    nivel_vezes_32 <= '0' & nivel & "00000";

    -- bônus em 8 bits
    -- 0000xxxx
    -- 00xxxx00 -> 2 * bônus
    bonus_vezes_2 <= "000" & bonus & "0";
    
    -- round em 8 bits:
    -- 0000xxxx
    -- 000000xx -> round / 2
    round_sobre_4 <= "000000" & (round(3 downto 2));

    points <= nivel_vezes_32 + bonus_vezes_2 + round_sobre_4;
end circuit;
