
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO;
with HAL;
with STM32.Board;
with STM32.Device;   use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with STM32.Timers;    use STM32.Timers;
with STM32_SVD.RCC;

procedure Main is
	Timeout : Time := Clock;
	Cycle : constant Time_Span := Seconds (1);

	-- Ada_Driver_Library doesn't handle this, so using SVD
	procedure Configure_MCO1_PLL_DIV5 is
		MCO1SEL_PLL : constant HAL.Uint2 := 2#11#;
		MCOxPRE_DIV5 : constant HAL.Uint3 := 2#111#;
	begin
		STM32_SVD.RCC.RCC_Periph.CFGR.MCO1 := MCO1SEL_PLL;
		STM32_SVD.RCC.RCC_Periph.CFGR.MCO1PRE := MCOxPRE_DIV5;
	end Configure_MCO1_PLL_DIV5;

	procedure Remap_Timer_11_Input_to_MCO1 is
	begin
		Enable_Clock (Timer_11);
		Configure_Timer_11_Remapping(Timer_11,TIM11_MCO1);  -- had to add TIM11_MCO1 to stm32-timers.ads
	end Remap_Timer_11_Input_to_MCO1;

	procedure Configure_PA8_to_MCO1 is
	begin
		Enable_Clock (GPIO_A);
		Configure_IO (
			PA8,
			(
				Mode           => Mode_AF,
				AF             => GPIO_AF_MCO_0,
				AF_Speed       => Speed_100MHz,
				AF_Output_Type => Push_Pull,
				Resistors      => Floating
			)
		);

	end Configure_PA8_to_MCO1;
begin
	Configure_MCO1_PLL_DIV5;
	Remap_Timer_11_Input_to_MCO1;
	Configure_PA8_to_MCO1;
	STM32.Board.Initialize_LEDs;
	Enable_Clock (GPIO_I);
	Configure_IO (
		PI0,
		(
			Mode           => Mode_Out,
			Speed       => Speed_2MHz,
			Output_Type => Push_Pull,
			Resistors      => Floating
		)
	);
	loop
		Toggle (STM32.Board.All_LEDs);
		Toggle (PI0);
		delay until Timeout;
		Timeout := Timeout + Cycle;
		Ada.Text_IO.Put_Line ("Hello world");
	end loop;
end Main;
