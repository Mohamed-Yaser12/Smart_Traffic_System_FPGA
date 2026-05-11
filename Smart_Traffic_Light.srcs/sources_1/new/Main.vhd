library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Main is
    Port ( 
        Clk        : in STD_LOGIC;
        Reset      : in STD_LOGIC;
        Data_Line  : inout STD_LOGIC; -- From Temp Sensor
        Echo_1  : in  STD_LOGIC;
        Trig_1  : out STD_LOGIC;
        Echo_2  : in  STD_LOGIC;
        Trig_2  : out STD_LOGIC;
        Echo_3  : in  STD_LOGIC;
        Trig_3  : out STD_LOGIC;
        Echo_4  : in  STD_LOGIC;
        Trig_4  : out STD_LOGIC;
        Alarm      : out STD_LOGIC;  -- Alarm from Ultrasonic
        Start: in STD_LOGIC;
        BASYS_LED: out STD_LOGIC;
        RED_Vertical: out STD_LOGIC;
        Yellow_Vertical:out STD_LOGIC;
        Green_Vertical:out STD_LOGIC;
            
        RED_Horizontal: out STD_LOGIC;
        Yellow_Horizontal:out STD_LOGIC;
        Green_Horizontal:out STD_LOGIC;
        Anodes   : out STD_LOGIC_VECTOR(3 downto 0);
        Segments : out STD_LOGIC_VECTOR(6 downto 0);
        Zero : out STD_LOGIC
    );
end Main;

architecture Behavioral of Main is
    -- Signals for connecting internal module outputs
    signal RED_V : STD_LOGIC;
    signal RED_H : STD_LOGIC;
    signal Dig1, Dig2, Dig3, Dig4 : STD_LOGIC_VECTOR(3 downto 0);
begin

    -- Instantiate LEDs_Control
    LEDs_Control : entity work.LEDs_Control
            Port map (
                Clk => Clk,
                Reset => Reset,
                Start=> Start,
                RED_Vertical=> RED_V,
                Yellow_Vertical=> Yellow_Vertical,
                Green_Vertical=> Green_Vertical,
                RED_Horizontal => RED_H,
                Yellow_Horizontal => Yellow_Horizontal,
                Green_Horizontal => Green_Horizontal,
                BASYS_LED => BASYS_LED
            );

    -- Instantiate Segment_Control
    Segment_Control : entity work.Segment_Control
        Port map (
            Clk => Clk,
            Dig1 => Dig1,
            Dig2 => Dig2,
            Dig3 => Dig3,
            Dig4 => Dig4,
            Anodes => Anodes,
            Segments => Segments
        );

    -- Instantiate Temp_Sensor
    Temp_Sensor : entity work.Temp_Sensor
        Port map (
            Clk => Clk,
            Reset => Reset,
            Data_Line => Data_Line,
            Dig1 => Dig1,
            Dig2 => Dig2,
            Dig3 => Dig3,
            Dig4 => Dig4
        );

    -- Instantiate Ultrasonic_Sensor
    Ultrasonic_Sensor : entity work.Ultrasonic_Sensor
        Port map (
            Clk => Clk,
            Red_V => RED_V,
            Red_H => RED_H,
            Echo_1 => Echo_1,
            Trig_1 => Trig_1,
            Echo_2 => Echo_2,
            Trig_2 => Trig_2,
            Echo_3 => Echo_3,
            Trig_3 => Trig_3,
            Echo_4 => Echo_4,
            Trig_4 => Trig_4,
            Alarm => Alarm
        );
    
    RED_Vertical <= RED_V;
    RED_Horizontal <= RED_H;
    
    Zero <= '1';
end Behavioral;
