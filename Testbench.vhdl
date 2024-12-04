library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Testbench is
end entity;

architecture Struct of Testbench is

    component iitbcpu is
	port(Clk, reset: in std_logic;
	     ProgCount, InstReg: out std_logic_vector(15 downto 0);
	     FinalState: out integer;
	     RF_final0, RF_final1, RF_final2, RF_final3, RF_final4, RF_final5, RF_final6, RF_final7: out std_logic_vector(15 downto 0));
	 end component;
	 
    signal Clk, Reset: std_logic:='0';
    signal PC, IR: std_logic_vector(15 downto 0);
    signal final_s: integer;
    signal RF_final0, RF_final1, RF_final2, RF_final3, RF_final4, RF_final5, RF_final6, RF_final7: std_logic_vector(15 downto 0);

begin
    DUT: CPU port map (Clk, Reset, PC, IR, final_s, RF_final0, RF_final1, RF_final2, RF_final3, RF_final4, RF_final5, RF_final6, RF_final7);

    Reset <= '0';
    Clk<= not Clk after 100 ns;

end architecture Struct;
