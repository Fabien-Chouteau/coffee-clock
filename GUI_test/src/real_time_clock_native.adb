with Ada.Real_Time;       use Ada.Real_Time;
with HAL.Real_Time_Clock; use HAL.Real_Time_Clock;

package body Real_Time_Clock is

   Sim_Time : HAL.Real_Time_Clock.RTC_Time;
   Sim_Date : HAL.Real_Time_Clock.RTC_Date;

   ---------
   -- Set --
   ---------

   procedure Set
     (Time : HAL.Real_Time_Clock.RTC_Time;
      Date : HAL.Real_Time_Clock.RTC_Date)
   is
   begin
      Sim_Time := Time;
      Sim_Date := Date;
   end Set;

   --------------
   -- Get_Time --
   --------------

   function Get_Time return HAL.Real_Time_Clock.RTC_Time is
   begin
      return Sim_Time;
   end Get_Time;

   --------------
   -- Get_Date --
   --------------

   function Get_Date return HAL.Real_Time_Clock.RTC_Date is
   begin
      return Sim_Date;
   end Get_Date;

   task Time_Sim is
   end Time_Sim;

   --------------
   -- Time_Sim --
   --------------

   task body Time_Sim is
      Next_Start : Time;
   begin
      Sim_Date.Day_Of_Week := Monday;
      Sim_Date.Day := 1;
      Sim_Date.Month := January;
      Sim_Date.Year := 16;

      Sim_Time.Hour := 12;
      Sim_Time.Min := 0;

      Next_Start := Clock;
      loop
         delay until Next_Start;
         Next_Start := Next_Start + Minutes (1);

         Sim_Time.Min := Sim_Time.Min + 1;
         if Sim_Time.Min = 0 then
            Sim_Time.Hour := Sim_Time.Hour + 1;
         end if;
      end loop;
   end Time_Sim;

end Real_Time_Clock;
