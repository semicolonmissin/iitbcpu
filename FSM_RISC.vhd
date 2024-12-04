library ieee;
use ieee.std_logic_1164.all;

entity FSM is
    port (
        clk, reset       : in std_logic;
        operation        : in std_logic_vector(3 downto 0);
        state_out        : out integer
    );
end entity;

architecture behavior of FSM is
    type state is (
        s0, s1, s2, s3, s4, s5, s6, s7, s8, s9,
        s10, s11, s12, s13, s14, s15, s16, s17, s18, s19,
        s20, s21, s22, s23, s24, s25, s26, s27
    );
    signal current_state, next_state: state := s0;
begin

    clock_proc: process(clk, reset)
    begin
        if (clk = '1' and clk'event) then
            if (reset = '1') then
                current_state <= s0;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;

    fsm_process: process(clk, current_state, operation)
    begin
        case current_state is
	    when s0 =>
	        next_state <= s1;
					 
            when s1 =>
                if (operation = "0000" or operation = "0010" or operation = "0011" or operation = "0100" or operation = "0101" or operation = "0110") then
                    next_state <= s2;
		elsif operation = "0001" then 
		    next_state <= s3;
                elsif (operation= "1001" or operation= "1000") then
                    next_state <= s12;
                elsif (operation= "1011" or operation= "1010") then
                    next_state <= s15;
		elsif (operation= "1100") then
		    next_state <= s21;
		elsif (operation= "1111" or operation= "1101") then
                    next_state <= s25;	
		elsif (operation= "1110") then
                    next_state <= s26;
                end if;

            when s2 =>
                if (operation= "0000") then
                    next_state <= s4;
                elsif (operation = "0010") then
                    next_state <= s6;
                elsif (operation = "0011") then
                    next_state <= s7;
		elsif (operation = "0100") then
		    next_state <= s9; 
		elsif (operation = "0101") then
		    next_state <= s10;
		elsif (operation = "0110") then
		    next_state <= s11;
                end if;

            when s3 =>
                next_state <= s4;

            when s4 =>
                if operation = "0001" then 
		    next_state <= s8;
		elsif operation = "0000" then 
		    next_state <= s5;
	    end if;
					 
            when s5 =>
                next_state <= s0;
					 
            when s6 =>
                next_state <= s5;
					 
            when s7 =>
                next_state <= s5;
	    
	     when s8 =>
                next_state <= s0;
					 
            when s9 =>
                next_state <= s8;
					 
            when s10 =>
                next_state <= s8;
					 
            when s11 =>
                next_state <= s8;
					 
            when s12 =>
                next_state <= s22;

            when s13 =>
                next_state <= s0;

            when s14 =>
                next_state <= s0;

            when s15 =>
                next_state <= s16;
					 
            when s16 =>
                if (operation(0) = '1') then
                    next_state <= s19;
                elsif (operation(0) = '0') then
                    next_state <= s17;
                end if;
					 
            when s17 =>
                next_state <= s18;
					 
            when s18 =>
                next_state <= s0;
					 
            when s19 =>
                next_state <= s20;
					 
            when s20 =>
                next_state <= s0;
					 
            when s21 =>
                next_state <= s22;
					 
            when s22 =>
                next_state <= s23;
					 
            when s23 =>
                next_state <= s24;
				
	    when s24 =>
		next_state <= s0;
				
	    when s25 =>
		if (operation(1) = '1') then
                    next_state <= s27;
                elsif (operation(1) = '0') then
                    next_state <= s26;
                end if;
					 
	    when s26 => 
	        next_state <= s0;
	    
	    when s27 =>
                next_state <= s0;
					 
        end case;
    end process;

    out_proc: process(clk, current_state)
    begin
        case current_state is
            when s0 =>
                state_out <= 0;
            when s1 =>
                state_out <= 1;
            when s2 =>
                state_out <= 2;
            when s3 =>
                state_out <= 3;
            when s4 =>
                state_out <= 4;
            when s5 =>
                state_out <= 5;
            when s6 =>
                state_out <= 6;
            when s7 =>
                state_out <= 7;
            when s8 =>
                state_out <= 8;
            when s9 =>
                state_out <= 9;
            when s10 =>
                state_out <= 10;
            when s11 =>
                state_out <= 11;
            when s12 =>
                state_out <= 12;
            when s13 =>
                state_out <= 13;
            when s14 =>
                state_out <= 14;
            when s15 =>
                state_out <= 15;
            when s16 =>
                state_out <= 16;
            when s17 =>
                state_out <= 17;
            when s18 =>
                state_out <= 18;
            when s19 =>
                state_out <= 19;
            when s20 =>
                state_out <= 20;
            when s21 =>
                state_out <= 21;
            when s22 =>
                state_out <= 22;
            when s23 =>
                state_out <= 23;
            when s24 =>
                state_out <= 24;
            when s25 =>
                state_out <= 25;
            when s26 =>
                state_out <= 26;
	    when s27 =>
                state_out <= 27;
        end case;
    end process;

end behavior;
