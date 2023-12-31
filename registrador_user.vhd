library IEEE;
use IEEE.std_logic_1164.all;

entity registrador_user is
port(
    in_reg_user: in std_logic_vector(14 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_user: out std_logic_vector(14 downto 0)
);
end registrador_user;

architecture circuit of registrador_user is
    signal out_signal: std_logic_vector(14 downto 0);
    
begin
    out_reg_user <= out_signal;
    
    process(clk, reset) is --verificar identação
    begin 
        if (reset = '1') then
            out_signal <= "000000000000000";

        elsif rising_edge(clk) then
            if(load='1') then
                out_signal <= in_reg_user;
            end if;
        end if;
    end process;
end circuit;        
