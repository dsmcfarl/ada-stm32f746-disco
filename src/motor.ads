with STM32.PWM;
with STM32.GPIO;
with STM32.Device;

-------------------------------------------------------------------------------
-- Motor
--
-- Defines the Motor abstract data type and subprograms to operate on it.
-- Timer 3 channel 1 gets mapped to PB4 (alternate function 2)
-------------------------------------------------------------------------------
package Motor is
   use type STM32.GPIO.GPIO_Point;
   package PWM renames STM32.PWM;

   type Motor is limited private;

   subtype Setpoint is Float range -1.0 .. 1.0;

   ----------------------------------------------------------------------------
   -- Configure
   --
   -- Purpose:
   --    Configure the Motor to use the specified GPIO_Point.
   --
   ----------------------------------------------------------------------------
   procedure Configure
     (This : in out Motor; PWM_GPIO_Point : STM32.GPIO.GPIO_Point) with
      Pre => PWM_GPIO_Point = STM32.Device.PB4 or
      PWM_GPIO_Point = STM32.Device.PA15;

   ----------------------------------------------------------------------------
      -- Set
      --
   -- Set the motor rotation speed with Setpoint (-1.0) being full reverse and
   -- Setpoint (1.0) being full forward.
   ----------------------------------------------------------------------------
   procedure Set (This : in out Motor; New_Setpoint : Setpoint);

private

   type Motor is record
      Power_Control : PWM.PWM_Modulator;
   end record;

end Motor;
