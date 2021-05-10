#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;屏幕分区方式切换（需罗技软件设置XButton2为ctrl+alt+win）
 ^#!XButton1::
	if FZN=0
		{
		SendInput #^!{1}
		FZN:=1
		}
	else
		{
		SendInput #^!{2}
		FZN:=0
		} 
	return


;窗口置顶
^#!RButton::
	WinSet, AlwaysOnTop, toggle,A
	WinGetTitle, getTitle, A
	Winget, getTop,ExStyle,A
	if (getTop & 0x8)
	TrayTip 已置顶, 窗口标题: `n%getTitle%,10,1
	else
	TrayTip 取消置顶, 窗口标题:`n %getTitle%,10,1
	return


;ipad 屏幕
^#!Down::^#!9


;右Shift英文，左Shift中文
~RShift::
	SwitchIME(0x04090409)
	IME_GET(WinTitle="1")
	return
~LShift::
	SwitchIME(00000804)
	return

SwitchIME(dwLayout){
	HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
	ControlGetFocus,ctl,A
	SendMessage,0x50,0,HKL,%ctl%,A
	}

IME_GET(WinTitle="")
;-----------------------------------------------------------
; IMEの状態の取得
;    対象： AHK v1.0.34以降
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;-----------------------------------------------------------
{
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
 
    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

;架空数字锁定键
NumpadIns::Numpad0
NumpadEnd::Numpad1
NumpadDown::Numpad2
NumpadPgDn::Numpad3
NumpadLeft::Numpad4
NumpadClear::Numpad5
NumpadRight::Numpad6
NumpadHome::Numpad7
NumpadUp::Numpad8
NumpadPgUp::Numpad9


;# Office 相关
	#IfWinActive ahk_exe WINWord.exe
Tab::End

	#IfWinActive






;# Obsidian 相关设置
	#IfWinActive ahk_exe Obsidian.exe
Tab::End

+Space::
	SendInput, {Space 4}

;CapsLock改为预览、编辑模式
CapsLock:: ^e

;## 数字锁定作为公式模式


>+4::
	{
	state := GetKeyState("NumLock", "T")
	if state = 1
		SendInput, {text}$
	else
		SendInput, +{4 2}{Left}
	Return
	}


/::
	{
	state := GetKeyState("NumLock", "T")
	if state = 1
		SendInput, /
	else
		SendInput, \over
	Return
	}



;### 上下角标
+Up::
	{
	state := GetKeyState("NumLock", "T")
	if state = 1
		{
		SwitchIME(0x04090409)
		SendInput, <sup></sup>{Left 6}
		SwitchIME(00000804)
		
		Return
		}
	else
		SendInput, {text}^{}
		SendInput, {Left}
	Return
	}

	

+Down::
	{
	state := GetKeyState("NumLock", "T")
	if state = 1
		{
		SwitchIME(0x04090409)
		SendInput, <sub></sub>{Left 6}
		SwitchIME(00000804)
		
		Return
		}
	else
		SendInput, {text}_{}
		SendInput, {Left}
	Return
	}






;## 回车直跳下一行
^Enter::
	{
	SendInput, {End}{Enter}
	Return
	}

;## 快捷插入超链接
Ins:: 
	{
	Input, UserInput, V, {Enter}
	Len := StrLen(UserInput)+1
	
	SendInput, {BackSpace %Len%}[ %UserInput% ](%Clipboard%)
	
	Return
	}




	#IfWinActive
