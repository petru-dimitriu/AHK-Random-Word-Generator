HaveModified_Templates=0
FileRead,FileTemplates,%OutDir%\Templates_%Name%.sgr
Gui, 10: Destroy
Gui, 11: Font, S8 CDefault, tahoma
Gui, 11: Add, Text, x16 y20 w450 h20 , These templates represent the formats after which words will be created.
Gui, 11: Add, Text, x16 y50 w440 h70 , In order to define templates`, write the templates below separating them by new line`, without leaving empty spaces at the end (ex. if you've got the "v" and "c" symbols you may form templates vccv`, vcvc`, cvcv`, cvvc`, etc.).
Gui, 11: Add, GroupBox, x16 y130 w380 h220 , Templates
Gui, 11: Add, Edit, x0 y0 h0 w0,
Gui, 11: Add, Edit, x26 y150 w360 h190 vFileTemplates gFileTemplates, %FileTemplates%
Gui, 11: Add, Button, x406 y170 w60 h30 gSaveTemplates vSaveTemplates +Default, Save
Gui, 11: Add, Button, x406 y200 w60 h30 gQuitTemplates, Close
Gui, 11: Add, Button, x406 y230 w60 h30 , List
Gui, 11: -SysMenu -MinimizeBox
Gui, 11: Show, Center h377 w477, Templates %Name%
Return

FileTemplates:
  HaveModified_Templates=1
Return

SaveTemplates:
  HaveModified_Templates=0
  Gui,11:Submit,NoHide
  FileDelete,%OutDir%\Templates_%Name%.sgr
  FileAppend,%FileTemplates%,%OutDir%\Templates_%Name%.sgr
  GuiControl,11:Disable,SaveTemplates
  GuiControl,11:,SaveTemplates,Done
  Sleep 250
  GuiControl,11:Enable,SaveTemplates
  GuiControl,11:,SaveTemplates,Save
Return

QuitTemplates:
  If HaveModified_Templates
      MsgBox 36, Save, You've done some changes without saving them. Do you want to save them now?
  IfMsgBox yes
      Gosub SaveTemplates
  Gui, 11: Destroy
  Open(path)
Return
