library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MainTB is
end MainTB;

architecture Behavioral of MainTB is
    -- Component declaration for the Main module
    component Main
        Port ( 
            Clk        : in STD_LOGIC;
            Reset      : in STD_LOGIC;
            Data_Line  : inout STD_LOGIC; -- From Temp Sensor
            Echo_1     : in  STD_LOGIC;
            Trig_1     : out STD_LOGIC;
            Echo_2     : in  STD_LOGIC;
            Trig_2     : out STD_LOGIC;
            Echo_3     : in  STD_LOGIC;
            Trig_3     : out STD_LOGIC;
            Echo_4     : in  STD_LOGIC;
            Trig_4     : out STD_LOGIC;
            Alarm      : out STD_LOGIC;  -- Alarm from Ultrasonic
            Start      : in STD_LOGIC;
            BASYS_LED  : out STD_LOGIC;
            RED_Vertical     : out STD_LOGIC;
            Yellow_Vertical  : out STD_LOGIC;
            Green_Vertical   : out STD_LOGIC;
            RED_Horizontal   : out STD_LOGIC;
            Yellow_Horizontal: out STD_LOGIC;
            Green_Horizontal : out STD_LOGIC;
            Anodes           : out STD_LOGIC_VECTOR(3 downto 0);
            Segments         : out STD_LOGIC_VECTOR(6 downto 0);
            Zero             : out STD_LOGIC
        );
    end component;

    -- Testbench signals
    signal Clk_tb       : STD_LOGIC := '0';
    signal Reset_tb     : STD_LOGIC := '0';
    signal Data_Line_tb : STD_LOGIC := '0';
    signal Echo_1_tb, Echo_2_tb, Echo_3_tb, Echo_4_tb : STD_LOGIC := '0';
    signal Trig_1_tb, Trig_2_tb, Trig_3_tb, Trig_4_tb : STD_LOGIC;
    signal Alarm_tb     : STD_LOGIC;
    signal Start_tb     : STD_LOGIC := '0';
    signal BASYS_LED_tb : STD_LOGIC;
    signal RED_Vertical_tb, Yellow_Vertical_tb, Green_Vertical_tb : STD_LOGIC;
    signal RED_Horizontal_tb, Yellow_Horizontal_tb, Green_Horizontal_tb : STD_LOGIC;
    signal Anodes_tb    : STD_LOGIC_VECTOR(3 downto 0);
    signal Segments_tb  : STD_LOGIC_VECTOR(6 downto 0);
    signal Zero_tb      : STD_LOGIC;

    -- Clock generation process
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Main
        Port map (
            Clk => Clk_tb,
            Reset => Reset_tb,
            Data_Line => Data_Line_tb,
            Echo_1 => Echo_1_tb,
            Trig_1 => Trig_1_tb,
            Echo_2 => Echo_2_tb,
            Trig_2 => Trig_2_tb,
            Echo_3 => Echo_3_tb,
            Trig_3 => Trig_3_tb,
            Echo_4 => Echo_4_tb,
            Trig_4 => Trig_4_tb,
            Alarm => Alarm_tb,
            Start => Start_tb,
            BASYS_LED => BASYS_LED_tb,
            RED_Vertical => RED_Vertical_tb,
            Yellow_Vertical => Yellow_Vertical_tb,
            Green_Vertical => Green_Vertical_tb,
            RED_Horizontal => RED_Horizontal_tb,
            Yellow_Horizontal => Yellow_Horizontal_tb,
            Green_Horizontal => Green_Horizontal_tb,
            Anodes => Anodes_tb,
            Segments => Segments_tb,
            Zero => Zero_tb
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            Clk_tb <= not Clk_tb;
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_proc : process
    begin
        -- Reset the system
        Reset_tb <= '1';
        wait for 20 ns;
        Reset_tb <= '0';

        -- Start the system
        Start_tb <= '1';
        wait for 50 ns;
        Start_tb <= '0';

        -- Simulate Data_Line activity
        Data_Line_tb <= '1';
        wait for 100 ns;
        Data_Line_tb <= '0';

        -- Simulate ultrasonic sensor echoes
        Echo_1_tb <= '1';
        wait for 10 ns;
        Echo_1_tb <= '0';

        Echo_2_tb <= '1';
        wait for 10 ns;
        Echo_2_tb <= '0';

        -- Continue testing various scenarios...
        wait for 1 us; -- Wait and observe the outputs

        -- End simulation
        wait;
    end process;

end Behavioral;
