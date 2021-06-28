with HAL;
with STM32.Device;
with STM32.GPIO;
with STM32.Timers;
with STM32_SVD.RCC;

-------------------------------------------------------------------------------
-- Debug
-------------------------------------------------------------------------------
package body Debug is

   ----------------------------------------------------------------------------
   -- Output_PLL_DIV5_To_PA8
   --
   -- Implementation Notes:
   --    - Ada Driver Library (ADL) does not handle configuration of MCO1
   --      source and divisor so SVD is used directly for that.
   --    - ADL was missing a definition for TIM11_MCO1 so it was added to
   --      stm32-timers.ad .
   ----------------------------------------------------------------------------
   procedure Output_PLL_DIV5_To_PA8 is

      procedure Configure_MCO1_PLL_DIV5 is
         package RCC renames STM32_SVD.RCC;
         MCO1SEL_PLL  : constant HAL.Uint2 := 2#11#;
         MCOxPRE_DIV5 : constant HAL.Uint3 := 2#111#;
      begin
         RCC.RCC_Periph.CFGR.MCO1    := MCO1SEL_PLL;
         RCC.RCC_Periph.CFGR.MCO1PRE := MCOxPRE_DIV5;
      end Configure_MCO1_PLL_DIV5;

      procedure Remap_Timer_11_Input_to_MCO1 is
         package Device renames STM32.Device;
         package Timers renames STM32.Timers;
      begin
         Device.Enable_Clock (Device.Timer_11);
         Timers.Configure_Timer_11_Remapping
           (Device.Timer_11, Timers.TIM11_MCO1);
      end Remap_Timer_11_Input_to_MCO1;

      procedure Configure_PA8_for_MCO1 is
         package Device renames STM32.Device;
         package GPIO renames STM32.GPIO;
      begin
         Device.Enable_Clock (Device.GPIO_A);
         GPIO.Configure_IO
           (Device.PA8,
            (Mode      => GPIO.Mode_AF, AF => Device.GPIO_AF_MCO_0,
             AF_Speed  => GPIO.Speed_100MHz, AF_Output_Type => GPIO.Push_Pull,
             Resistors => GPIO.Floating));
      end Configure_PA8_for_MCO1;

   begin
      Configure_MCO1_PLL_DIV5;
      Remap_Timer_11_Input_to_MCO1;
      Configure_PA8_for_MCO1;
   end Output_PLL_DIV5_To_PA8;

end Debug;
