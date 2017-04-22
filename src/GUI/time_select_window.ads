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

with Giza.Widget.Button;
use Giza.Widget;

with Giza.Image;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Dialog_Window;
with Clock_Widget;
with HAL.Real_Time_Clock;

package Time_Select_Window is

   subtype Parent is Dialog_Window.Instance;
   type Instance (Icon : Giza.Image.Ref) is new Parent (Panel_Size => 90)
   with private;

   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);
   overriding
   procedure On_Displayed (This : in out Instance);
   overriding
   procedure On_Hidden (This : in out Instance);

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean;

   procedure Set_Time (This : in out Instance;
                       Time : HAL.Real_Time_Clock.RTC_Time);

   function Get_Time (This : Instance) return HAL.Real_Time_Clock.RTC_Time;

private

   type Instance (Icon : Giza.Image.Ref) is new Parent (Panel_Size => 90)
   with record
      Up_Hours, Down_Hours, Up_Minutes, Down_Minutes : aliased Button.Instance;
      Clock        : aliased Clock_Widget.Instance;
   end record;
end Time_Select_Window;
