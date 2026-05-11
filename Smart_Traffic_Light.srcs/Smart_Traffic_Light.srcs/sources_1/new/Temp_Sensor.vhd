library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Temp_Sensor is
    Port (
        Clk         : in  STD_LOGIC;  -- Clock signal
        Reset       : in  STD_LOGIC;  -- Reset signal
        Data_Line   : inout STD_LOGIC;  -- DHT11 data line
        Dig4        : out STD_LOGIC_VECTOR(3 downto 0); -- High 4 bits of temperature
        Dig3        : out STD_LOGIC_VECTOR(3 downto 0); -- Low 4 bits of temperature
        Dig2        : out STD_LOGIC_VECTOR(3 downto 0); -- High 4 bits of humidity
        Dig1        : out STD_LOGIC_VECTOR(3 downto 0)  -- Low 4 bits of humidity
    );
end Temp_Sensor;

architecture Behavioral of Temp_Sensor is
    signal Clk_us : STD_LOGIC;
    signal Clk_Div2 : INTEGER := 0;
    signal Clk_Reg : STD_LOGIC := '0';
    signal Data_Register : STD_LOGIC_VECTOR(39 downto 0) := (others => '0'); -- 40-bit data buffer
    signal Bit_Index     : integer range 0 to 39 := 0;  -- Current bit index
    signal State         : integer range 0 to 3 := 0;  -- State machine for DHT11 communication
    signal Clk_Div       : integer := 0;  -- Clock divider for timing
    signal Data_Ready    : STD_LOGIC := '0'; -- Indicates data reception is complete
begin

-- Clock Divider to produce clock in micro second
process(Clk)
    begin
        if rising_edge(Clk) then
            if Clk_Div2 = 50 then  -- Divide by 100 (100 MHz / 100 = 1 MHz)
                Clk_Reg <= not Clk_Reg;  -- Toggle the clock
                Clk_Div2 <= 0;
            else
                Clk_Div2 <= Clk_Div2 + 1;
            end if;
        end if;
    end process;
    Clk_us <= Clk_Reg;  -- Assign the toggled clock to output



process (Clk_us)
    variable Bit_Time : integer := 0; -- Timer for bit timing
begin
    if Reset = '1' then
        Data_Register <= (others => '0');
        Bit_Index <= 0;
        State <= 0;
        Clk_Div <= 0;
        Data_Ready <= '0';
    elsif rising_edge(Clk_us) then
        case State is
            when 0 =>
                -- Initialization: Pull the data line low for 18ms and then high for 20-40us
                if Clk_Div < 18000 then
                    Data_Line <= '0';
                    Clk_Div <= Clk_Div + 1;
                elsif Clk_Div < 18040 then
                    Data_Line <= '1';
                    Clk_Div <= Clk_Div + 1;
                else
                    Clk_Div <= 0;
                    Data_Line <= 'Z';
                    State <= 1;
                end if;

            when 1 =>
                -- Wait for DHT11 to respond (low signal for 80us, then high signal for 80us)
                if Data_Line = '0' and Clk_Div < 80 then
                    Clk_Div <= Clk_Div + 1;
                elsif Data_Line = '1' and Clk_Div < 160 then
                    Clk_Div <= Clk_Div + 1;
                elsif Clk_Div >= 160 then
                    Clk_Div <= 0;
                    State <= 2;
                end if;

            when 2 =>
                -- Read 40 bits of data
                if Bit_Time = 0 then
                    if Data_Line = '0' then
                        Bit_Time := Bit_Time + 1;
                    end if;
                elsif Bit_Time = 1 then
                    if Data_Line = '1' then
                        Data_Register(Bit_Index) <= '1';
                    else
                        Data_Register(Bit_Index) <= '0';
                    end if;
                    Bit_Index <= Bit_Index + 1;
                    Bit_Time := 0;
                    if Bit_Index = 39 then
                        State <= 3;
                    end if;
                end if;

            when 3 =>
                Data_Ready <= '1';
                State <= 0;

            when others =>
                State <= 0;
        end case;
    end if;
end process;

-- Extract temperature and humidity data
process (Clk_us)
begin
    if rising_edge(Clk_us) then
        if Data_Ready = '1' then
        -- temp_bits  from 23 till 16
            Dig4 <= Data_Register(23 downto 20);
            Dig3 <= Data_Register(19 downto 16);
            Dig2 <= Data_Register(39 downto 36);
            Dig1 <= Data_Register(35 downto 32);
        end if;
    end if;
end process;

end Behavioral;