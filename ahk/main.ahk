#SingleInstance,Force
Menu, File, add, New project, CreatedeProject
Menu, File, add, Open project, OpenProject
Menu, File, add,
Menu, File, add, Exit, GuiClose
Menu, Help, add, About, About
Menu, MenuBar, add, File, :File
Menu, MenuBar, add, Help, :Help
Gui, Font, S15 CDefault Bold, tahoma
Gui, Add, Text, x26 y10 w430 h30 , Random Word Generating App
Gui, Font, , 
Gui, Font, S8, tahoma
Gui, Add, Text, x26 y50 w430 h20 , Petru Dimitriu, 2009
Gui, Show, center h86 w472, Random Word Generating App
Gui, Menu, MenuBar
return

CreatedeProject:
#Include create.ahk
Return

OpenProject:
  FileSelectFile, DeDeschis , 1, , Choose the project file you wish to open, Project file (*.gra)
  If !ErrorLevel
      path:=Open(DeDeschis)
Return

About:
msgbox 64, About,
(
The Random Word Generating App

Petru Dimitriu 2009
)
Return

GuiClose:
  ExitApp

#Include Open.ahk
#Include editsymbols.ahk
