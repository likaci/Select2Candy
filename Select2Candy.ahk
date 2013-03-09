;在第60行，请修改调用candy的方式
SetWorkingDir,%A_ScriptDir%
CoordMode, Mouse, Screen
menu, tray, Icon,candy.ico
~LButton up::
	if HasGui
	{
		gui,Destroy
		HasGui := 0
		return
	}
	WinGetActiveTitle,activetitle
	if !activetitle
		return
	clipboardBefore := clipboard
	CanCandy := 0
	mousegetpos,xBefore,yBefore
	xBefore+=16
	yBefore+=16
	send ^c
    If ErrorLevel
		return
	if clipboardBefore != %clipboard%
	{
		ShowGui()
		clipboard := clipboardBefore
	}
	else
		ToolTip 
return

ShowGui(){
	global
	Gui, Margin ,0,0
	Gui, Add, Picture,w25 h25,candy.ico
	;Gui, Add, Text, ,Candy it!
	Gui, -Caption +AlwaysOnTop -SysMenu +Owner
	Gui, Show, NoActivate X%XBefore% Y%YBefore%, 
	Gui +LastFound
	WinSet, Transparent, 90,
	OnMessage(0x200, "WM_MOUSEMOVE")
	OnMessage(0x201, "WM_LBUTTONDOWN")
	HasGui := 1
	return
}

WM_MOUSEMOVE()
{
	Gui +LastFound
	WinSet, Transparent, off,
	return
}

WM_LBUTTONDOWN()
{
	global
	gui,Destroy
	winactivate,%activetitle%
	winwaitactive,%activetitle%
	send {lButton up}
	send {Ctrl down}{RButton}{Ctrl up}
	return
}
