with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO;
with STM32.Board;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with Debug;
with Motor;
with UI;

procedure Main is
   type Steps is (One, Two, Three, Four);
   Timeout     : Time               := Clock;
   Cycle       : constant Time_Span := Seconds (1);
   Left_Motor  : Motor.Motor;
   Right_Motor : Motor.Motor;
   Step        : Steps              := One;
begin
   UI.Initialize;
   UI.Put_Line ("UI: initialized");
   Debug.Output_PLL_DIV5_To_PA8;
   STM32.Board.Initialize_LEDs;
   Enable_Clock (GPIO_I);
   Configure_IO
     (PI0,
      (Mode      => Mode_Out, Speed => Speed_2MHz, Output_Type => Push_Pull,
       Resistors => Floating));

   Motor.Configure (Right_Motor, PB4);
   Motor.Configure (Left_Motor, PA15);

   loop
      case Step is
         when One =>
            Motor.Set (Left_Motor, -1.0);
            Motor.Set (Right_Motor, 1.0);
            Step := Two;
         when Two =>
            Motor.Set (Left_Motor, 0.0);
            Motor.Set (Right_Motor, 0.0);
            Step := Three;
         when Three =>
            Motor.Set (Left_Motor, 1.0);
            Motor.Set (Right_Motor, -1.0);
            Step := Four;
         when Four =>
            Motor.Set (Left_Motor, 0.0);
            Motor.Set (Right_Motor, 0.0);
            Step := One;
      end case;
      Toggle (STM32.Board.All_LEDs);
      Toggle (PI0);
      delay until Timeout;
      Timeout := Timeout + Cycle;
      Ada.Text_IO.Put_Line ("Hello world");
   end loop;
end Main;
