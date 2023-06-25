library IEEE;
use IEEE.std_logic_1164.all;

entity reg_4bits is
    port(in_reg_4bits: in std_logic_vector(3 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_4bits: out std_logic_vector(3 downto 0)
    );
end reg_4bits;

architecture circuit of reg_4bits is
begin
    process(clk, reset) is --verificar identação
    begin 
        if (reset = '1') then
            out_reg_4bits = "0000";

        elsif rising_edge(clk) then
            if(load='1') then
                out_reg_4bits <= in_reg_4bits;
            end if;
        end if;
    end process;
end circuit;        