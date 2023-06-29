library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity datapath is
port(
	-- Entradas de dados
	clk: in std_logic;
	SW: in std_logic_vector(17 downto 0);
	
	-- Entradas de controle
	R1, R2, E1, E2, E3, E4, E5: in std_logic;
	
	-- Saídas de dados
	hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_logic_vector(6 downto 0);
	ledr: out std_logic_vector(15 downto 0);
	
	-- Saídas de status
	end_game, end_time, end_round, end_FPGA: out std_logic
);
end entity;

architecture arc of datapath is
---------------------------SIGNALS-----------------------------------------------------------
--contadores
signal tempo, X: std_logic_vector(3 downto 0);
--FSM_clock
signal CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: std_logic;
--Logica combinacional
signal RESULT: std_logic_vector(7 downto 0);
--Registradores
signal SEL: std_logic_vector(3 downto 0);
signal USER: std_logic_vector(14 downto 0);
signal Bonus, Bonus_reg: std_logic_vector(3 downto 0);
--ROMs
signal CODE_aux: std_logic_vector(14 downto 0);
signal CODE: std_logic_vector(31 downto 0);
--COMP
signal erro: std_logic;
--NOR enables displays
signal E23, E25, E12: std_logic;

--signals implícitos--

--dec termometrico
signal stermoround, stermobonus, andtermo: std_logic_vector(15 downto 0);
--decoders HEX 7-0
signal sdecod7, sdec7, sdecod6, sdec6, sdecod5, sdecod4, sdec4, sdecod3, sdecod2, sdec2, sdecod1, sdecod0, sdec0: std_logic_vector(6 downto 0);
signal smuxhex7, smuxhex6, smuxhex5, smuxhex4, smuxhex3, smuxhex2, smuxhex1, smuxhex0: std_logic_vector(6 downto 0);
signal edec2, edec0: std_logic_vector(3 downto 0);
--saida ROMs
signal srom0, srom1, srom2, srom3: std_logic_vector(31 downto 0);
signal srom0a, srom1a, srom2a, srom3a: std_logic_vector(14 downto 0);
--FSM_clock
signal E2orE3: std_logic;

-- PARA O OR DOS DISPLAYS
signal E23_7VEZES, E25_7VEZES, E12_7VEZES: std_logic_vector(6 downto 0);

signal E1_16VEZES: std_logic_vector(15 downto 0);

---------------------------COMPONENTS-----------------------------------------------------------
component counter_time is 
port(
    reset: in std_logic;
    enable: in std_logic;
    clk: in std_logic;
    is_zero: out std_logic;
    tempo: out std_logic_vector(3 downto 0)
);
end component;

component counter_round is
port(
    reset: in std_logic;
    enable: in std_logic;
    clk: in std_logic;
    is_15: out std_logic;
    round_x: out std_logic_vector(3 downto 0)
);
end component;

component decoder_termometrico is
 port(
	X: in  std_logic_vector(3 downto 0);
	S: out std_logic_vector(15 downto 0)
);
end component;

component FSM_clock_de2 is
port(
	reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

component FSM_clock_emu is
port(
	reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

component decod7seg is
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

component d_code is
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

component mux2x1_7bits is
port(
	E0, E1: in std_logic_vector(6 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(6 downto 0)
);
end component;

component mux2x1_16bits is
port(
	E0, E1: in std_logic_vector(15 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(15 downto 0)
);
end component;

component mux4x1_1bit is
port(
	E0, E1, E2, E3: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic
);
end component;

component mux4x1_15bits is
port(
	E0, E1, E2, E3: in std_logic_vector(14 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(14 downto 0)
);
end component;

component mux4x1_32bits is
port(
	E0, E1, E2, E3: in std_logic_vector(31 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(31 downto 0)
);
end component;

component registrador_sel is 
port(
    in_reg_sel: in std_logic_vector(3 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_sel: out std_logic_vector(3 downto 0)
);
end component;

component registrador_user is 
port(
    in_reg_user: in std_logic_vector(14 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_user: out std_logic_vector(14 downto 0)
);
end component;

component registrador_bonus is 
port(
    in_reg_bonus: in std_logic_vector(3 downto 0);
    load: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    out_reg_bonus: out std_logic_vector(3 downto 0)
);
end component;

component COMP_error is
port(
	E0, E1: in std_logic_vector(14 downto 0);
	diferente: out std_logic
);
end component;

component COMP_end is
port(
	E0: in std_logic_vector(3 downto 0);
	endgame: out std_logic
);
end component;

component subtracao is
port(
    enable: in std_logic;
    number: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(3 downto 0)
);
end component;

component logica is 
port(
	round, bonus: in std_logic_vector(3 downto 0);
	nivel: in std_logic_vector(1 downto 0);
	points: out std_logic_vector(7 downto 0)
);
end component;

component ROM0 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM1 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM2 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM3 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM0a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM1a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM2a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM3a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

-- COMECO DO CODIGO ---------------------------------------------------------------------------------------

begin	
    E2orE3 <= E2 or E3;
    FSMCLOCK: FSM_clock_emu port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz);

    REG_SEL: registrador_sel port map(SW(3 downto 0), E1, R2, clk, SEL);
    
    MUX_CLOCK: mux4x1_1bit port map(CLK_020Hz, CLK_025Hz, CLK_033Hz, CLK_050Hz, SEL(1 downto 0), end_FPGA);

    ROM_0: ROM0 port map(X, srom0);
    ROM_1: ROM1 port map(X, srom1);
    ROM_2: ROM2 port map(X, srom2);
    ROM_3: ROM3 port map(X, srom3);
    MUX_CODE: mux4x1_32bits port map(srom0, srom1, srom2, srom3, SEL(3 downto 2), CODE);

    ROM_0a: ROM0a port map(X, srom0a);
    ROM_1a: ROM1a port map(X, srom1a);
    ROM_2a: ROM2a port map(X, srom2a);
    ROM_3a: ROM3a port map(X, srom3a);
    MUX_CODE_AUX: mux4x1_15bits port map(srom0a, srom1a, srom2a, srom3a, SEL(3 downto 2), CODE_aux);
    
    REG_USER: registrador_user port map(SW(14 downto 0), E3, R2, clk, USER);
    
    COMPARA_IGUAL: COMP_error port map(CODE_aux, USER, erro);

    REG_BONUS: registrador_bonus port map(Bonus, E4, R2, clk, Bonus_reg);
    SUBTRATOR: subtracao port map(erro, Bonus_reg, Bonus);
    
    COMPARA_0: COMP_end port map(Bonus_reg, end_game);

    LOGICA_PONTOS: logica port map(X, Bonus_reg, SEL(1 downto 0), RESULT);

    CONTA_TEMPO: counter_time port map(R1, E3, CLK_1Hz, end_time, tempo);
    
    CONTA_ROUND: counter_round port map(R2, E4, clk, end_round, X);

    E23 <= E2 nor E3;
    E23_7VEZES <= E23 & E23 & E23 & E23 & E23 & E23 & E23;
    
    E25 <= E2 nor E5;
    E25_7VEZES <= E25 & E25 & E25 & E25 & E25 & E25 & E25;
    
    E12 <= E1 nor E2;
    E12_7VEZES <= E12 & E12 & E12 & E12 & E12 & E12 & E12;

    TERMO_BONUS: decoder_termometrico port map(Bonus_reg, stermobonus);
    TERMO_ROUND: decoder_termometrico port map(X, stermoround);
    E1_16VEZES <= E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1 & E1;
    andtermo <= stermoround and (not E1_16VEZES);
    MUX_LED: mux2x1_16bits port map(andtermo, stermobonus, SW(17), ledr);
    
    DCODE_7: d_code port map(CODE(31 downto 28), sdecod7);
    DEC7: decod7seg port map(RESULT(7 downto 4), sdec7);
    MUX_HEX7: mux2x1_7bits port map(sdecod7, sdec7, E5, smuxhex7);
    hex7 <= smuxhex7 or E25_7VEZES;
    
    DCODE_6: d_code port map(CODE(27 downto 24), sdecod6);
    DEC6: decod7seg port map(RESULT(3 downto 0), sdec6);
    MUX_HEX6: mux2x1_7bits port map(sdecod6, sdec6, E5, smuxhex6);
    hex6 <= smuxhex6 or E25_7VEZES;
    
    DCODE_5: d_code port map(CODE(23 downto 20), sdecod5);
    MUX_HEX5: mux2x1_7bits port map(sdecod5, "0000111", E3, smuxhex5);
    hex5 <= smuxhex5 or E23_7VEZES;
    
    DCODE_4: d_code port map(CODE(19 downto 16), sdecod4);
    DEC4: decod7seg port map(tempo, sdec4);
    MUX_HEX4: mux2x1_7bits port map(sdecod4, sdec4, E3, smuxhex4);
    hex4 <= smuxhex4 or E23_7VEZES;
    
    DCODE_3: d_code port map(CODE(15 downto 12), sdecod3);
    MUX_HEX3: mux2x1_7bits port map(sdecod3, "1000110", E1, smuxhex3);
    hex3 <= smuxhex3 or E12_7VEZES;
    
    edec2 <= "00" & SEL(3 downto 2);
    DCODE_2: d_code port map(CODE(11 downto 8), sdecod2);
    DEC2: decod7seg port map(edec2, sdec2);
    MUX_HEX2: mux2x1_7bits port map(sdecod2, sdec2, E1, smuxhex2);
    hex2 <= smuxhex2 or E12_7VEZES;
    
    DCODE_1: d_code port map(CODE(7 downto 4), sdecod1);
    MUX_HEX1: mux2x1_7bits port map(sdecod1, "1000111", E1, smuxhex1);
    hex1 <= smuxhex1 or E12_7VEZES;
    
    edec0 <= "00" & SEL(1 downto 0);
    DCODE_0: d_code port map(CODE(3 downto 0), sdecod0);
    DEC0: decod7seg port map(edec0, sdec0);
    MUX_HEX0: mux2x1_7bits port map(sdecod0, sdec0, E1, smuxhex0);
    hex0 <= smuxhex0 or E12_7VEZES;
    
end arc;
