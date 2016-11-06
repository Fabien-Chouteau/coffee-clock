with Giza.Widget.Button;
use Giza.Widget;
with Giza.Context;
with Giza.Window;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Settings_Window;
with Clock_Widget;
with Date_Widget;

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

   procedure Set_Time (This    : in out Instance;
                       Hours   : Clock_Widget.Clock_Hour;
                       Minutes : Clock_Widget.Clock_Minute);

   procedure Set_Date (This        : in out Instance;
                       Day         : Date_Widget.Day_T;
                       Day_Of_Week : Date_Widget.Day_Of_Week_T;
                       Month       : Date_Widget.Month_T;
                       Year        : Date_Widget.Year_T);
private

   type Instance is new Parent with record
      Settings_Btn : aliased Button.Instance;
      Settings     : aliased Settings_Window.Instance;
      Clock        : aliased Clock_Widget.Instance;
      Date         : aliased Date_Widget.Instance (Show_Day_Of_Week => True);
   end record;
end Clock_Window;
