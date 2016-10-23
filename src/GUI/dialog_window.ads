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
