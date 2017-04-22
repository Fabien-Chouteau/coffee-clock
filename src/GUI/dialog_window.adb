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

with Giza.Window; use Giza.Window;
with Giza.GUI;

package body Dialog_Window is

   -------------
   -- On_Init --
   -------------

   overriding procedure On_Init
     (This : in out Instance)
   is
      --  Our real size
      Size : constant Size_T := Get_Size (Parent (This));
   begin

      This.Top_Btn.Disable_Frame;
      This.Bottom_Btn.Disable_Frame;
      This.Icon.Disable_Frame;

      This.Tile.Set_Size ((This.Panel_Size, Size.H));
      This.Tile.Set_Child (1, This.Top_Btn'Unchecked_Access);
      This.Tile.Set_Child (2, This.Icon'Unchecked_Access);
      This.Tile.Set_Child (3, This.Bottom_Btn'Unchecked_Access);

      This.Add_Child (This.Tile'Unchecked_Access,
                      (Size.W - This.Panel_Size, 0));
   end On_Init;

   -----------------------
   -- On_Position_Event --
   -----------------------

   overriding function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean
   is
   begin
      if On_Position_Event (Parent (This), Evt, Pos) then
         if This.Top_Btn.Active then
            This.Answer := Answer_Top;
            Giza.GUI.Pop;
         elsif This.Bottom_Btn.Active then
            This.Answer := Answer_Bottom;
            Giza.GUI.Pop;
         else
            This.Answer := Unknown_Answer;
         end if;

         This.Top_Btn.Set_Active (False);
         This.Bottom_Btn.Set_Active (False);
         return True;
      else
         return False;
      end if;
   end On_Position_Event;

   --------------
   -- Get_Size --
   --------------

   overriding function Get_Size
     (This : Instance)
      return Size_T
   is
      --  Our real size
      Size : constant Size_T := Get_Size (Parent (This));
   begin
      --  Remove the size of side panel button
      return Size - (Size.W / 10, 0);
   end Get_Size;

   ----------------
   -- Get_Answer --
   ----------------

   function Get_Answer (This : Instance) return Answer_T is (This.Answer);

   ------------------
   -- Clear_Answer --
   ------------------

   procedure Clear_Answer (This : in out Instance) is
   begin
      This.Answer := Unknown_Answer;
   end Clear_Answer;

   -------------------
   -- Set_Top_Image --
   -------------------

   procedure Set_Top_Image (This : in out Instance;
                            Img  : Giza.Image.Ref)
   is
   begin
      This.Top_Btn.Set_Image (Img);
   end Set_Top_Image;

   --------------------
   -- Set_Icon_Image --
   --------------------

   procedure Set_Icon_Image (This : in out Instance;
                            Img  : Giza.Image.Ref)
   is
   begin
      This.Icon.Set_Image (Img);
   end Set_Icon_Image;

   ----------------------
   -- Set_Bottom_Image --
   ----------------------

   procedure Set_Bottom_Image (This : in out Instance;
                               Img  : Giza.Image.Ref)
   is
   begin
      This.Bottom_Btn.Set_Image (Img);
   end Set_Bottom_Image;

end Dialog_Window;
