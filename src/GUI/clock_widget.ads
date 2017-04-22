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

with Giza.Widget;
with Giza.Context;
with Giza.Types; use Giza.Types;
with HAL.Real_Time_Clock;

package Clock_Widget is

   subtype Parent is Giza.Widget.Instance;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := True);

   procedure Set_Time (This : in out Instance;
                       Time : HAL.Real_Time_Clock.RTC_Time);

   function Get_Time (This : Instance) return HAL.Real_Time_Clock.RTC_Time;

   function Required_Size (This : Instance) return Size_T;
private

   type Instance is new Parent with record
      Time : HAL.Real_Time_Clock.RTC_Time;
   end record;

end Clock_Widget;
