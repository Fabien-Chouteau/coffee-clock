with HAL.Real_Time_Clock;

package Alarm_Handling is

   type Alarm_Action is not null access procedure;

   procedure Start;

   procedure Set_Alarm_Action (Action : Alarm_Action);

   procedure Set_Alarm_Time (Time : HAL.Real_Time_Clock.RTC_Time);

   function Get_Alarm_Time return HAL.Real_Time_Clock.RTC_Time;

end Alarm_Handling;
