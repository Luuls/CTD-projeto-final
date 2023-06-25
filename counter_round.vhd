library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_round is
    port(reset: in std_logic;
    enable: in std_logic;
    clk: in std_logic;
    is_15: out std_logic;
    round_x: out std_logic_vector(3 downto 0)
    );
end counter_round;

architecture circuit of counter_round is
    signal counter_4bits: std_logic_vector(3 downto 0) := "0000";
    signal is_15_signal: std_logic := '0';
begin
    is_15 <= is_15_signal;
    round_x <= counter_4bits;
    process(clk, reset)
    begin
        if (reset = '1') then
            counter_4bits <= "0000";
            is_15_signal <= '0';

        elsif (rising_edge(clk) and enable = '1') then
            counter_4bits <= counter_4bits + '1';

            if (is_15_signal = '1') then
                counter_4bits <= counter_4bits; -- nao faz nada
                
            elsif (counter_4bits = "1111") then
                is_15_signal <= '1';
                counter_4bits <= "0000";
            end if;
        end if;
    end process;
end circuit;