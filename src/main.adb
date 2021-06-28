with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO;
with STM32.Board;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with STM32.PWM;     use STM32.PWM;
with STM32.Timers;  use STM32.Timers;
with Debug;

procedure Main is
   Timeout : Time               := Clock;
   Cycle   : constant Time_Span := Seconds (1);

   -- Timer 3 channel 1 gets mapped to PB4 (alternate function 2)
   Selected_Timer      : STM32.Timers.Timer renames Timer_3;
   Selected_GPIO_Port  : GPIO_Port renames GPIO_B;
   Timer_AF : constant STM32.GPIO_Alternate_Function := GPIO_AF_TIM3_2;
   Output_Channel      : constant Timer_Channel                 := Channel_1;
   Selected_Pin        : constant GPIO_Point                    := PB4;
   Requested_Frequency : constant Hertz                         := 50;
   Power_Control       : PWM_Modulator;
begin
   Debug.Output_PLL_DIV5_To_PA8;
   STM32.Board.Initialize_LEDs;
   Enable_Clock (GPIO_I);
   Configure_IO
     (PI0,
      (Mode      => Mode_Out, Speed => Speed_2MHz, Output_Type => Push_Pull,
       Resistors => Floating));
   Configure_PWM_Timer (Selected_Timer'Access, Requested_Frequency);

   Power_Control.Attach_PWM_Channel
     (Selected_Timer'Access, Output_Channel, Selected_Pin, Timer_AF);

   Power_Control.Enable_Output;

   Power_Control.Set_Duty_Cycle (Percentage (6.0));
   loop
      Toggle (STM32.Board.All_LEDs);
      Toggle (PI0);
      delay until Timeout;
      Timeout := Timeout + Cycle;
      Ada.Text_IO.Put_Line ("Hello world");
   end loop;
end Main;
