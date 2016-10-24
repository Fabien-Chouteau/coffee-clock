with Giza.Widget.Button;
use Giza.Widget;

with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Dialog_Window;
with Date_Widget;

package Date_Select_Window is

   subtype Parent is Dialog_Window.Instance;
   type Instance is new Parent (Panel_Size => 80)
   with private;

   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);
   overriding
   procedure On_Displayed (This : in out Instance);
   overriding
   procedure On_Hidden (This : in out Instance);

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean;

   procedure Set_Date (This        : in out Instance;
                       Day         : Date_Widget.Day_T;
                       Day_Of_Week : Date_Widget.Day_Of_Week_T;
                       Month       : Date_Widget.Month_T;
                       Year        : Date_Widget.Year_T);

   procedure Get_Date (This        : in out Instance;
                       Day         : out Date_Widget.Day_T;
                       Day_Of_Week : out Date_Widget.Day_Of_Week_T;
                       Month       : out Date_Widget.Month_T;
                       Year        : out Date_Widget.Year_T);

private

   type Instance is new Parent (Panel_Size => 80)
   with record
      Up_M, Down_M, Up_D, Down_D, Up_Y, Down_Y : aliased Button.Instance;
      Date : aliased Date_Widget.Instance (Show_Day_Of_Week => False);
   end record;
end Date_Select_Window;
