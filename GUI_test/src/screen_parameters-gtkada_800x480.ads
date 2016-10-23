with Cairo;
with Cairo.Image_Surface; use Cairo.Image_Surface;

package Screen_Parameters is
   subtype Width is Natural range 0 .. 799;
   subtype Height is Natural range 0 .. 479;
   subtype Color is ARGB32_Data;
end Screen_Parameters;
