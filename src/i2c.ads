with HAL;
with HAL.I2C;

package I2C is

   function Initialized return Boolean;
   --  Return True if the I2C controller is initialized and ready to use

   procedure Initialize (Clock_Speed : HAL.UInt32) with
      Post => Initialized;
   --  Initialize the I2C controller at given speed

   function Controller return not null HAL.I2C.Any_I2C_Port;
   --  Return the HAL.I2C controller implementation

end I2C;
