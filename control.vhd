library IEEE;
use IEEE.std_logic_1164.all;

entity control is
port(
-- Entradas de controle
	enter, reset, CLOCK: in std_logic;
-- Entradas de status
	end_game, end_time, end_round, end_FPGA: in std_logic;
-- Saídas de comandos
	R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end control;

architecture circuit of control is

begin

end circuit;
