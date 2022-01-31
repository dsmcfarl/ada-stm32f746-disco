with STM32.I2C;
with STM32.Setup;
with STM32.Device;
with STM32.GPIO;

-------------------------------------------------------------------------------
-- I2C
-- References:
--    1. docs/dm00124865-stm32f75xxx-and-stm32f74xxx-advanced-arm-based-32-bit-mcus-stmicroelectronics.pdf
--    2. docs/dm00190424-discovery-kit-for-stm32f7-series-with-stm32f746ng-mcu-stmicroelectronics.pdf
--    3. docs/stm32f746zg.pdf
-------------------------------------------------------------------------------
package body I2C is

   Init_Done : Boolean := False;
   Device    : STM32.I2C.I2C_Port renames STM32.Device.I2C_1;

   ----------------------------------------------------------------------------
   -- Initialized
   ----------------------------------------------------------------------------
   function Initialized return Boolean is (Init_Done);

   ----------------------------------------------------------------------------
   -- Initialize
   ----------------------------------------------------------------------------
   procedure Initialize (Clock_Speed : HAL.UInt32) is
      SCL : STM32.GPIO.GPIO_Point renames STM32.Device.PB8; -- Pin D15 [2:p23]
      SDA : STM32.GPIO.GPIO_Point renames STM32.Device.PB9; -- Pin D14 [2:p23]
   begin
      STM32.Setup.Setup_I2C_Master
        (Port   => Device, SDA => SDA, SCL => SCL,
         SDA_AF => STM32.Device.GPIO_AF_I2C1_4,
         SCL_AF => STM32.Device.GPIO_AF_I2C1_4, Clock_Speed => Clock_Speed);
      -- for alternate function mappings: [3:p77]

      Init_Done := True;
   end Initialize;

   ----------------------------------------------------------------------------
   -- Controller
   ----------------------------------------------------------------------------
   function Controller return not null HAL.I2C.Any_I2C_Port is (Device'Access);

end I2C;
