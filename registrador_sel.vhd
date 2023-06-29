library IEEE;
use IEEE.std_logic_1164.all;

entity registrador_sel is
port(
    in_reg_sel: in std_logic_vector(3 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_sel: out std_logic_vector(3 downto 0)
);
end registrador_sel;

architecture circuit of registrador_sel is
    signal out_signal: std_logic_vector(3 downto 0);
    
begin
    out_reg_sel <= out_signal;
    
    process(clk, reset) is --verificar identação
    begin 
        if (reset = '1') then
            out_signal <= "0000";

        elsif rising_edge(clk) then
            if(load='1') then
                out_signal <= in_reg_sel;
            end if;
        end if;
    end process;
end circuit;        
