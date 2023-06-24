library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity counter is port (
    CLK: in std_logic;
    clear: in std_logic;
    enable: in std_logic;
    max: out std_logic;
    sum: out std_logic_vector(4 downto 0);
    display1, display0: out std_logic_vector(6 downto 0)
    );
end counter;

architecture circuit of counter is
    signal maxSignal: std_logic := '0';
    signal sumSignal: std_logic_vector(4 downto 0) := "00000";
    signal displaySum: std_logic_vector(6 downto 0);
    
    component bin7seg99 is
        port (
            binaryin: in std_logic_vector (6 downto 0);
            hex1, hex0: out std_logic_vector (6 downto 0)
        );
    end component;
begin
    max <= maxSignal;
    sum <= sumSignal;
    displaySum <= "00" & sumSignal;
 
    BIN7SEG: bin7seg99 port map (displaySum, display1, display0);
    
    process(CLK, clear)
    begin
        if (CLK'event and CLK = '1') then
            if (enable = '1' and maxSignal = '0') then
                sumSignal <= sumSignal + "00001";
            end if;
            
            -- tem que ativar o bit MAX quando o número estiver uma unidade
            -- abaixo do limite, pois o process avalia apenas o valor anterior
            -- à mudança dos itens da sentivity list
            if (sumSignal = "10100") then
                maxSignal <= '1';
            end if;
        end if;
        
        if (clear = '1') then
            sumSignal <= "00000";
            maxSignal <= '0';
        end if;
    end process;
end circuit;