with HAL;
with STM32.Timers;

-------------------------------------------------------------------------------
-- Motor
-------------------------------------------------------------------------------
package body Motor is
   procedure Configure
     (This : in out Motor; PWM_GPIO_Point : STM32.GPIO.GPIO_Point)
   is
      package Timers renames STM32.Timers;
      package Device renames STM32.Device;
      Servo_PWM_Frequency : constant HAL.Uint32 := 50;
      Selected_Timer      : access Timers.Timer;
      Timer_AF            : STM32.GPIO_Alternate_Function;
      Output_Channel      : Timers.Timer_Channel;
   begin
      if PWM_GPIO_Point = Device.PB4 then
         Selected_Timer := Device.Timer_3'Access;
         Timer_AF       := Device.GPIO_AF_TIM3_2;
         Output_Channel := Timers.Channel_1;
      elsif PWM_GPIO_Point = Device.PA15 then
         Selected_Timer := Device.Timer_2'Access;
         Timer_AF       := Device.GPIO_AF_TIM2_1;
         Output_Channel := Timers.Channel_1;
      end if;
      STM32.PWM.Configure_PWM_Timer (Selected_Timer, Servo_PWM_Frequency);
      This.Power_Control.Attach_PWM_Channel
        (Selected_Timer, Output_Channel, PWM_GPIO_Point, Timer_AF);
      This.Power_Control.Enable_Output;
      This.Power_Control.Set_Duty_Cycle (STM32.PWM.Percentage (7.5));
   end Configure;

   procedure Set (This : in out Motor; New_Setpoint : Setpoint) is
      package PWM renames STM32.PWM;
      subtype Duty_Cycle is
        PWM.Percentage range PWM.Percentage (5) .. PWM.Percentage (10);
      New_Duty_Cycle : Duty_Cycle;
   begin
      New_Duty_Cycle := Duty_Cycle (7.5 + 2.5 * New_Setpoint);
      This.Power_Control.Set_Duty_Cycle (New_Duty_Cycle);
   end Set;
end Motor;
