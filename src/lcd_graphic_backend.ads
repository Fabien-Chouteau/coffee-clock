with Giza.Colors;
with HAL;
with HAL.Bitmap;
with Giza.Backend; use Giza.Backend;
with Giza.Types; use Giza.Types;
with Giza.Image;

-------------------------
-- LCD_Graphic_Backend --
-------------------------

package LCD_Graphic_Backend is

   procedure Initialize;

   subtype Parent is Giza.Backend.Instance;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure Set_Pixel (This : in out Instance; Pt : Point_T);

   overriding
   procedure Set_Color (This : in out Instance; C : Giza.Colors.Color);

   overriding
   function Size (This : Instance) return Size_T;

   overriding
   function Has_Double_Buffring (This : Instance) return Boolean;

   overriding
   procedure Swap_Buffers (This : in out Instance);

   overriding
   procedure Rectangle (This : in out Instance; Start, Stop : Point_T);

   overriding
   procedure Fill_Rectangle (This : in out Instance; Start, Stop : Point_T);

   overriding
   procedure Draw_Image
     (This : in out Instance;
      Img  : Giza.Image.Class;
      Pt   : Point_T);

private
   type Instance is new Parent with record
      RGB_Color : HAL.Bitmap.Bitmap_Color;
   end record;
end LCD_Graphic_Backend;
