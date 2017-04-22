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

with digit_0;
with digit_1;
with digit_2;
with digit_3;
with digit_4;
with digit_5;
with digit_6;
with digit_7;
with digit_8;
with digit_9;
with colon;
with Giza.Colors; use Giza.Colors;

package body Clock_Widget is

   subtype Clock_Digit is Integer range 0 .. 9;

   ----------
   -- Draw --
   ----------

   overriding procedure Draw
     (This  : in out Instance;
      Ctx   : in out Giza.Context.Class;
      Force : Boolean := True)
   is
      procedure Draw_Digit (Digit : Clock_Digit);

      Digit_Pos_Y : constant Natural := 0;
      Digit_Pos_X : Natural := 0;

      ----------------
      -- Draw_Digit --
      ----------------

      procedure Draw_Digit (Digit : Clock_Digit) is
      begin
         case Digit is
            when 0 =>
               Ctx.Draw_Image (digit_0.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 1 =>
               Ctx.Draw_Image (digit_1.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 2 =>
               Ctx.Draw_Image (digit_2.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 3 =>
               Ctx.Draw_Image (digit_3.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 4 =>
               Ctx.Draw_Image (digit_4.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 5 =>
               Ctx.Draw_Image (digit_5.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 6 =>
               Ctx.Draw_Image (digit_6.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 7 =>
               Ctx.Draw_Image (digit_7.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 8 =>
               Ctx.Draw_Image (digit_8.Image.all, (Digit_Pos_X, Digit_Pos_Y));
            when 9 =>
               Ctx.Draw_Image (digit_9.Image.all, (Digit_Pos_X, Digit_Pos_Y));
         end case;
         --  All digits have the same size
         Digit_Pos_X := Digit_Pos_X + digit_0.Image.Size.W;
      end Draw_Digit;

   begin
      if not This.Dirty and then not Force then
         return;
      end if;

      Ctx.Set_Color (Black);
      Ctx.Fill_Rectangle (((0, 0), This.Get_Size));

      Draw_Digit (Integer (This.Time.Hour) / 10);
      Draw_Digit (Integer (This.Time.Hour) mod 10);

      Ctx.Draw_Image (colon.Image.all, (Digit_Pos_X, Digit_Pos_Y));
      Digit_Pos_X := Digit_Pos_X + colon.Image.Size.W;

      Draw_Digit (Integer (This.Time.Min) / 10);
      Draw_Digit (Integer (This.Time.Min) mod 10);
   end Draw;

   --------------
   -- Set_Time --
   --------------

   procedure Set_Time
     (This : in out Instance;
      Time : HAL.Real_Time_Clock.RTC_Time)
   is
   begin
      This.Time := Time;
      This.Set_Dirty;
   end Set_Time;

   --------------
   -- Get_Time --
   --------------

   function Get_Time (This : Instance) return HAL.Real_Time_Clock.RTC_Time is
      (This.Time);

   -------------------
   -- Required_Size --
   -------------------

   function Required_Size (This : Instance) return Size_T is
      ((4 * digit_0.Image.Size.W + colon.Image.Size.W, digit_0.Image.Size.H));

end Clock_Widget;
