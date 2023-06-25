library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_time is
port(
    reset: in std_logic;
    enable: in std_logic;
    clk: in std_logic;
    is_zero: out std_logic;
    tempo: out std_logic_vector(3 downto 0)
);
end counter_time;

architecture circuit of counter_time is
    signal counter_4bits: std_logic_vector(3 downto 0) := "1010";
    signal is_zero_signal: std_logic := '0';
begin
    is_zero <= is_zero_signal;
    tempo <= counter_4bits;
    process(clk, reset)
    begin
        if (reset = '1') then
            counter_4bits <= "1010";
            is_zero_signal <= '0';

        elsif (rising_edge(clk) and enable = '1') then
            counter_4bits <= counter_4bits - '1';

            if (is_zero_signal = '1') then
                counter_4bits <= counter_4bits;

            elsif (counter_4bits = "0000") then
                is_zero_signal <= '1';
                counter_4bits <= "1010";
            end if;
        end if;
    end process;
end circuit;
