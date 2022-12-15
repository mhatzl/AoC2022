with Spark_Unbound.Arrays;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Ada.Text_IO; use Ada.Text_IO;

procedure Aoc2022_P1 is
   package ElfCaloriesArrays is new Spark_Unbound.Arrays(Element_Type => Natural, Index_Type => Positive);

   F: File_Type;
   File_Name: constant String := "testinput.txt";
   Line: Unbounded_String;
   ElfCalories: ElfCaloriesArrays.Unbound_Array := ElfCaloriesArrays.To_Unbound_Array(Initial_Capacity => 10);
   CurrentElf: Positive := 1;
   CurrentCalories: Natural := 0;
   LineCalories: Natural := 0;
   Success: Boolean;
begin
   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
      Set_Unbounded_String(Line, Get_Line (F));
      if Line = "" then
         ElfCaloriesArrays.Append(ElfCalories, CurrentCalories, Success);
         if not Success then
            return;
         end if;
         CurrentCalories := 0;
         CurrentElf := CurrentElf + 1;
      else
         LineCalories := Natural'Value(To_String(Line));
         CurrentCalories := CurrentCalories + LineCalories;
      end if;
   end loop;
   Close (F);

   declare
      MaxCalories: Natural := 0;
      SecMaxCalories: Natural := 0;
      ThirdMaxCalories: Natural := 0;
      TotalCalories: Natural := 0;
   begin
      for Elf in ElfCaloriesArrays.First_Index(ElfCalories) .. ElfCaloriesArrays.Last_Index(ElfCalories) loop
         if ElfCaloriesArrays.Element(ElfCalories, Elf) > MaxCalories then
            ThirdMaxCalories := SecMaxCalories;
            SecMaxCalories := MaxCalories;
            MaxCalories := ElfCaloriesArrays.Element(ElfCalories, Elf);
         elsif ElfCaloriesArrays.Element(ElfCalories, Elf) > SecMaxCalories then
            ThirdMaxCalories := SecMaxCalories;
            SecMaxCalories := ElfCaloriesArrays.Element(ElfCalories, Elf);
         elsif ElfCaloriesArrays.Element(ElfCalories, Elf) > ThirdMaxCalories then
            ThirdMaxCalories := ElfCaloriesArrays.Element(ElfCalories, Elf);
         end if;
      end loop;
      TotalCalories := MaxCalories + SecMaxCalories + ThirdMaxCalories;
      Put_Line(TotalCalories'Image);
   end;
end Aoc2022_P1;
