library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ultrasonic_Sensor is
    Port ( Clk : in STD_LOGIC;
           Red_H   : in  STD_LOGIC;
           Red_V   : in  STD_LOGIC;
           Echo_1  : in  STD_LOGIC;
           Trig_1  : out STD_LOGIC;
           Echo_2  : in  STD_LOGIC;
           Trig_2  : out STD_LOGIC;
           Echo_3  : in  STD_LOGIC;
           Trig_3  : out STD_LOGIC;
           Echo_4  : in  STD_LOGIC;
           Trig_4  : out STD_LOGIC;
           Alarm : out STD_LOGIC);
end Ultrasonic_Sensor;

architecture Behavioral of Ultrasonic_Sensor is
    -- Constants
    constant TRIG_DURATION  : integer := 10;          
    constant MAX_DISTANCE   : integer := 3;          
    constant SOUND_SPEED_CM : integer := 34300;       
    constant TRIG_COUNT     : integer := TRIG_DURATION * 100;
    constant MAX_ECHO_TIME  : integer := (2 * MAX_DISTANCE * 1000000) / SOUND_SPEED_CM;

    -- Signals
    signal Trig_Counter_1       : integer range 0 to TRIG_COUNT := 0;
    signal Trig_Counter_2       : integer range 0 to TRIG_COUNT := 0;
    signal Trig_Counter_3       : integer range 0 to TRIG_COUNT := 0;
    signal Trig_Counter_4       : integer range 0 to TRIG_COUNT := 0;
    signal Echo_Counter_1       : integer range 0 to MAX_ECHO_TIME := 0;
    signal Echo_Counter_2       : integer range 0 to MAX_ECHO_TIME := 0;
    signal Echo_Counter_3       : integer range 0 to MAX_ECHO_TIME := 0;
    signal Echo_Counter_4       : integer range 0 to MAX_ECHO_TIME := 0;
    signal Measuring_1          : STD_LOGIC := '0';
    signal Measuring_2          : STD_LOGIC := '0';
    signal Measuring_3          : STD_LOGIC := '0';
    signal Measuring_4          : STD_LOGIC := '0';
    signal Distance_Measured_1  : integer := 0;
    signal Distance_Measured_2  : integer := 0;
    signal Distance_Measured_3  : integer := 0;
    signal Distance_Measured_4  : integer := 0;
    signal Detected_1           : STD_LOGIC := '0';
    signal Detected_2           : STD_LOGIC := '0';
    signal Detected_3           : STD_LOGIC := '0';
    signal Detected_4           : STD_LOGIC := '0';

begin

    -- Main Process for Trigger generation, Echo measurement, and Detected signal
    process(Clk)
    begin
        if rising_edge(Clk) then
            -- Trigger generation
            if Trig_Counter_1 < TRIG_COUNT then
                Trig_1 <= '1';        -- Generate Trig pulse
                Trig_Counter_1 <= Trig_Counter_1 + 1;
            else
                Trig_1 <= '0';        -- Stop Trig pulse after TRIG_COUNT
                Trig_Counter_1 <= 0;
            end if;
            
            -- Echo measurement
            if Echo_1 = '1' then
                -- Start measuring when Echo goes high
                Measuring_1 <= '1';
                Echo_Counter_1 <= Echo_Counter_1 + 1;
            elsif Measuring_1 = '1' and Echo_1 = '0' then
                -- Stop measuring when Echo goes low
                Measuring_1 <= '0';
                -- Calculate distance
                Distance_Measured_1 <= (Echo_Counter_1 * SOUND_SPEED_CM) / (2 * 100000); -- Time to distance formula
                Echo_Counter_1 <= 0;  -- Reset Echo counter
            end if;
            
            -- Update Detected signal based on measured distance
            if Distance_Measured_1 <= MAX_DISTANCE then
                Detected_1 <= '1';
            else
                Detected_1 <= '0';
            end if;
        end if;
    end process;
    --Sensor 2
    process(Clk)
        begin
            if rising_edge(Clk) then
                -- Trigger generation
                if Trig_Counter_2 < TRIG_COUNT then
                    Trig_2 <= '1';        -- Generate Trig pulse
                    Trig_Counter_2 <= Trig_Counter_2 + 1;
                else
                    Trig_2 <= '0';        -- Stop Trig pulse after TRIG_COUNT
                    Trig_Counter_2 <= 0;
                end if;
                
                -- Echo measurement
                if Echo_2 = '1' then
                    -- Start measuring when Echo goes high
                    Measuring_2 <= '1';
                    Echo_Counter_2 <= Echo_Counter_2 + 1;
                elsif Measuring_2 = '1' and Echo_2 = '0' then
                    -- Stop measuring when Echo goes low
                    Measuring_2 <= '0';
                    -- Calculate distance
                    Distance_Measured_2 <= (Echo_Counter_2 * SOUND_SPEED_CM) / (2 * 100000); -- Time to distance formula
                    Echo_Counter_2 <= 0;  -- Reset Echo counter
                end if;
                
                -- Update Detected signal based on measured distance
                if Distance_Measured_2 <= MAX_DISTANCE then
                    Detected_2 <= '1';
                else
                    Detected_2 <= '0';
                end if;
            end if;
        end process;
        --Sensor 3
        process(Clk)
            begin
                if rising_edge(Clk) then
                    -- Trigger generation
                    if Trig_Counter_3 < TRIG_COUNT then
                        Trig_3 <= '1';        -- Generate Trig pulse
                        Trig_Counter_3 <= Trig_Counter_3 + 1;
                    else
                        Trig_3 <= '0';        -- Stop Trig pulse after TRIG_COUNT
                        Trig_Counter_3 <= 0;
                    end if;
                    
                    -- Echo measurement
                    if Echo_3 = '1' then
                        -- Start measuring when Echo goes high
                        Measuring_3 <= '1';
                        Echo_Counter_3 <= Echo_Counter_3 + 1;
                    elsif Measuring_3 = '1' and Echo_3 = '0' then
                        -- Stop measuring when Echo goes low
                        Measuring_3 <= '0';
                        -- Calculate distance
                        Distance_Measured_3 <= (Echo_Counter_3 * SOUND_SPEED_CM) / (2 * 100000); -- Time to distance formula
                        Echo_Counter_3 <= 0;  -- Reset Echo counter
                    end if;
                    
                    -- Update Detected signal based on measured distance
                    if Distance_Measured_3 <= MAX_DISTANCE then
                        Detected_3 <= '1';
                    else
                        Detected_3 <= '0';
                    end if;
                end if;
            end process;
            --Sensor 4
            process(Clk)
                begin
                    if rising_edge(Clk) then
                        -- Trigger generation
                        if Trig_Counter_4 < TRIG_COUNT then
                            Trig_4 <= '1';        -- Generate Trig pulse
                            Trig_Counter_4 <= Trig_Counter_4 + 1;
                        else
                            Trig_4 <= '0';        -- Stop Trig pulse after TRIG_COUNT
                            Trig_Counter_4 <= 0;
                        end if;
                        
                        -- Echo measurement
                        if Echo_4 = '1' then
                            -- Start measuring when Echo goes high
                            Measuring_4 <= '1';
                            Echo_Counter_4 <= Echo_Counter_4 + 1;
                        elsif Measuring_4 = '1' and Echo_4 = '0' then
                            -- Stop measuring when Echo goes low
                            Measuring_4 <= '0';
                            -- Calculate distance
                            Distance_Measured_4 <= (Echo_Counter_4 * SOUND_SPEED_CM) / (2 * 100000); -- Time to distance formula
                            Echo_Counter_4 <= 0;  -- Reset Echo counter
                        end if;
                        
                        -- Update Detected signal based on measured distance
                        if Distance_Measured_4 <= MAX_DISTANCE then
                            Detected_4 <= '1';
                        else
                            Detected_4 <= '0';
                        end if;
                    end if;
                end process;

    -- Buzzer activation process based on Detected and Red signals
    process(Red_H, Red_V, Detected_1, Detected_2, Detected_3, Detected_4)
    begin
        if Detected_1 = '1' or Detected_2 = '1' then
            if Red_H = '1' then
                Alarm <= '1';
            else
                Alarm <= '0';
            end if;
        end if;
        if Detected_3 = '1' or Detected_4 = '1' then
            if Red_V = '1' then
                Alarm <= '1';
            else
                Alarm <= '0';
            end if;
        end if; 
    end process;
end Behavioral;

