with Screen_Interface; use Screen_Interface;
with Giza.GUI; use Giza.GUI;
with Giza.Context;
with Clock_Window;

pragma Warnings (Off, "*not referenced");
with Utils;
pragma Warnings (On, "*not referenced");

procedure GUI_Test is
begin

   Screen_Interface.Initialize;

   Giza.GUI.Set_Context (new Giza.Context.Instance);
   Giza.GUI.Set_Backend (new Screen_Interface.GTKada_Backend);

   Push (new Clock_Window.Instance);

   Event_Loop;
end GUI_Test;
