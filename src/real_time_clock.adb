-------------------------------------------------------------------------------
--                                                                           --
--                               Coffee Clock                                --
--                                                                           --
--                  Copyright (C) 2016-2017 Fabien Chouteau                  --
--                                                                           --
--    Coffee Clock is free software: you can redistribute it and/or          --
--    modify it under the terms of the GNU General Public License as         --
--    published by the Free Software Foundation, either version 3 of the     --
--    License, or (at your option) any later version.                        --
--                                                                           --
--    Coffee Clock is distributed in the hope that it will be useful,        --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of         --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU       --
--    General Public License for more details.                               --
--                                                                           --
--    You should have received a copy of the GNU General Public License      --
--    along with We Noise Maker. If not, see <http://www.gnu.org/licenses/>. --
--                                                                           --
-------------------------------------------------------------------------------

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
