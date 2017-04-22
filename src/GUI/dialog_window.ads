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
with Giza.Widget.Frame;
use Giza.Widget;

with Giza.Image;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;

package Dialog_Window is

   type Answer_T is (Unknown_Answer, Answer_Top, Answer_Bottom);

   subtype Parent is Giza.Window.Instance;
   type Instance (Panel_Size : Natural) is
     abstract new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T) return Boolean;

   overriding
   function Get_Size (This : Instance) return Size_T;

   function Get_Answer (This : Instance) return Answer_T;

   procedure Clear_Answer (This : in out Instance);

   procedure Set_Top_Image (This : in out Instance;
                            Img  : Giza.Image.Ref);
   procedure Set_Icon_Image (This : in out Instance;
                             Img  : Giza.Image.Ref);
   procedure Set_Bottom_Image (This : in out Instance;
                               Img  : Giza.Image.Ref);
private
   type Instance (Panel_Size : Natural) is
     abstract new Parent with record
      Top_Btn, Bottom_Btn : aliased Button.Instance;
      Icon                : aliased Frame.Instance;
      Tile                : aliased Tiles.Instance (3, Tiles.Top_Down);
      Answer              : Answer_T := Unknown_Answer;
   end record;
end Dialog_Window;
