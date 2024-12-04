library ieee;
use ieee.std_logic_1164.all;

entity data_path is
    port (
        state : in integer;
        alu_z : in std_logic;
        m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, pc_w, mw, ir_w, rf_w, t1_w, t2_w, t3_w, z_en : out std_logic;
	op : out std_logic_vector(2 downto 0)
    );
end entity;

architecture struct of data_path is
    signal m1_var, m2_var, m3_var, m4_var, m5_var, m6_var, m7_var, m8_var, m9_var, m10_var,
           m11_var, m12_var, m13_var, pc_w_var, mw_var, ir_w_var, rf_w_var,
           t1_w_var, t2_w_var, t3_w_var, z_en_var : std_logic;
    signal op_var : std_logic_vector(2 downto 0);

begin
    process(state)
    begin
        -- Initialize all signals to '0'
        m1_var    <= '0';
        m2_var    <= '0';
        m3_var    <= '0';
        m4_var    <= '0';
        m5_var    <= '0';
        m6_var    <= '0';
        m7_var    <= '0';
        m8_var    <= '0';
        m9_var    <= '0';
        m10_var   <= '0';
        m11_var   <= '0';
        m12_var   <= '0';
        m13_var   <= '0';
        pc_w_var  <= '0';
        mw_var    <= '0';
        ir_w_var  <= '0';
        rf_w_var  <= '0';
        t1_w_var  <= '0';
        t2_w_var  <= '0';
        t3_w_var  <= '0';
        z_en_var  <= '0';
	op_var <= "000";

        case state is
            when 0 =>
                ir_w_var <= '1';

            when 1 =>
                m13_var <= '1';
                pc_w_var <= '1';
		op_var <= "000";

            when 2 =>
                t1_w_var <= '1';
                t2_w_var <= '1';

            when 3 =>
                t1_w_var <= '1';
		m10_var <= '1';

            when 4 =>
                m8_var <= '1';
                m11_var <= '1';
                t3_w_var <= '1';
		op_var <= "000";

            when 5 =>
                m4_var <= '1';
                rf_w_var <= '1';

            when 6 =>
                m8_var <= '1';
                m11_var <= '1';
                t3_w_var <= '1';
		op_var <= "100";

            when 7 =>
                m8_var <= '1';
                m11_var <= '1';
                t3_w_var <= '1';
		op_var <= "101";

            when 8 =>
                m3_var <= '1';
                rf_w_var <= '1';

            when 9 =>
                m8_var <= '1';
                m11_var <= '1';
                t3_w_var <= '1';
		op_var <= "001";

            when 10 =>
                m8_var <= '1';
                m11_var <= '1';
                t3_w_var <= '1';
		op_var <= "010";

            when 11 =>
                m8_var <= '1';
                m11_var <= '1';
                t3_w_var <= '1';
                m13_var <= '1';
		op_var <= "110";

            when 13 =>
                rf_w_var <= '1';
		m6_var <= '1';

            when 14 =>
                rf_w_var <= '1';
		m5_var <= '1';

            when 15 =>
                t2_w_var <= '1';

            when 16 =>
                m7_var <= '1';
                m8_var <= '1';
                m10_var <= '1';
                t3_w_var <= '1';
		op_var <= "000";

            when 17 =>
                m2_var <= '1';
                m12_var <= '1';
		t3_w_var <= '1';

            when 18 =>
                rf_w_var <= '1';

            when 19 =>
                t1_w_var <= '1';

            when 20 =>
                m2_var <= '1';
                mw_var <= '1';

            when 21 =>
                t2_w_var <= '1';
                t1_w_var <= '1';

            when 22 =>
                m8_var <= '1';
                m11_var <= '1';
		op_var <= "100";

            when 23 =>
                m9_var <= '1';

            when 24 =>
                m13_var <= alu_z;
                z_en_var <= '1';
		pc_w_var <= '1';

            when 25 =>
                m5_var <= '1';
                m6_var <= '1';
                rf_w_var <= '1';

            when 26 =>
                m9_var <= '1';
                m13_var <= '1';
		pc_w_var <= '1';
		op_var <= "000";

            when 27 =>
                m1_var <= '1';
		pc_w_var <= '1';

            when others =>
                m1_var    <= '0';
                m2_var    <= '0';
                m3_var    <= '0';
                m4_var    <= '0';
                m5_var    <= '0';
                m6_var    <= '0';
                m7_var    <= '0';
                m8_var    <= '0';
                m9_var    <= '0';
                m10_var   <= '0';
		m11_var   <= '0';
		m12_var   <= '0';
		m13_var   <= '0';
                pc_w_var  <= '0';
                mw_var    <= '0';
                ir_w_var  <= '0';
                rf_w_var  <= '0';
                t1_w_var  <= '0';
                t2_w_var  <= '0';
                t3_w_var  <= '0';
					 z_en_var  <= '0';
		op_var <= "000";
        end case;

        -- Assign the values to the output signals
    end process;

    m1 <= m1_var;
    m2 <= m2_var;
    m3 <= m3_var;
    m4 <= m4_var;
    m5 <= m5_var;
    m6 <= m6_var;
    m7 <= m7_var;
    m8 <= m8_var;
    m9 <= m9_var;
    m10 <= m10_var;
    m11 <= m11_var;
    m12 <= m12_var;
    m13 <= m13_var;
    pc_w <= pc_w_var;
    mw <= mw_var;
    ir_w <= ir_w_var;
    rf_w <= rf_w_var;
    t1_w <= t1_w_var;
    t2_w <= t2_w_var;
    t3_w <= t3_w_var;
    z_en <= z_en_var;
    op <= op_var;
end struct;
