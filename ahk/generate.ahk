GenerateNow:
Gui, 90: Font,,tahoma
Gui, 90: Add, Edit, x16 y20 w760 h20 vword1,
Gui, 90: Add, Edit, x16 y50 w760 h20 vword2,
Gui, 90: Add, Edit, x16 y80 w760 h20 vword3,
Gui, 90: Add, Edit, x16 y110 w760 h20 vword4,
Gui, 90: Add, Edit, x16 y140 w760 h20 vword5,
Gui, 90: Add, Edit, x16 y170 w760 h20 vword6,
Gui, 90: Add, Edit, x16 y200 w760 h20 vword7,
Gui, 90: Add, Edit, x16 y230 w760 h20 vword8,
Gui, 90: Add, Edit, x16 y260 w760 h20 vword9,
Gui, 90: Add, Edit, x16 y290 w760 h20 vword10,
/*
Gui, 90: Add, Button, x776 y20 w70 h20 , Save
Gui, 90: Add, Button, x776 y50 w70 h20 , Save
Gui, 90: Add, Button, x776 y80 w70 h20 , Save
Gui, 90: Add, Button, x776 y110 w70 h20 , Save
Gui, 90: Add, Button, x776 y140 w70 h20 , Save
Gui, 90: Add, Button, x776 y170 w70 h20 , Save
Gui, 90: Add, Button, x776 y200 w70 h20 , Save
Gui, 90: Add, Button, x776 y230 w70 h20 , Save
Gui, 90: Add, Button, x776 y260 w70 h20 , Save
Gui, 90: Add, Button, x776 y290 w70 h20 , Save
*/
Gui, 90: Add, Button, x306 y320 w100 h30 gGenerateMore, More...
Gui, 90: Add, Button, x426 y320 w100 h30 g90GuiClose, Close
Gui, 90: -minimizebox
Menu, Generation, Add, Generate new words, GenerateMore
Menu, Generation, Add, Generate in file..., GenerateToFile
Menu, Generation, Add,
Menu, Generation, Add, Exit, 90GuiClose
Menu, GenerationMenuBar, Add, Generate, :Generation
Gui, 90: Menu, GenerationMenuBar
Gui, 90: Show, center h354 w852, Generating words...

loop 10
{
gosub,ProduceWord
guicontrol,90:, word%A_Index%,%word%
Gui, 90: Show, center h354 w852, Generating words... %A_index%0`%
}
Gui, 90: Show, center h354 w852, Word generator
Return

90GuiClose:
gui,90:destroy
Menu, GenerationMenuBar,DeleteAll
Menu, Generation, DeleteAll
return

GenerateMore:
gosub,90GuiClose
goto, GenerateNow
return

GenerateToFile:
#include autogen.ahk
return

ProduceWord:
    Random,row,1,%nrTemplates%
    FileReadLine,ChosenTemplate,%OutDir%\Templates_%Name%.sgr,%row%
    y:=0
    word:=
    Loop,Parse,ChosenTemplate
      {
        y++
        x:=0
        file:=A_LoopField
        Loop,Read,%OutDir%\%file%.lgr
            x++
        Found:=0
        While !Found
        {
          Random,row,1,%x%
          FileReadLine,InputLine,%OutDir%\%file%.lgr,%row%
          WordPiece:=InputLine
          Pos:=InStr(WordPiece,A_Space)
          StringTrimRight,WordPiece,WordPiece,StrLen(WordPiece)-pos+1
          z:=0
          Loop,Parse,InputLine,%A_Space%
            {
              z++
              If z=2
                  Frecv1:=A_LoopField
              If z=3
                  Frecv2:=A_LoopField
              If z=4
                  Frecv3:=A_LoopField
            }
          Random,rand,1,100
          If y=1
            {
              If rand<%frecv1%
                {
                  word=%word%%WordPiece%
                  Found:=1
                }
            }
          Else If y = % StrLen(ChosenTemplate)
            {
              If rand<%frecv3%
                {
                  word=%word%%WordPiece%
                  Found:=1
                }
            }
          Else
            {
              If rand<%frecv2%
                {
                  word=%word%%WordPiece%
                  Found:=1
                }
            }
        }
  }
return