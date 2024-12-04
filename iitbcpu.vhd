library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.MUX_Package.ALL;

entity iitbcpu is
	port(Clk, reset: in std_logic;
			ProgCount, InstReg: out std_logic_vector(15 downto 0);
			FinalState: out integer;
			RF_final0, RF_final1, RF_final2, RF_final3, RF_final4, RF_final5, RF_final6: out std_logic_vector(15 downto 0));
end entity;

architecture struct of iitbcpu is
	component reg16 is
   port(clk, rw: in std_logic; 
			data_in: in std_logic_vector(15 downto 0);
			data_out: out std_logic_vector(15 downto 0));
	end component;
	
	component Register_file is
	port(RF_A1,RF_A2,RF_A3: in std_logic_vector(2 downto 0);
			RF_D3, PC: in std_logic_vector(15 downto 0);
			rw, Clk: in std_logic;
			RF_D1,RF_D2: out std_logic_vector(15 downto 0);
			RF_0, RF_1, RF_2, RF_3, RF_4, RF_5, RF_6, RF_7: out std_logic_vector(15 downto 0));
	end component;
	
	component ALU_RISC is
    Port (
        A, B       : in  std_logic_vector(15 downto 0);
        Operator   : in  std_logic_vector(2 downto 0);
        Result     : out std_logic_vector(15 downto 0);
        Cout       : out std_logic; -- Carry flag
        Z          : out std_logic  -- Zero flag
    );
	end component;
	
	component FSM is
    port (
        clk, reset       : in std_logic;
        operation        : in std_logic_vector(3 downto 0);
        state_out        : out integer
    );
	end component;
	
	component data_path is
    port (
        state : in integer;
        alu_z : in std_logic;
        m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, pc_w, mw, ir_w, rf_w, t1_w, t2_w, t3_w, z_en : out std_logic
    );
	end component;
	
	component Memory is 
	port (add,data_in: in std_logic_vector(15 downto 0); 
			clk,rw: in std_logic;
			data_out: out std_logic_vector(15 downto 0));
	end component;
---------------------------------------------------------------------------------------

	component CCM is
		port (A: in std_logic_vector(7 downto 0);
				Y: out std_logic_vector(15 downto 0));
	end component;
	
	component CCL is
		port (A: in std_logic_vector(7 downto 0);
				Y: out std_logic_vector(15 downto 0));
	end component;
	
	component SE_6to16 is
    port (
        A: in std_logic_vector(5 downto 0);
        C: out std_logic_vector(15 downto 0)
    );
	end component;
	
	component SE_9to16 is
    port (
        A: in std_logic_vector(8 downto 0);
        C: out std_logic_vector(15 downto 0)
    );
	end component;
---------------------------------------------------------------------------------------
	signal IR_out, PC_out, mem_out, RF_D1, RF_D2 : std_logic_vector(15 downto 0);
	signal M1_out, M2_out,M56_out, M78_out, M91011_out, M12_out, M13_out, M14_out: std_logic_vector(15 downto 0);
	signal M34_out: std_logic_vector(2 downto 0);
	signal ALU_C, T1_out, T2_out, T3_out, SE9_out, SE6_out, CCM_out, CCL_out: std_logic_vector(15 downto 0);
	signal PC_W, IR_W, T1_W, T2_W, T3_W, RF_W, MW: std_logic;
	signal M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, Z_EN, ALU_Z: std_logic;
	signal state: integer;
	signal state_5: std_logic_vector(4 downto 0);
	signal RF_all0, RF_all1, RF_all2, RF_all3, RF_all4, RF_all5, RF_all6: std_logic_vector(15 downto 0);
	begin
	
	FSM_instance        : FSM port map (clk,Reset,IR_out(15 downto 12), state);
	Datapath_instance   : data_path port map(state, ALU_Z, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, PC_W, MW, IR_W, RF_W, T1_W, T2_W, T3_W, Z_EN); 
	
		
	ProgramCounter      : Reg16 port map (clk, PC_W, M1_out, PC_out);
	MemoryInstance      : Memory port map (M2_out, T1_out, Clk, MW, mem_out);
	InstructionRegister : Reg16 port map (clk, IR_W, mem_out, IR_out);
	RegisterFile        : Register_file port map (IR_out(11 downto 9), IR_out(8 downto 6), M34_out, M56_out, PC_out, RF_W, Clk, RF_D1, RF_D2, RF_all0, RF_all1, RF_all2, RF_all3, RF_all4, RF_all5, RF_all6);
	
	state_5 <= std_logic_vector(to_unsigned(state, 5));
	ALU_inst            : ALU port map (M78_out, M91011_out, state_5, ALU_C, ALU_Z);
	
	T1                  : Register_16 port map (clk, T1_W, RF_D1, T1_out);
	T2                  : Register_16 port map (clk, T2_W, M14_out, T2_out);
	T3                  : Register_16 port map (clk, T3_W, M11_out, T3_out);
	
	SE1                 : SE_9to16 port map (IR_out(8 downto 0), SE9_out);
	SE2                 : SE_6to16 port map (IR_out(5 downto 0), SE6_out);
	Concat_msb          : CCM port map (IR_out(7 downto 0), CCM_out);
	Concat_lsb          : CCL port map (IR_out(7 downto 0), CCL_out);
	
	M1_inst             : mux_16bit_2x1 port map (M12_out, RF_D2, M1, M1_out);
	M2_inst             : mux_16bit_2x1 port map (PC_out, T3_out, M2, M2_out);
	M34_inst            : mux_3bit_4x1 port map (IR_out(11 downto 9), IR_out(5 downto 3), IR_out(8 downto 6), "000", M4, M3, M34_out);
	M56_inst            : mux_16bit_4x1 port map (T3_out, CCM_out, CCL_out, PC_out, M6, M5, M56_out);
	M78_inst            : mux_16bit_4x1 port map (PC_out, T1_out, T1_out, T2_out, M8, M7, M78_out);
	M91011_inst         : mux_16bit_8x1 port map ("0000000000000010", T2_out, SE6_out, SE9_out, M10, M9, M910_out);
	M12_inst            : mux_16bit_4x1 port map (ALU_C, mem_out, M12, M12_out);
	M13_inst            : mux_16bit_2x1 port map (PC_out, ALU_C, M13, M14_out);
	M14_inst            : mux_16bit_2x1 port map (PC_out, ALU_C, M14, M14_out);
	
	InstReg<= IR_out;
	ProgCount<= PC_out;
	FinalState<=state;
	
	RF_final0<= RF_all0;
	RF_final1<= RF_all1;
	RF_final2<= RF_all2;
	RF_final3<= RF_all3;
	RF_final4<= RF_all4;
	RF_final5<= RF_all5;
	RF_final6<= RF_all6;

end architecture;