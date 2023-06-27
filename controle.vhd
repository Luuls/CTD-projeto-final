library IEEE;
use IEEE.std_logic_1164.all;

entity controle is
port(
-- Entradas de controle
	enter, reset, CLOCK: in std_logic;
-- Entradas de status
	end_game, end_time, end_round, end_FPGA: in std_logic;
-- Saídas de comandos
	R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end controle;

architecture circuit of controle is
    type State is (
        Init,
        Setup,
        Play_FPGA,
        Play_User,
        Count_Round,
        Check,
        Waiting,
        Result
    );
    
    signal current_state, next_state: State;

begin

    process(CLOCK, reset)
    begin
        if reset = '1' then
            current_state <= Init;

        elsif rising_edge(CLOCK) then
            current_state <= next_state;
        end if;
    end process;

    process(end_game, end_time, end_round, end_FPGA, current_state, enter)
    begin
        case (current_state) is
            when Init =>
                next_state <= Setup;

                R1 <= '1';
                R2 <= '1';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';

            when Setup =>
                if (enter = '1') then
                    next_state <= Play_FPGA;
                end if;
                
                R1 <= '0';
                R2 <= '0';
                E1 <= '1';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                
            when Play_FPGA =>
                if (end_FPGA = '1') then
                    next_state <= Play_User;
                end if;
    
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '1';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';

            when Play_User =>
                if (enter = '1') then
                    next_state <= Result;

                elsif (end_time = '1') then
                    next_state <= Count_Round;
                    
                end if;

                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '1';
                E4 <= '0';
                E5 <= '0';
                
            when Count_Round =>
                next_state <= Check ;
                
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '1';
                E5 <= '0';

            when Check =>
                if (end_game = '1' or end_round = '1') then
                    next_state <= Result;

                else
                    next_state <= Waiting;

                end if;

                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                
            when Result =>
                if (enter = '1') then
                    next_state <= Init;
                end if;

                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '1';
                
            when Waiting =>
                if (enter = '1') then
                    next_state <= Play_FPGA;
                end if;

                R1 <= '1';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';

        end case;
    end process;
end circuit;
