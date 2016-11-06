with Interfaces; use Interfaces;

package GUI is
   procedure Initialize;
   procedure Start;

   function Random (Modulo : Unsigned_32) return Unsigned_32;
end GUI;
