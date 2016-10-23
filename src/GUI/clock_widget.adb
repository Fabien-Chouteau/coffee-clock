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
               Ctx.Copy_Bitmap (digit_0.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 1 =>
               Ctx.Copy_Bitmap (digit_1.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 2 =>
               Ctx.Copy_Bitmap (digit_2.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 3 =>
               Ctx.Copy_Bitmap (digit_3.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 4 =>
               Ctx.Copy_Bitmap (digit_4.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 5 =>
               Ctx.Copy_Bitmap (digit_5.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 6 =>
               Ctx.Copy_Bitmap (digit_6.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 7 =>
               Ctx.Copy_Bitmap (digit_7.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 8 =>
               Ctx.Copy_Bitmap (digit_8.Data, (Digit_Pos_X, Digit_Pos_Y));
            when 9 =>
               Ctx.Copy_Bitmap (digit_9.Data, (Digit_Pos_X, Digit_Pos_Y));
         end case;
         --  All digits have the same size
         Digit_Pos_X := Digit_Pos_X + digit_0.Data.W;
      end Draw_Digit;

   begin
      if not This.Dirty and then not Force then
         return;
      end if;

      Ctx.Set_Color (Black);
      Ctx.Fill_Rectangle (((0, 0), This.Get_Size));

      Draw_Digit (Integer (This.Hours) / 10);
      Draw_Digit (Integer (This.Hours) mod 10);

      Ctx.Copy_Bitmap (colon.Data, (Digit_Pos_X, Digit_Pos_Y));
      Digit_Pos_X := Digit_Pos_X + colon.Data.W;

      Draw_Digit (Integer (This.Minutes) / 10);
      Draw_Digit (Integer (This.Minutes) mod 10);
   end Draw;

   --------------
   -- Set_Time --
   --------------

   procedure Set_Time
     (This    : in out Instance;
      Hours   : Clock_Hour;
      Minutes : Clock_Minute)
   is
   begin
      This.Hours   := Hours;
      This.Minutes := Minutes;
      This.Set_Dirty;
   end Set_Time;

   --------------
   -- Get_Time --
   --------------

   procedure Get_Time (This    : Instance;
                       Hours   : out Clock_Hour;
                       Minutes : out Clock_Minute)
   is
   begin
      Hours := This.Hours;
      Minutes := This.Minutes;
   end Get_Time;

   -------------------
   -- Required_Size --
   -------------------

   function Required_Size (This : Instance) return Size_T is
      ((4 * digit_0.Data.W + colon.Data.W, digit_0.Data.H));

end Clock_Widget;
