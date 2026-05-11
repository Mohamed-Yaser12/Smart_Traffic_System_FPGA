library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity LEDs_Control is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Start: in STD_LOGIC;
           RED_Vertical: out STD_LOGIC;
           Yellow_Vertical:out STD_LOGIC;
           Green_Vertical:out STD_LOGIC;
           
           RED_Horizontal: out STD_LOGIC;
           Yellow_Horizontal:out STD_LOGIC;
           Green_Horizontal:out STD_LOGIC;
           BASYS_LED:out STD_LOGIC);

           
end LEDs_Control;

architecture Behavioral of LEDs_Control is  
    type state_type is (A, B, C, D, G);
    signal Current_State_H : state_type := G ; 
    signal Current_State_V : state_type := G ;  
    signal Clk_Div : INTEGER := 0;
    signal Clk_Reg : STD_LOGIC := '0';
    signal Clk_LEDs : STD_LOGIC := '0';
       
    signal Counter_10_seconds :STD_LOGIC_VECTOR (31 downto 0);    --10 seconds 
    signal Counter_3_seconds :STD_LOGIC_VECTOR (31 downto 0); --3 seconds
    
begin
    --Start the  Traffic System
    BASYS_LED <= Start;
    -- Counters
    process (CLK,Start)
    begin
    
  if (rising_edge(Clk) and start='1') then
    if Reset = '1' then
        Current_State_H <= G;
    end if;
    if (Current_State_H =G)then
         Current_State_H <= A;
         Current_State_V <=C;
         
     elsif (Current_State_H =A)then         
            if (Counter_10_seconds =x"3B9AC9FF")then --(10*10 power8  -1) otherwise the clk will be faster than the counter
               Counter_10_seconds <= X"00000000";
               Current_State_H <= B;
               Current_State_V <=D;
            else
              Counter_10_seconds <=Counter_10_seconds +1;
            end if;
         
               
    elsif(Current_State_H =B) then
            if (Counter_3_seconds=x"11E1A2FF")then --(3*10 power8  -1) otherwise the clk will be faster than the counter
              Counter_3_seconds<= X"00000000";
              Current_State_H <= C;
              Current_State_V <= A;
            else
              Counter_3_seconds <=Counter_3_seconds+1;
           end if;
         
     
    elsif(Current_State_H =C) then
            if (Counter_10_seconds =x"3B9AC9FF")then 
              Counter_10_seconds <= X"00000000";
              Current_State_H <= D;
              Current_State_V <= B;
           else
             Counter_10_seconds <=Counter_10_seconds +1;
             end if;
         
     
    elsif(Current_State_H =D) then
             if (Counter_3_seconds=x"11E1A2FF")then 
               Counter_3_seconds<= X"00000000";
               Current_State_H <= A;
               Current_State_V <= C;
             else
               Counter_3_seconds <=Counter_3_seconds+1;
             end if;
          
         
    end if;  
    else
     Current_State_H <=Current_State_H;
     Current_State_V <=Current_State_V ; 
    end if;
 
    end process;
 
   process (Current_State_H)
   begin
       case Current_State_H is
              when A =>
                   RED_Horizontal <= not'1';
                   Yellow_Horizontal <= not'0';
                   Green_Horizontal <=not '0';
              when B =>
                   RED_Horizontal <=not '0';
                   Yellow_Horizontal <=not '1';
                   Green_Horizontal <= not'0';
              when C =>
                  RED_Horizontal <= not'0';
                  Yellow_Horizontal <=not '0';
                  Green_Horizontal <=not '1';
              when D =>
                  RED_Horizontal <=not '0';
                  Yellow_Horizontal <=not '1';
                  Green_Horizontal<=not '0';
               when G =>
                  RED_Horizontal <= not'0';
                  Yellow_Horizontal <=not '0';
                  Green_Horizontal <=not '0';    
        end case;
    end process; 
    
    
   process ( Current_State_V, Reset)
    begin
        case Current_State_V is
               when A =>
                    RED_Vertical <= not '1';
                    Yellow_Vertical <= not '0';
                    Green_Vertical <= not '0';
               when B =>
                    RED_Vertical <=not '0';
                    Yellow_Vertical <= not'1';
                    Green_Vertical <= not'0';
               when C =>
                    RED_Vertical <=not '0';
                    Yellow_Vertical <= not'0';
                    Green_Vertical <= not'1';
               when D =>
                    RED_Vertical <=not '0';
                    Yellow_Vertical <= not'1';
                    Green_Vertical <= not'0';
               when G =>
               RED_Vertical <=not '0';
               Yellow_Vertical <=not '0';
               Green_Vertical <= not'0'; 
                                             
         end case;
     end process;           
    
end Behavioral;
