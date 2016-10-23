with Giza.Widget;
with Giza.Context;
with Giza.Types; use Giza.Types;

package Clock_Widget is

   type Clock_Hour is mod 24;
   type Clock_Minute is mod 60;

   subtype Parent is Giza.Widget.Instance;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := True);

   procedure Set_Time (This    : in out Instance;
                       Hours   : Clock_Hour;
                       Minutes : Clock_Minute);

   procedure Get_Time (This    : Instance;
                       Hours   : out Clock_Hour;
                       Minutes : out Clock_Minute);

   function Required_Size (This : Instance) return Size_T;
private

   type Instance is new Parent with record
      Hours   : Clock_Hour;
      Minutes : Clock_Minute;
   end record;

end Clock_Widget;
