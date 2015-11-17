OpenSymbols:
Gui, 10: Destroy
Gui, 12: Destroy
Gui, 12: Font, S8 CDefault, tahoma
Gui, 12: Add, Text, x6 y10 w360 h65 , Each symbol represents a possible letter or letter group. Each letter or grouping has three associated frequencies - one sets how frequent the element will be at the beggining at the word, the second one represents frequency in the middle of the word, and the third one represents frequency at the end of the word.
Gui, 12: Add, ListBox, x6 y100 w360 h199 vSymbolList,
Gui, 12: Add, Button, x11 y330 w70 h30 gAddSymbol, Add
Gui, 12: Add, Button, x81 y330 w70 h30 gRemoveSymbol, Remove
Gui, 12: Add, Button, x151 y330 w70 h30 gEditSymbol, Edit
Gui, 12: Add, Button, x226 y330 w70 h30 gCloseSymbolsWindow, Close
;Gui, 12: Add, Button, x296 y330 w70 h30 , Template list
Gui, 12: -minimizebox
Gui, 12: Add, GroupBox, x6 y80 w360 h240 , Present symbols
Loop %OutDir%\*.lgr
  {
    SplitPath, A_LoopFileFullPath,,,,element_lista
    GuiControl, 12:,SymbolList,%element_lista%
  }
Gui, 12: Show, Center h377 w383, %Name% symbols
Return

12GuiClose:
CloseSymbolsWindow:
  Gui, 12: Destroy
  Open(path)
Return

EditSymbol:
  Gui,12: Submit, NoHide
  symbol:=Editaresymbol(SymbolList)
Return

AddSymbol:
  InputBox,WrittenSymbol,Symbol,Write the new symbol:
  If !ErrorLevel
      If StrLen(WrittenSymbol)>1
        {
          MsgBox,16,Error,The symbol must be one single character.
          Return
        }
      Else
          GuiControl, 12:,SymbolList,%WrittenSymbol%
Return

RemoveSymbol:
Gui, 12: submit, nohide
Gui, 99: Font,, tahoma
Gui, 99: Add, Button, x28 y139 w75 h23 gDeletesymbol, Remove
Gui, 99: Add, Button, x109 y139 w75 h23 g99GuiClose, Cancel
Gui, 99: Add, Picture,x10 y10 Icon2 , user32.dll
Gui, 99: Add, Text, x56 y13 w230 h118 , Are you sure you want to remove this symbol and also all the letters/groupings it may conain? THIS IS IRREVERSIBLE. Also`, you may keep a copy of it in order to use it later. To do this`, click Export.
Gui, 99: Add, Button, x189 y139 w75 h23 , Export
Gui, 99: +WS_DLGFRAME -SysMenu -MinimizeBox
Gui, 99: Show, center h171 w294, Remove symbol
return

DeleteSymbol:
gui,99: destroy
FileDelete,%OutDir%\%SymbolList%.lgr
goto OpenSymbols
return
