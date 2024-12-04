library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Use numeric_std for arithmetic operations

entity ALU_RISC is
    Port (
        A, B       : in  std_logic_vector(15 downto 0);
        Operator   : in  std_logic_vector(2 downto 0);
        Result     : out std_logic_vector(15 downto 0);
        Cout       : out std_logic; -- Carry flag
        Z          : out std_logic  -- Zero flag
    );
end entity;

architecture Behavioral of ALU_RISC is
    signal sum_result, diff_result : std_logic_vector(16 downto 0); -- Extended for carry
    signal mult_result             : std_logic_vector(7 downto 0);  
    signal A_4bit, B_4bit          : std_logic_vector(3 downto 0);  -- 4-bit inputs for multiplication
    signal result_temp             : std_logic_vector(15 downto 0);
begin
    process(A, B, Operator)
    begin
        -- Extract the 4 LSBs of A and B
        A_4bit <= A(3 downto 0);
        B_4bit <= B(3 downto 0);

        case Operator is
            when "000" => -- Addition
                sum_result <= std_logic_vector(unsigned(A) + unsigned(B));  -- Convert to unsigned and add
                result_temp <= sum_result(15 downto 0);
                Cout <= sum_result(16);

            when "100" => -- Subtraction
                diff_result <= std_logic_vector(unsigned(A) - unsigned(B));  -- Convert to unsigned and subtract
                result_temp <= diff_result(15 downto 0);
                Cout <= diff_result(16);

            when "001" => -- AND Operator
                result_temp <= A and B;
                Cout <= '0';

            when "010" => -- OR Operator
                result_temp <= A or B;
                Cout <= '0';

            when "011" => -- NOT Operator
                result_temp <= not A;
                Cout <= '0';

            when "101" => -- 4-bit Multiplication
                mult_result <= std_logic_vector(unsigned(A_4bit) * unsigned(B_4bit));  -- Convert to unsigned for multiplication
                result_temp <= (others => '0');         
                result_temp(7 downto 0) <= mult_result; 
                Cout <= '0';                      -- No carry for 4-bit multiplication

            when "110" => -- Logical Implication 
                result_temp <= not A or B;
                Cout <= '0';

            when others => 
                result_temp <= (others => '0');
                Cout <= '0';
        end case;

        -- Zero flag
        if result_temp = (others => '0') then
            Z <= '1';
        else
            Z <= '0';
        end if;

    Result <= result_temp;
    end process;
end architecture;
