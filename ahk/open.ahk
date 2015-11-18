Open(path)
  {
    global OutDir, name, author, type, nrTemplates


    IfNotExist,%path%
      {
        MsgBox 16,Error,The specified project does not exist.
        Return
      }
    Else
      {
        FileReadLine,name,%path%,1
        FileReadLine,author,%path%,2
        FileReadLine,type,%path%,3
        nrTemplates:=0
        SplitPath,path,,OutDir

        Loop,Read,%OutDir%\Templates_%name%.sgr
            nrTemplates++

        Loop %OutDir%\*.lgr
            nrSymbols++

        Gui, 1: hide
Gui, 10: Font, S7 CDefault Bold, tahoma
Gui, 10: Add, Text, x6 y20 w120 h410 , Project: %name%`nAuthor: %author%`nType: %type%
Gui, 10: Font, S8, tahoma
Gui, 10: Add, GroupBox, x139 y19 w364 h200 , Word creation
Gui, 10: Font, , 
Gui, 10: Font, S8, tahoma
Gui, 10: Add, Text, x146 y40 w350 h70 , Words are generated randomly based on some templates (ex. vowel-consonant-vowel-consonant-vowel, etc). These are stored as symbol-strings (ex. vcvcv). Both the symbols and the letters/letter groups they may represent can be manually edited.
Gui, 10: Add, Text, x146 y132 w130 h20 , No. of templates: %nrTemplates%
Gui, 10: Add, Text, x146 y161 w132 h20 , No. of symbols: %nrSymbols%
Gui, 10: Add, Button, x275 y129 w156 h25 gViewTemplates, View/edit templates
Gui, 10: Add, Button, x275 y157 w156 h25 gViewSymbols, View/edit symbols
Gui, 10: Add, Button, x153 y188 w343 h26 gCreateWordsNow, Generate words using existing templates and symbols
Gui, 10: Add, Button, x209 y233 w100 h30 gCloseProject, Exit
Gui, 10: Show, center h271 w521, Project %path%
        Return %path%
      }
  }

10GuiClose:
CloseProject:
  Gui, 10: Destroy
  Gui, 1: show
Return

ViewTemplates:
#Include templates.ahk
Return

ViewSymbols:
#Include symbols.ahk
Return

CreateWordsNow:
#Include generate.ahk
return