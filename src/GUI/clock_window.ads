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
with Giza.Context;
with Giza.Window;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Settings_Window;
with Clock_Widget;
with Date_Widget;
with HAL.Real_Time_Clock;

package Clock_Window is

   subtype Parent is Giza.Window.Instance;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);
   overriding
   procedure On_Displayed (This : in out Instance);
   overriding
   procedure On_Hidden (This : in out Instance);
   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := False);
   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean;

   procedure Set_Time (This : in out Instance;
                       Time : HAL.Real_Time_Clock.RTC_Time);

   procedure Set_Date (This : in out Instance;
                       Date : HAL.Real_Time_Clock.RTC_Date);
private

   type Instance is new Parent with record
      Settings_Btn : aliased Button.Instance;
      Settings     : aliased Settings_Window.Instance;
      Clock        : aliased Clock_Widget.Instance;
      Date         : aliased Date_Widget.Instance (Show_Day_Of_Week => False);
   end record;
end Clock_Window;
