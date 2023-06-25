library IEEE;
use IEEE.std_logic_1164.all;

entity reg_15bits is
    port(in_reg_15bits: in std_logic_vector(14 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_15bits: out std_logic_vector(14 downto 0)
    );
end reg_15bits;

architecture circuit of reg_15bits is
begin
    process(clk, reset) is --verificar identação
    begin 
        if (reset = '1') then
            out_reg_15bits <= "000000000000000";

        elsif rising_edge(clk) then
            if(load='1') then
                out_reg_15bits <= in_reg_15bits;
            end if;
        end if;
    end process;
end circuit;        