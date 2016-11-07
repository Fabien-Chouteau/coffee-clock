
with HAL.Real_Time_Clock;

package Real_Time_Clock is

   procedure Set (Time : HAL.Real_Time_Clock.RTC_Time;
                  Date : HAL.Real_Time_Clock.RTC_Date);

   function Get_Time return HAL.Real_Time_Clock.RTC_Time;

   function Get_Date return HAL.Real_Time_Clock.RTC_Date;

end Real_Time_Clock;
