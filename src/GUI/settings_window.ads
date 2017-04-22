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

with Giza.Window;
with Giza.Widget.Button;
with Giza.Widget.Tiles;
use Giza.Widget;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Time_Select_Window;
with Date_Select_Window;
with alarm_80x80;
with clock_80x80;

package Settings_Window is

   subtype Parent is Giza.Window.Instance;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);

   overriding
   procedure On_Displayed (This : in out Instance);

   overriding
   procedure On_Hidden (This : in out Instance) is null;

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean;

private

   type Instance is new Parent with record
      Alarm, Clock, Calandar, Back : aliased Button.Instance;
      Tile : aliased Tiles.Instance (4, Tiles.Left_Right);
      Select_Alarm : aliased Time_Select_Window.Instance
        (alarm_80x80.Image);
      Select_Clock : aliased Time_Select_Window.Instance
        (clock_80x80.Image);
      Select_Date  : aliased Date_Select_Window.Instance;
   end record;
end Settings_Window;
