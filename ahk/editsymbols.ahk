Editaresymbol(symbol)
  {
    global LetterList, LetterListItem, StartingText, MiddleText, FinalText, Fec1, Fec2, Fec3, OutDir,
    Menu,SymbolFile,add,Save,SaveSymbol
    Menu,SymbolFile,add,
    Menu,SymbolFile,add,Import...,ImportSymbol
    Menu,SymbolFile,add,Export...,ExportSymbol
    Menu,ManipulateSymbol,add,Add,AddLetter
    Menu,ManipulateSymbol,add,Remove,RemoveLetter
    Menu,ManipulateSymbol,add,
    Menu,ManipulateSymbol,add,Add from file...,AddLetterFromFile
    Menu,SymbolMenuBar,add,Symbol,:SymbolFile
    Menu,SymbolMenuBar,add,Elements,:ManipulateSymbol
    LetterList=
    Loop,Read,%OutDir%\%symbol%.lgr
      {
        LetterList=%LetterList%|%A_LoopReadLine%
      }
    StringReplace,LetterList,LetterList,|,,
    Gui, 13: Font, S8 CDefault, Tahoma
    Gui, 13: Add, Text, x6 y10 w370 h60 , Here you can edit the letters/grouping represented by "%symbol%". Elements are shown below in this form: <element> <freq 1> <freq 2> <freq 3>. Select an element and use the controls below to modify it.
    Gui, 13: Add, GroupBox, x6 y70 w370 h190 , List
    Gui, 13: Add, ListBox, x16 y90 w350 h160 vLetterListItem gLetterList, %LetterList%
    Gui, 13: Add, Button, x16 y270 w60 h30 gAddLetter, Add
    Gui, 13: Add, Button, x16 y300 w60 h30 gRemoveLetter, Remove
    Gui, 13: Add, GroupBox, x86 y260 w290 h70 , Appearance frequencies
    Gui, 13: Font, S7 CDefault, Tahoma
    Gui, 13: Add, Text, x96 y282 w60 h10 Disabled vStartingText, At the start:
    Gui, 13: Add, Slider, x155 y277 w192 h19 Disabled vFec1 gFec1, 0
    Gui, 13: Add, Text, x96 y297 w60 h10 Disabled vMiddleText, In the middle:
    Gui, 13: Add, Slider, x155 y295 w192 h19 Disabled vFec2 gFec2, 0
    Gui, 13: Add, Text, x96 y313 w60 h10 Disabled vFinalText, At the end:
    Gui, 13: Add, Slider, x155 y310 w192 h19 Disabled vFec3 gFec3, 0
    Gui, 13: Menu, SymbolMenuBar
    Gui, 13: -MinimizeBox
    Gui, 13: Show, Center h352 w393, Edit symbol %symbol%
    Return %symbol%
  }

13GuiClose:
if LettersChanged
{
msgbox 36,symbol,You've made some changes in %symbol% without saving them. Do you want to save them now?
ifmsgbox, yes
gosub,SaveSymbol
}
  LettersChanged:=0
  Gui,13:Destroy
  Menu,SymbolFile,DeleteAll
  Menu,ManipulateSymbol,DeleteAll
  Menu,SymbolMenuBar,DeleteAll
Return

LetterList:
  Gui,13: Submit, NoHide
  If not(LetterListItem=%nul%)
    {
      GuiControl, 13: Enable, StartingText
      GuiControl, 13: Enable, MiddleText
      GuiControl, 13: Enable, FinalText
      GuiControl, 13: Enable, Fec1
      GuiControl, 13: Enable, Fec2
      GuiControl, 13: Enable, Fec3
    }
  Loop,Parse,LetterListItem,%A_Space%
    {
      If A_Index=1
          LiteraSelectata=%A_LoopField%
      If A_Index=2
        {
          GuiControl,13:,Fec1,%A_LoopField%
          Fec1_vechi:=A_LoopField
        }
      If A_Index=3
        {
          GuiControl,13:,Fec2,%A_LoopField%
          Fec2_vechi:=A_LoopField
        }
      If A_Index=4
        {
          GuiControl,13:,Fec3,%A_LoopField%
          Fec3_vechi:=A_LoopField
        }
    }
Return


Fec1:
  Gui,13:Submit,NoHide
  StringReplace,LetterList,LetterList,%LiteraSelectata% %Fec1_vechi% %Fec2% %Fec3%,%LiteraSelectata% %Fec1% %Fec2% %Fec3%
  GuiControl,13:,LetterListItem,|%LetterList%
  Fec1_vechi:=Fec1
  GuiControl, 13: ChooseString, LetterListItem,%LiteraSelectata% %Fec1% %Fec2% %Fec3%
Return

Fec2:
  Gui,13:Submit,NoHide
  StringReplace,LetterList,LetterList,%LiteraSelectata% %Fec1% %Fec2_vechi% %Fec3%,%LiteraSelectata% %Fec1% %Fec2% %Fec3%
  GuiControl,13:,LetterListItem,|%LetterList%
  Fec2_vechi:=Fec2
  GuiControl, 13: ChooseString, LetterListItem,%LiteraSelectata% %Fec1% %Fec2% %Fec3%
Return

Fec3:
  Gui,13:Submit,NoHide
  StringReplace,LetterList,LetterList,%LiteraSelectata% %Fec1% %Fec2% %Fec3_vechi%,%LiteraSelectata% %Fec1% %Fec2% %Fec3%
  GuiControl,13:,LetterListItem,|%LetterList%
  Fec3_vechi:=Fec3
  GuiControl, 13: ChooseString, LetterListItem,%LiteraSelectata% %Fec1% %Fec2% %Fec3%
Return

AddLetter:
  InputBox,AddedLetter,Add letter/group of letters,Write the letter or group of letters for which you will set a frequency of appearance.
  If !ErrorLevel
    {
      if LetterList<>
      LetterList=%LetterList%|%AddedLetter% 0 0 0
      else
      LetterList=%AddedLetter% 0 0 0
      GuiControl,13:,LetterListItem,|%LetterList%
      LettersChanged:=1
    }
Return

RemoveLetter:
  Gui,13: Submit,NoHide
  If not (LetterListItem=%nul%)
    {
      MsgBox,52,Warning,Are you sure you want to remove this?`nWARNING: This is irreversible.
      IfMsgBox yes
        {
          StringReplace,LetterList,LetterList,%LetterListItem%,
          StringReplace,LetterList,LetterList,||,|
          aux:=SubStr(LetterList,1,1)
          If aux = |
              StringReplace,LetterList,LetterList,|,
          aux:=
          GuiControl,13:,LetterListItem,|%LetterList%
          GuiControl, 13: Disable, StartingText
          GuiControl, 13: Disable, MiddleText
          GuiControl, 13: Disable, FinalText
          GuiControl, 13: Disable, Fec1
          GuiControl, 13: Disable, Fec2
          GuiControl, 13: Disable, Fec3
          GuiControl, 13: , Fec1 , 0
          GuiControl, 13: , Fec2 , 0
          GuiControl, 13: , Fec3 , 0
          LettersChanged:=1
        }
    }
  Else
      MsgBox,48,No element selected,You must select an element before trying to remove it.
Return

SaveSymbol:
  FileContents:=LetterList
  StringReplace,FileContents,FileContents,|,`n,ALL
  FileDelete,%OutDir%\%symbol%.lgr
  FileAppend,%FileContents%,%OutDir%\%symbol%.lgr
  LettersChanged:=0
Return

ImportSymbol:
ExportSymbol:
AddLetterFromFile:
Return
