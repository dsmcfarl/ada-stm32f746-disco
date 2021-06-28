with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO;
with STM32.Board;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with Debug;
with Motor;

procedure Main is
   Timeout    : Time               := Clock;
   Cycle      : constant Time_Span := Seconds (1);
   Left_Motor : Motor.Motor;
begin
   Debug.Output_PLL_DIV5_To_PA8;
   STM32.Board.Initialize_LEDs;
   Enable_Clock (GPIO_I);
   Configure_IO
     (PI0,
      (Mode      => Mode_Out, Speed => Speed_2MHz, Output_Type => Push_Pull,
       Resistors => Floating));

   Motor.Configure (Left_Motor, PB4);

   loop
      Toggle (STM32.Board.All_LEDs);
      Toggle (PI0);
      delay until Timeout;
      Timeout := Timeout + Cycle;
      Ada.Text_IO.Put_Line ("Hello world");
   end loop;
end Main;
