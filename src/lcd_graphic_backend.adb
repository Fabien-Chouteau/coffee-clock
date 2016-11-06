with STM32; use STM32;
with STM32.DMA2D; use STM32.DMA2D;
with STM32.DMA2D_Bitmap;
with STM32.Board; use STM32.Board;
with HAL.Bitmap; use HAL.Bitmap;
with HAL; use HAL;
with Giza.Image.DMA2D;

package body LCD_Graphic_Backend is

   Initialized : Boolean := False;

   subtype Height is Integer range 0 .. 480 - 1;
   subtype Width is Integer range 0 .. 800 - 1;

   function Is_In_Screen (Pt : Point_T) return Boolean;
   function HAL_To_DMA2D (Mode : HAL.Bitmap.Bitmap_Color_Mode)
                          return STM32.DMA2D.DMA2D_Color_Mode;

   ------------------
   -- HAL_To_DMA2D --
   ------------------

   function HAL_To_DMA2D (Mode : HAL.Bitmap.Bitmap_Color_Mode)
                          return STM32.DMA2D.DMA2D_Color_Mode
   is
     (case Mode is
         when ARGB_8888 => DMA2D.ARGB8888,
         when RGB_888 => DMA2D.RGB888,
         when RGB_565 => DMA2D.RGB565,
         when ARGB_1555 => DMA2D.ARGB1555,
         when ARGB_4444 => DMA2D.ARGB4444,
         when L_8 => DMA2D.L8,
         when AL_44 => DMA2D.AL44,
         when AL_88 => DMA2D.AL88,
         when L_4 => DMA2D.L4,
         when A_8 => DMA2D.A8,
         when A_4 => DMA2D.A4);

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      if not Initialized then
         Initialized := True;

         --  Initialize LCD
         Display.Initialize;
         Display.Initialize_Layer (1, ARGB_8888);

         Display.Get_Hidden_Buffer (1).Fill ((Alpha => 255, others => 64));
         Display.Update_Layer (1, Copy_Back => True);
      end if;
   end Initialize;

   ------------------
   -- Is_In_Screen --
   ------------------

   function Is_In_Screen (Pt : Point_T) return Boolean is
   begin
      return Pt.X in Dim (Width'First) .. Dim (Width'Last)
        and then
          Pt.Y in Dim (Height'First) .. Dim (Height'Last);
   end Is_In_Screen;

   ---------------
   -- Set_Pixel --
   ---------------

   overriding procedure Set_Pixel (This : in out Instance; Pt : Point_T) is
   begin
      if Is_In_Screen (Pt) then
         Display.Get_Hidden_Buffer (1).Set_Pixel
           (X           => Pt.X,
            Y           => Pt.Y,
            Value       => This.RGB_Color);
      end if;
   end Set_Pixel;

   ---------------
   -- Set_Color --
   ---------------

   overriding procedure Set_Color (This : in out Instance; C : Giza.Colors.Color) is
   begin
      This.RGB_Color := (255, Byte (C.R), Byte (C.G), Byte (C.B));
   end Set_Color;

   ----------
   -- Size --
   ----------

   overriding function Size (This : Instance) return Size_T is
      pragma Unreferenced (This);
   begin
      return (Dim (Width'Last), Dim (Height'Last));
   end Size;

   -------------------------
   -- Has_Double_Buffring --
   -------------------------

   overriding function Has_Double_Buffring
     (This : Instance) return Boolean
   is
      pragma Unreferenced (This);
   begin
      return True;
   end Has_Double_Buffring;

   ------------------
   -- Swap_Buffers --
   ------------------

   overriding procedure Swap_Buffers (This : in out Instance) is
      pragma Unreferenced (This);
   begin
      Display.Update_Layer (1, Copy_Back => False);
      Display.Get_Hidden_Buffer (1).Fill ((Alpha => 255, others => 64));
   end Swap_Buffers;

   ---------------
   -- Rectangle --
   ---------------

   overriding procedure Rectangle (This : in out Instance;
                                   Start, Stop : Point_T) is
      X0 : constant Integer := Start.X;
      Y0 : constant Integer := Start.Y;
      X1 : constant Integer := Stop.X;
      Y1 : constant Integer := Stop.Y;
   begin
      if Is_In_Screen (Start) and then Is_In_Screen (Stop) then
         Display.Get_Hidden_Buffer (1).Draw_Rect (Color  => This.RGB_Color,
                                                  X      => X0,
                                                  Y      => Y0,
                                                  Width  => X1 - X0 + 1,
                                                  Height => Y1 - Y0 + 1);
      end if;
   end Rectangle;

   --------------------
   -- Fill_Rectangle --
   --------------------

   overriding procedure Fill_Rectangle (This : in out Instance;
                                        Start, Stop : Point_T) is
      X0 : constant Integer := Dim'Min (Start.X, Stop.X);
      Y0 : constant Integer := Dim'Min (Start.Y, Stop.Y);
      X1 : constant Integer := Dim'Max (Start.X, Stop.X);
      Y1 : constant Integer := Dim'Max (Start.Y, Stop.Y);
   begin
      if Is_In_Screen (Start) and then Is_In_Screen (Stop) then
         Display.Get_Hidden_Buffer (1).Fill_Rect (Color  => This.RGB_Color,
                                                  X      => X0,
                                                  Y      => Y0,
                                                  Width  => X1 - X0 + 1,
                                                  Height => Y1 - Y0 + 1);
      end if;
   end Fill_Rectangle;

   ----------------
   -- Draw_Image --
   ----------------

   overriding
   procedure Draw_Image
     (This : in out Instance;
      Img  : Giza.Image.Class;
      Pt   : Point_T)
   is
   begin
      if Img in Giza.Image.DMA2D.Class then
         declare
            DMA2D_Img : Giza.Image.DMA2D.Instance renames
              Giza.Image.DMA2D.Instance (Img);

            DMA2D_Mode : constant STM32.DMA2D.DMA2D_Color_Mode :=
              (case DMA2D_Img.Mode is
                  when Giza.Image.DMA2D.RGB888 => STM32.DMA2D.RGB888,
                  when Giza.Image.DMA2D.L8 => STM32.DMA2D.L8,
                  when Giza.Image.DMA2D.L4 => STM32.DMA2D.L4);

            DMA2D_Buffer : STM32.DMA2D.DMA2D_Buffer (Color_Mode => DMA2D_Mode);
         begin

            case DMA2D_Img.Mode is
               when Giza.Image.DMA2D.RGB888 =>
                  DMA2D_Buffer.Addr :=
                    DMA2D_Img.RGB888_Data (DMA2D_Img.RGB888_Data'First)'Address;
               when Giza.Image.DMA2D.L8 =>
                  DMA2D_Buffer.CLUT_Color_Mode := STM32.DMA2D.RGB888;
                  DMA2D_Buffer.CLUT_Addr :=
                    DMA2D_Img.L8_CLUT (DMA2D_Img.L8_CLUT'First)'Address;
                  DMA2D_Buffer.Addr :=
                    DMA2D_Img.L8_Data (DMA2D_Img.L8_Data'First)'Address;
               when Giza.Image.DMA2D.L4 =>
                  DMA2D_Buffer.CLUT_Color_Mode := STM32.DMA2D.RGB888;
                  DMA2D_Buffer.CLUT_Addr :=
                    DMA2D_Img.L4_CLUT (DMA2D_Img.L4_CLUT'First)'Address;
                  DMA2D_Buffer.Addr :=
                    DMA2D_Img.L4_Data (DMA2D_Img.L4_Data'First)'Address;
            end case;

            DMA2D_Buffer.Width := DMA2D_Img.W;
            DMA2D_Buffer.Height := DMA2D_Img.H;

            STM32.DMA2D.DMA2D_Copy_Rect
              (Src_Buffer  => DMA2D_Buffer,
               X_Src       => 0,
               Y_Src       => 0,
               Dst_Buffer  => STM32.DMA2D_Bitmap.To_DMA2D_Buffer
                 (Display.Get_Hidden_Buffer (1)),
               X_Dst       => Pt.X,
               Y_Dst       => Pt.Y,
               Bg_Buffer   => STM32.DMA2D.Null_Buffer,
               X_Bg        => 0,
               Y_Bg        => 0,
               Width       => DMA2D_Img.Size.W,
               Height      => DMA2D_Img.Size.H,
               Synchronous => False);
         end;
      else
         Draw_Image (Parent (This), Img, Pt);
      end if;
   end Draw_Image;

end LCD_Graphic_Backend;
