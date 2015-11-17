Gui, 99: Destroy
Gui, 99: Font,s8,tahoma
Gui, 99: Add, GroupBox, x16 y20 w370 h110 ,
Gui, 99: Add, Text, x26 y50 w80 h20 , No. of words:
Gui, 99: Add, Text, x26 y80 w80 h20 , File:
Gui, 99: Add, Edit, x106 y50 w270 h20 vWordsToGenerate,
Gui, 99: Add, UpDown, w20 h20 , 10
Gui, 99: Font,s7
Gui, 99: Add, Edit, x106 y80 w250 h20 ReadOnly vFileToGenerateIn,
Gui, 99: Font,s8
Gui, 99: Add, Button, x356 y80 w30 h20 gBrowseForFileToGenerateIn, B
Gui, 99: Add, Button, x106 y140 w80 h30 gDoGenerateFile, Generate
Gui, 99: Add, Button, x196 y140 w80 h30 g99GuiClose, Cancel
Gui, 99: -SysMenu -minimizebox
Gui, 99: Show, Center h194 w400, Generate words in file
Return

BrowseForFileToGenerateIn:
  FileSelectFile,FileToGenerateIn,S,,Name the file where the words will be stored.,Text files (*.txt)
  If !ErrorLevel
    {
      If InStr(FileToGenerateIn,".")=0
          FileToGenerateIn = %FileToGenerateIn%.txt
      GuiControl,99:,FileToGenerateIn,%FileToGenerateIn%
    }
Return

99GuiClose:
  Gui,99:Destroy
Return

DoGenerateFile:
  Gui, 99: Submit, NoHide
  If FileToGenerateIn=
    {
      MsgBox 16, Generate words, You must specify a word before continuing.
      Return
    }
  IfExist,%FileToGenerateIn%
    {
      MsgBox 52,Warning,The file %FileToGenerateIn% already exists. If you continue`, it will be overwritten. Do you want to continue?
      IfMsgBox No
          Return
    }
  FileDelete, %FileToGenerateIn%
  Gui, 99: Destroy
  Gui, 99: Font,,tahoma
  Gui, 99: Add, Text, x6 y10 w460 h20 vGenerationText, Generating words...
  Gui, 99: Add, Progress, x6 y40 w460 h20 -smooth vFileGenerationProgress,
; Gui, 99: Add, Button, x193 y63 w89 h24 , Oprire
  Gui, 99: -MinimizeBox -SysMenu
  Gui, 99: Show, Center h94 w477, Automatic word generating
  Loop %WordsToGenerate%
    {
      Gosub,ProduceWord
      FileAppend,%word%`n,%FileToGenerateIn%
      percent:=Round((A_Index/WordsToGenerate) * 100)
      GuiControl, 99:,GenerationText,Generating words... %word%
      GuiControl, 99:,FileGenerationProgress,%percent%
      Gui, 99: Show, Center h94 w477, Automatic word generating (%percent% `%)
    }
  Gui, 99: Destroy
  MsgBox 64,Generate words in file,%WordsToGenerate% words were generated.
Return
