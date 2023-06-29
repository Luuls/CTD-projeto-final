library IEEE;
use IEEE.std_logic_1164.all;

entity registrador_bonus is
port(
    in_reg_bonus: in std_logic_vector(3 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_bonus: out std_logic_vector(3 downto 0)
);
end registrador_bonus;

architecture circuit of registrador_bonus is
begin
    process(clk, reset) is --verificar identação
    begin 
        if (reset = '1') then
            out_reg_bonus <= "1000";

        elsif rising_edge(clk) then
            if(load='1') then
                out_reg_bonus <= in_reg_bonus;
            end if;
        end if;
    end process;
end circuit;        
