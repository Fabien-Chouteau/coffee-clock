with STM32.Device;

package body Real_Time_Clock is

   ---------
   -- Set --
   ---------

   procedure Set
     (Time : HAL.Real_Time_Clock.RTC_Time;
      Date : HAL.Real_Time_Clock.RTC_Date)
   is
   begin
      STM32.Device.RTC.Set (Time, Date);
   end Set;

   --------------
   -- Get_Time --
   --------------

   function Get_Time return HAL.Real_Time_Clock.RTC_Time is
   begin
      return STM32.Device.RTC.Get_Time;
   end Get_Time;

   --------------
   -- Get_Date --
   --------------

   function Get_Date return HAL.Real_Time_Clock.RTC_Date is
   begin
      return STM32.Device.RTC.Get_Date;
   end Get_Date;

end Real_Time_Clock;
